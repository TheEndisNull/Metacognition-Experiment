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
    winner = col_integer(),
    p1conf = col_integer(),
    p2conf = col_integer(),
    p1rslt = col_integer(),
    p2rslt = col_integer(),
    ...11 = col_skip()
  )
)


test <- function(qwer) {
dataLonly <- filter(data, subID == qwer)

varName = c('lo', 'hi')
for (i in 0:1) {
  assign(
    paste0('A1', varName[i + 1]),
    filter(dataLonly, p1conf == i) %>%
      mutate(
        winSum = cumsum(p1rslt),
        proportion = winSum / 1:length(winSum),
        group = paste0('A1', varName[i + 1])
      ),
    envir = globalenv()
  )
  
  assign(
    paste0('A2', varName[i + 1]),
    filter(dataLonly, p2conf == i) %>%
      mutate(
        winSum = cumsum(p2rslt),
        proportion = winSum / 1:length(winSum),
        group = paste0('A2', varName[i + 1])
      ),
    envir = globalenv()
  )
  
  graphData <<- bind_rows(A1hi,
                          A1lo,
                          A2hi,
                          A2lo) %>%
    arrange(group) %>%
    select(trialNum, proportion, group)
  
}

ggplot(graphData,
       aes(
         x = trialNum,
         y = proportion,
         group = group,
         color = group
       )) +
  scale_color_manual(
    values = c(
      A1hi = 'red',
      A1lo = 'blue',
      A2hi = 'orange',
      A2lo = 'green'
    ),
    name = 'Advisor Judgement',
    labels = c(
      'Calibrated High',
      'Calibrated Low',
      'Non-Calibrated High',
      'Non-Calibrated Low'
    )
  ) +
  labs(title = "Simulated Correct Proportions",
       x = "Trial Number", y = "Proportion Correct") +
  coord_cartesian(ylim = c(0, 1)) +
  #coord_cartesian(xlim = c(0, 50)) +
  geom_step()

}

test('aya')


