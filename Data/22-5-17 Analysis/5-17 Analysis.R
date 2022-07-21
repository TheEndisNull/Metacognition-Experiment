#====
#Read in data
startup <- function() {
  renv::isolate()
  packages <- c('tidyverse', 'Cairo', 'dqrng', 'readr')
  
  installed_packages <- packages %in% rownames(installed.packages())
  if (any(installed_packages == FALSE)) {
    install.packages(packages[!installed_packages])
  }
  invisible(lapply(packages, library, character.only = TRUE))
  rm(packages, installed_packages)
}

startup()
rm(list = ls())
data <- read_csv(
  "22-5-4 to 22-5-4 Data.csv",
  col_types = cols(
    trialNum = col_integer(),
    rt = col_double(),
    correct = col_logical(),
    winner = col_integer(),
    p1conf = col_integer(),
    p2conf = col_integer(),
    p1rslt = col_integer(),
    p2rslt = col_integer(),
    ...11 = col_skip()
  )
) %>%
  mutate(correct = as.integer(correct))


data <- bind_rows(
  filter(data, cntBalance == 'L') %>%
    mutate(
      hiConf = p1conf,
      loConf = p2conf,
      hiRslt = p1rslt,
      loRslt = p2rslt
    ) %>%
    select(-c(7:10)),
  filter(data, cntBalance == 'R') %>%
    mutate(
      hiConf = p2conf,
      loConf = p1conf,
      hiRslt = p2rslt,
      loRslt = p1rslt
    ) %>%
    select(-c(7:10))
)

#====
#Plot Advisor Accuracy

plotAdvisorAcc <- function(subject) {
  dataLonly <- filter(data, subID == subject)
  
  varName = c('_loConf', '_hiConf')
  for (i in 0:1) {
    assign(
      paste0('hiCal', varName[i + 1]),
      filter(dataLonly, hiConf == i) %>%
        mutate(
          winSum = cumsum(hiRslt),
          proportion = winSum / 1:length(winSum),
          group = paste0('hiCal', varName[i + 1])
        ),
      envir = globalenv()
    )
    
    assign(
      paste0('loCal', varName[i + 1]),
      filter(dataLonly, loConf == i) %>%
        mutate(
          winSum = cumsum(loRslt),
          proportion = winSum / 1:length(winSum),
          group = paste0('loCal', varName[i + 1])
        ),
      envir = globalenv()
    )
  }
  
  graphData <- bind_rows(hiCal_hiConf,
                         hiCal_loConf,
                         loCal_hiConf,
                         loCal_loConf) %>%
    arrange(group) %>%
    select(trialNum, proportion, group)
  
  ggplot(graphData,
         aes(
           x = trialNum,
           y = proportion,
           group = group,
           color = group
         )) +
    scale_color_manual(
      values = c(
        hiCal_hiConf = 'red',
        hiCal_loConf = 'blue',
        loCal_hiConf = 'orange',
        loCal_loConf = 'green'
      ),
      name = 'Advisors',
      labels = c(
        'Calibrated High Confidence',
        'Calibrated Low Confidence',
        'Non-Calibrated High Confidence',
        'Non-Calibrated Low Confidence'
      )
    ) +
    labs(title = "Advisor Accuracy by Confidence",
         x = "Trial Number", y = "Proportion Correct") +
    coord_cartesian(ylim = c(0, 1)) +
    #coord_cartesian(xlim = c(0, 50)) +
    geom_step()
}

subIDlist <- c('0uk', 'aya', 'pj7', 'ynb')
plotAdvisorAcc('aya')


subIDlist <- c('0uk', 'aya', 'pj7', 'ynb')
for(i in subIDlist) {
  plotAdvisorAcc(i)
}

#====
#compute proportions

totalsTable <- mutate(data,
                      advAgree = ifelse(hiRslt == loRslt, 1, 0),) %>%
  filter(advAgree == 0) %>%
  group_by(subID) %>%
  summarise(
    disagree = sum(advAgree != ''),
    HH = sum(hiConf == 1 & loConf == 1),
    HL = sum(hiConf == 1 & loConf == 0),
    LL = sum(hiConf == 0 & loConf == 0),
    LH = sum(hiConf == 0 & loConf == 1),
    
    H_HH = sum(hiConf == 1 &
                 loConf == 1 &
                 correct == hiRslt) / HH,
    H_HL = sum(hiConf == 1 &
                 loConf == 0 &
                 correct == hiRslt) / HL,
    H_LH = sum(hiConf == 0 &
                 loConf == 1 &
                 correct == hiRslt) / LH,
    H_LL = sum(hiConf == 0 &
                 loConf == 0 &
                 correct == hiRslt) / LL,
  )
mean(totalsTable$H_HH)
mean(totalsTable$H_HL)
mean(totalsTable$H_LH)
mean(totalsTable$H_LL)


signTestData <- summarise(
  totalsTable,
  Hcnt_HH = sum(H_HH > .5),
  Hcnt_HL = sum(H_HL > .5),
  Hcnt_LH = sum(H_LH > .5),
  Hcnt_LL = sum(H_LL > .5),
  
  Ncnt_HH = sum(H_HH == .5),
  Ncnt_HL = sum(H_HL == .5),
  Ncnt_LH = sum(H_LH == .5),
  Ncnt_LL = sum(H_LL == .5),
  
  Lcnt_HH = sum(H_HH < .5),
  Lcnt_HL = sum(H_HL < .5),
  Lcnt_LH = sum(H_LH < .5),
  Lcnt_LL = sum(H_LL < .5),
) %>%
  pivot_longer(
    cols = c(
      'Hcnt_HH',
      'Hcnt_HL',
      'Hcnt_LH',
      'Hcnt_LL',
      'Ncnt_HH',
      'Ncnt_HL',
      'Ncnt_LH',
      'Ncnt_LL',
      'Lcnt_HH',
      'Lcnt_HL',
      'Lcnt_LH',
      'Lcnt_LL',
    )
  ) %>%
  mutate(one = c(rep('High', 4), rep('None', 4), rep('Low', 4)),
         two = rep(c(
           'High vs High', 'High vs Low', 'Low vs High', 'Low vs Low'
         ), 3)) %>%
  select(-1)

ggplot(signTestData, aes(
  fill = factor(one, levels = c('Low', 'None', 'High')),
  y = value,
  x = two
)) +
  geom_bar(position = "stack", stat = "identity") +
  scale_y_continuous(breaks = c(0, 9 / 2, 9)) +
  scale_fill_manual(
    values = c(Low = 'lightblue',
               None = 'ivory4',
               High = 'lightblue4'),
    name = 'Advisor Followed',
    labels = c(
      'Non-Calibrated Advisor',
      'Neither Advisor',
      'High-Calibrated Advisor'
    )
  ) +
  labs(title = "Agreement with Well/Non-calibrated Advisor",
       x = "Advisor (High-Calibrated vs Non-Calibrated) Confidence", y = "# of times ")
