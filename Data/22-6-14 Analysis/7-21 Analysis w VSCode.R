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
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
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
    p2rslt = col_integer()
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
  filter(data, trialNum > 0 & trialNum <= 100) %>% mutate(blk = 1),
  filter(data, trialNum > 100 & trialNum <= 200) %>% mutate(blk = 2),
  filter(data, trialNum > 200 & trialNum <= 300) %>% mutate(blk = 3),
  filter(data, trialNum > 300 & trialNum <= 400) %>% mutate(blk = 4),
  filter(data, trialNum > 400 & trialNum <= 500) %>% mutate(blk = 5)
) %>% arrange(subID)

#====
#(0-adv different, 1-adv same, subID,CairoWindow, Save plot)

source('pltSubAgree.R')
pltSubAgree(0, 'pj7', F, F)
pltSubAgree(1, 'pj7', F, F)
pltSubAgree(1,, F, F)

source('pltAdvsrAcc.R')
pltAdvsrAcc('pj7', F, F)
pltAdvsrAcc(, F, F)





