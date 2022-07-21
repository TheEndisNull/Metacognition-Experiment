#====
#Read in data
startup <- function() {
  renv::isolate()
  packages =
    c('Rmisc', 'tidyverse', 'Cairo', 'dqrng', 'readr', 'ggthemes')
  knitr::opts_chunk$set(dev.args = list(png = list(type = "cairo")))
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
data <- bind_rows(
  filter(data, trialNum > 0 & trialNum < 100) %>% mutate(blk = 1),
  filter(data, trialNum > 100 & trialNum < 200) %>% mutate(blk = 2),
  filter(data, trialNum > 200 & trialNum < 300) %>% mutate(blk = 3),
  filter(data, trialNum > 300 & trialNum < 400) %>% mutate(blk = 4),
  filter(data, trialNum > 400 & trialNum < 500) %>% mutate(blk = 5)
) %>% arrange(subID)

#====
#Plot Advisor Accuracy

plotAdvisorAcc <- function(subject) {
  dataPltAdv = filter(data, subID == subject)
  varName = c('_loConf', '_hiConf')
  for (i in 0:1) {
    assign(
      paste0('hiCal', varName[i + 1]),
      filter(dataPltAdv, hiConf == i) %>%
        mutate(
          winSum = cumsum(hiRslt),
          proportion = winSum / 1:length(winSum),
          group = paste0('hiCal', varName[i + 1])
        ),
      #envir = globalenv()
    )
    
    assign(
      paste0('loCal', varName[i + 1]),
      filter(dataPltAdv, loConf == i) %>%
        mutate(
          winSum = cumsum(loRslt),
          proportion = winSum / 1:length(winSum),
          group = paste0('loCal', varName[i + 1])
        ),
      #envir = globalenv()
    )
  }
  
  graphData = bind_rows(hiCal_hiConf,
                        hiCal_loConf,
                        loCal_hiConf,
                        loCal_loConf) %>%
    arrange(group) %>%
    select(trialNum, proportion, group)
  
  plt <<- ggplot(graphData,
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
    guides(color=guide_legend(ncol=2))+
    labs(
      title = paste("Advisor Accuracy by Confidence for Participant:", subject),
      x = "Trial Number",
      y = "Proportion Correct"
    ) +
    coord_cartesian(ylim = c(0, 1)) +
    geom_step() +
    theme(
      plot.title = element_text(size = 15),
      plot.title.position = 'panel',
      axis.title.x = element_text(size = 15),
      axis.title.y = element_text(size = 15),
      legend.position = 'bottom',
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 10),
      axis.text = element_text(size = 15),
      axis.title = element_text(size = 15),
      axis.line = element_line(colour = "black"),
      panel.grid.major.x = element_blank(),
      panel.border = element_blank(),
      panel.background = element_blank()
    ) +
    scale_fill_hc() +
    geom_hline(yintercept = .80,
               linetype = "dashed",
               color = "azure4") +
    geom_hline(yintercept = .70,
               linetype = "dashed",
               color = "azure4") +
    geom_hline(yintercept = .60,
               linetype = "dashed",
               color = "azure4")

  plt
  ggsave(plt, filename = paste0('AvdPlt',subject,'.png'), dpi = 300, type = "cairo",
         width = 8.25, height = 4.4, units = "in")
}

CairoWin()
plotAdvisorAcc('pj7')
plotAdvisorAcc('aya')
plotAdvisorAcc('ht1')
plotAdvisorAcc('ynb')
plt

subIDlistL <- c('0uk', 'aya', 'ga4', 'btm')
subIDlistL <- c('bsp', 'ht1', 'pj7', 'ynb', 'f88')

#====
#compute proportions

pAgree <- function(advAgreement) {
  df <<- mutate(data,
              advAgree = ifelse(hiRslt == loRslt, 1, 0), ) %>%
    filter(advAgree == advAgreement) %>%
    group_by(subID) %>%
    summarize(
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
    ) %>%
    pivot_longer(cols = c('H_HH', 'H_HL', 'H_LH', 'H_LL')) %>%
    select(-c(2:6))
  
  graphdf =
    summarySEwithin(df,
                    measurevar = "value",
                    withinvars = 'name',
                    idvar = "subID")
  
  width = .8
  dodgeWidth = .85
  errWidth = .4
  errdodgeWidth = .85
  
  plt <<- ggplot(graphdf, aes(y = value,
                      x = name,
                      fill = name)) +
    geom_bar(
      stat = "identity",
      width = width,
      position = position_dodge(dodgeWidth),
      color = 'black'
    ) +
    
    geom_errorbar(
      aes(ymin = value - se,
          ymax = value + se),
      width = errWidth,
      position = position_dodge(errdodgeWidth),
      colour = "azure4",
      size = 1
    ) +
    geom_hline(yintercept = .50,
               linetype = "dashed",
               color = "black") +
    coord_cartesian(ylim = c(0, 1)) +
    labs(y = 'Proportion of Agreement \nwith Calibrated Advisor',
         x = 'Advisors Confidence \n(Calibrated/Non-calibrated)') +
    
    scale_fill_manual(values = c(
      H_HL = 'blue',
      H_HH = 'red',
      H_LL = 'green',
      H_LH = 'yellow'
    )) +
    scale_x_discrete(
      limits = c('H_HL',
                 'H_HH',
                 'H_LL',
                 'H_LH'),
      labels = c(
        'H_HL' = 'High/Low',
        'H_HH' = 'High/High',
        'H_LL' = 'Low/Low',
        'H_LH' = 'Low/High'
      )
    ) +
    theme_bw() +
    theme(
      plot.title = element_text(size = 15),
      plot.title.position = 'panel',
      axis.title.x = element_text(size = 15),
      axis.title.y = element_text(size = 15),
      legend.position = 'none',
      legend.title = element_text(size = 10),
      legend.text = element_text(size = 10),
      axis.text = element_text(size = 15),
      axis.title = element_text(size = 15),
      axis.line = element_line(colour = "black"),
      panel.grid.major.x = element_blank(),
      panel.border = element_blank(),
      panel.background = element_blank()
    )
  
  ggsave(plt, filename = paste0('pAgree.png'), dpi = 300, type = "cairo",
         width = 8.25, height = 4.4, units = "in")
}
pAgree(1)

#====

df <- mutate(data,
              advAgree = ifelse(hiRslt == loRslt, 1, 0), ) %>%
  filter(advAgree == 1) %>%
  group_by(subID) %>%
  summarize(
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

#====

pAgreeByBlk <- function() {
for (i in 1:5) {
  df <- mutate(filter(data, blk == i),
               advAgree = ifelse(hiRslt == loRslt, 1, 0), ) %>%
    filter(advAgree == 0) %>%
    group_by(subID) %>%
    summarize(
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
    ) %>%
    pivot_longer(cols = c('H_HH', 'H_HL', 'H_LH', 'H_LL')) %>%
    select(-c(2:6))
  
  assign(
    paste0('blk', i),
    summarySEwithin(
      df,
      measurevar = "value",
      withinvars = 'name',
      idvar = "subID"
    )
  )
}

byBlk = bind_rows(
  mutate(blk1, blk = '1'),
  mutate(blk2, blk = '2'),
  mutate(blk3, blk = '3'),
  mutate(blk4, blk = '4'),
  mutate(blk5, blk = '5'),
) %>%
  arrange(name)

width = .8
dodgeWidth = .85
errWidth = .4
errdodgeWidth = .85
colfunc = colorRampPalette(c("gray20", "deepskyblue"))
graphColors <- colfunc(5)

plt <<- ggplot(byBlk,
       aes(y = value,
           x = name,
           group = blk)) +
  geom_point(aes(color = blk), size = 1.7) +
  geom_line(aes(color = blk), size = 1.2) +
  scale_color_manual(values = graphColors) +
  geom_hline(yintercept = .50,
             linetype = "dashed",
             color = "black") +
  coord_cartesian(ylim = c(0, 1)) +
  labs(y = 'Proportion of Agreement \nwith Calibrated Advisor',
       x = 'Advisors Confidence \n(Calibrated/Non-calibrated)',
       color = "Trial Block") +
  
  scale_x_discrete(
    limits = c('H_HL',
               'H_HH',
               'H_LL',
               'H_LH'),
    labels = c(
      'H_HL' = 'High/Low',
      'H_HH' = 'High/High',
      'H_LL' = 'Low/Low',
      'H_LH' = 'Low/High'
    )
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(size = 15),
    plot.title.position = 'panel',
    axis.title.x = element_text(size = 15),
    axis.title.y = element_text(size = 15),
    legend.position = 'bottom',
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 10),
    axis.text = element_text(size = 15),
    axis.title = element_text(size = 15),
    axis.line = element_line(colour = "black"),
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()
  )

ggsave(plt, filename = paste0('pAgreeByBlk.png'), dpi = 300, type = "cairo",
       width = 8.25, height = 4.4, units = "in")
}
pAgreeByBlk()


mutate(data,
            advAgree = ifelse(hiRslt == loRslt, 1, 0), ) %>%
  filter(advAgree == 0) 


a












































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
