#This code simulates the trials generated for a metacognition expeiment based on the set parameters

#Setup====
packages <- c('tidyverse', 'Cairo','0array')
library('0array')
install.packages('0array')
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))
rm(packages, installed_packages)
CairoWin()

subCnt <- 5
data <- tibble(
  lowConf1 = as.double(1:subCnt),
  lowConf2 = 0,
  lowAndw1 = 0,
  lowAndw2 = 0,
  hiConf1 = 0,
  hiConf2 = 0,
  hiAndw1 = 0,
  hiAndw2 = 0,
  wTotal1 = 0,
  wTotal2 = 0,
  wDiff = 0
)



test <- function(trls, conf1, conf2, lo1, hi1, lo2, hi2) {
  RNG <<- tibble(
    row = rep(1:trls),
    outCome = if_else(runif(trls) < .5, 0, 1),
    confRNG1 = runif(trls),
    confRNG2 = runif(trls),
    accRNG1 = runif(trls),
    accRNG2 = runif(trls),
    confA1 = if_else(confRNG1 < conf1, 0, 1),
    accA1 = if_else(
      confA1 == 1,
      if_else(accRNG1 < hi1, 1, 0),
      if_else(accRNG1 < lo1, 1, 0)
    ),
    
    confA2 = if_else(confRNG2 < conf2, 0, 1),
    accA2 = if_else(
      confA2 == 1,
      if_else(accRNG2 < hi2, 1, 0),
      if_else(accRNG2 < lo2, 1, 0)
    )
  )
  
  reslt <<- tibble(
    row = rep(1:trls, 2),
    advisor1 = c(rep(1, trls), rep(2, trls)),
    wHi1 = 0,
    wLo1 = 0,
    wHi2 = 0,
    wLo2 = 0,
  )
  for (i in 1:trls) {
    reslt[i, 3] = sum(RNG[1:i, 7]) / reslt[i, 1]
  }
  
  varName = c('lo', 'hi')
  for (i in 0:1) {
    assign(
      paste0('A1', varName[i+1]),
      filter(RNG, confA1 == i) %>%
        mutate(
          hiCum = cumsum(accA1),
          test = 1:length(hiCum),
          proportion = hiCum / test
        ),
      envir = globalenv()
    )
    
    assign(
      paste0('A2', varName[i+1]),
      filter(RNG, confA2 == i) %>%
        mutate(
          hiCum = cumsum(accA2),
          test = 1:length(hiCum),
          proportion = hiCum / test
        ),
      envir = globalenv()
    )
  }
  
  
  print(RNG)
  print(reslt)
  
  
}

test(1000, .5, .5, .6, .8, .7, .7)

asdf1 <- filter(RNG, confA1 == 1) %>%
  mutate(
    hiCum = cumsum(accA1),
    test = 1:length(hiCum),
    proportion = hiCum / test
  )

asdf2 <- filter(RNG, confA1 == 0) %>%
  mutate(
    hiCum = cumsum(accA1),
    test = 1:length(hiCum),
    proportion = hiCum / test
  )

asdf3 <- filter(RNG, confA2 == 1) %>%
  mutate(
    hiCum = cumsum(accA2),
    test = 1:length(hiCum),
    proportion = hiCum / test
  )

asdf4 <- filter(RNG, confA2 == 0) %>%
  mutate(
    hiCum = cumsum(accA2),
    test = 1:length(hiCum),
    proportion = hiCum / test
  )

ggplot() +
  geom_line(data = A1hi, aes(x = row, y = proportion), color = 'blue') +
  geom_line(data = A1lo, aes(x = row, y = proportion), color = 'red') +
  geom_line(data = A2hi, aes(x = row, y = proportion), color = 'green') +
  geom_line(data = A2lo, aes(x = row, y = proportion), color = 'orange')



ggplot(data = asdf, aes(x = row)) +
  geom_line(aes(y = proportion), color = 'red')




for (i in 1:trls) {
  reslt[i, 3] = cumsum(RNG[1:i, 7]) / reslt[i, 1]
}



rep(1:5, 2)

1:3


RNG

colLength <- 1000

m <- tibble(
  outcome = if_else(runif(colLength) < .5, 'h1', 'h2'),
  ConfRNG1 = runif(colLength),
  ConfRNG2 = runif(colLength),
  AccRNG1 = runif(colLength),
  AccRNG2 = runif(colLength),
  P1Conf = if_else(ConfRNG1 < .5, 'lo', 'hi'),
  P1Acc = if_else(
    P1Conf == 'hi',
    if_else(AccRNG1 < .80, 1, 0),
    if_else(AccRNG1 < .60, 1, 0)
  ),
  
  P2Conf = if_else(ConfRNG2 < .5, 'lo', 'hi'),
  P2Acc = if_else(
    P1Conf == 'hi',
    if_else(AccRNG2 < .7, 1, 0),
    if_else(AccRNG2 < .7, 1, 0)
  ),
  test = 1:colLength,
  P1AccSum = cumsum(P1Acc),
  P2AccSum = cumsum(P2Acc),
  P1AccSumProportion = P1AccSum / test,
  P2AccSumProportion = P2AccSum / test
  
)
ggplot(data = m, aes(x = test)) +
  geom_line(aes(y = P1AccSumProportion), color = 'red') +
  geom_line(aes(y = P2AccSumProportion), color = 'blue')


