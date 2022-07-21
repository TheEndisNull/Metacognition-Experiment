packages <- c('tidyverse', 'Cairo', 'dqrng', 'readr')

installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))
rm(packages, installed_packages)

library()
simData <-
  read_csv("simData.csv",
           col_types = cols(cntBalance = col_skip(),
                            rt = col_skip()))
set.seed(1)


trls <- 400
simTibble <- tibble(
  subID = 'ler',
  trialNum = 1:trls,
  confRNG1 = dqrunif(trls),
  confRNG2 = dqrunif(trls),
  accRNG1 = dqrunif(trls),
  accRNG2 = dqrunif(trls),
  correctRNG = dqrunif(trls),
  p1conf = if_else(confRNG1 < .5, 0, 1),
  p1rslt = if_else(p1conf == 1,
                   if_else(accRNG1 < .8, 1, 0),
                   if_else(accRNG1 < .6, 1, 0)),
  p2conf = if_else(confRNG2 < .5, 0, 1),
  p2rslt = if_else(p2conf == 1,
                   if_else(accRNG2 < .7, 1, 0),
                   if_else(accRNG2 < .7, 1, 0)),
  correct = if_else(correctRNG < .5, 0, 1),
) %>%
  select(subID, trialNum, correct, p1conf, p2conf, p1rslt, p2rslt)

data <- mutate(simTibble,
               advAgree = ifelse(p1rslt == p2rslt, 1, 0), ) %>%
  filter(advAgree == 0) %>%
  group_by(subID) %>%
  summarise(
    disagree = sum(advAgree != ''),
    LL = sum(p1conf == 0 & p2conf == 0),
    HH = sum(p1conf == 1 & p2conf == 1),
    LH = sum(p1conf == 1 & p2conf == 0),
    HL = sum(p1conf == 0 & p2conf == 1),
    
    LL1 = sum(p1conf == 0 &
                p2conf == 0 & correct == p1rslt),
    HH1 = sum(p1conf == 1 &
                p2conf == 1 & correct == p1rslt),
    LH1 = sum(p1conf == 1 &
                p2conf == 0 & correct == p1rslt),
    HL1 = sum(p1conf == 0 &
                p2conf == 1 & correct == p1rslt),
    
    LL2 = sum(p1conf == 0 &
                p2conf == 0 & correct == p2rslt),
    HH2 = sum(p1conf == 1 &
                p2conf == 1 & correct == p2rslt),
    LH2 = sum(p1conf == 1 &
                p2conf == 0 & correct == p2rslt),
    HL2 = sum(p1conf == 0 &
                p2conf == 1 & correct == p2rslt),
  )

print(data)

data <- mutate(simTibble,
               advAgree = ifelse(p1rslt == p2rslt, 1, 0), ) %>%
  filter(advAgree == 0) #%>%
#filter(p1conf == 0 & p2conf == 0) #%>%
#filter(correct == p2rslt)

print(data, n = 100)