m
print(m, n = 100)









genTable <- function(colLength, subCnt) {
  asdf <<- tibble(
    lowConf1 = as.double(1:subCnt),
    lowConf2 = as.double(1:subCnt),
    lowAndw1 = as.double(1:subCnt),
    lowAndw2 = as.double(1:subCnt),
    hiConf1 = as.double(1:subCnt),
    hiConf2 = as.double(1:subCnt),
    hiAndw1 = as.double(1:subCnt),
    hiAndw2 = as.double(1:subCnt),
    wTotal1 = as.double(1:subCnt),
    wTotal2 = as.double(1:subCnt),
  )
  m <<- tibble(
    #Horse = c(rep(1, colLength / 2), rep(2, colLength / 2)),
    outcome = if_else(runif(colLength) < .5, 'h1', 'h2'),
    ConfRNG1 = runif(colLength),
    ConfRNG2 = runif(colLength),
    AccRNG1 = runif(colLength),
    AccRNG2 = runif(colLength),
    P1Conf = if_else(ConfRNG1 < .5, 'lo', 'hi'),
    P1Acc = if_else(
      P1Conf == 'hi',
      if_else(AccRNG1 < .80, 'w', 'l'),
      if_else(AccRNG1 < .60, 'w', 'l')
    ),
    
    P2Conf = if_else(ConfRNG2 < .5, 'lo', 'hi'),
    P2Acc = if_else(
      P1Conf == 'hi',
      if_else(AccRNG2 < .7, 'w', 'l'),
      if_else(AccRNG2 < .7, 'w', 'l')
    )
  )
}

for (i in 1:subCnt) {
  #Generates RNG values for horse, confidence, accuracy, then caluclates confidence bin and win/lose
  m <- tibble(
    #Horse = c(rep(1, colLength / 2), rep(2, colLength / 2)),
    outcome = if_else(runif(colLength) < .5, 'h1', 'h2'),
    ConfRNG1 = runif(colLength),
    ConfRNG2 = runif(colLength),
    AccRNG1 = runif(colLength),
    AccRNG2 = runif(colLength),
    P1Conf = if_else(ConfRNG1 < .5, 'lo', 'hi'),
    P1Acc = if_else(
      P1Conf == 'hi',
      if_else(AccRNG1 < .80, 'w', 'l'),
      if_else(AccRNG1 < .60, 'w', 'l')
    ),
    
    P2Conf = if_else(ConfRNG2 < .5, 'lo', 'hi'),
    P2Acc = if_else(
      P1Conf == 'hi',
      if_else(AccRNG2 < .7, 'w', 'l'),
      if_else(AccRNG2 < .7, 'w', 'l')
    )
  )
  
  #Calulate simulation results
  loConf1 <- count(m, P1Conf == 'lo')
  PloConf1 <- loConf1[2, 2] / (count(m))
  loConf2 <- count(m, P2Conf == 'lo')
  PloConf2 <- loConf2[2, 2] / (count(m))
  data[i, 1] = PloConf1
  data[i, 2] = PloConf2
  
  
  lowAndw1 <- count(m, P1Conf == 'lo' & P1Acc == 'w')
  PlowAndw1 <- lowAndw1[2, 2] / loConf1[2, 2]
  
  
  lowAndw2 <- count(m, P2Conf == 'lo' & P2Acc == 'w')
  PlowAndw2 <- lowAndw2[2, 2] / loConf2[2, 2]
  
  data[i, 3] = PlowAndw1
  data[i, 4] = PlowAndw2
  
  #################
  hiConf1 <- count(m, P1Conf == 'hi')
  PhiConf1 <- hiConf1[2, 2] / (count(m))
  hiConf2 <- count(m, P2Conf == 'hi')
  PhiConf2 <- hiConf2[2, 2] / (count(m))
  data[i, 5] = PhiConf1
  data[i, 6] = PhiConf2
  
  
  hiwAndw1 <- count(m, P1Conf == 'hi' & P1Acc == 'w')
  PhiwAndw1 <- hiwAndw1[2, 2] / hiConf1[2, 2]
  
  
  hiwAndw2 <- count(m, P2Conf == 'hi' & P2Acc == 'w')
  PhiwAndw2 <- hiwAndw2[2, 2] / hiConf2[2, 2]
  
  data[i, 7] = PhiwAndw1
  data[i, 8] = PhiwAndw2
  
  data[i, 9] <- count(m, P1Acc == 'w')[2, 2] / colLength
  data[i, 10] <-
    count(m, P2Acc == 'w')[2, 2] / colLength
  
}
data <- mutate(data, wDiff = wTotal1 - wTotal2)
print(data, n = 30)

mean(data$lowAndw1)
mean(data$lowAndw2)
mean(data$hiAndw1)
mean(data$hiAndw2)
mean(data$wDiff)
