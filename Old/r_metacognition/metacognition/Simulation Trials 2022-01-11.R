#This code simulates the trials generated for a metacognition expeiment based on the set parameters

#Setup====
packages <- c('tidyverse')
installed_packages <- packages %in% rownames(installed.packages())
if (any(installed_packages == FALSE)) {
  install.packages(packages[!installed_packages])
}
invisible(lapply(packages, library, character.only = TRUE))
rm(packages, installed_packages)

colLength <- 200
subCnt <- 120
data <- tibble(
  lowConf1=as.double(1:subCnt),
  lowConf2=as.double(1:subCnt),
  lowAndw1=as.double(1:subCnt),
  lowAndw2=as.double(1:subCnt),
  hiConf1=as.double(1:subCnt),
  hiConf2=as.double(1:subCnt),
  hiAndw1=as.double(1:subCnt),
  hiAndw2=as.double(1:subCnt),
  wTotal1=as.double(1:subCnt),
  wTotal2=as.double(1:subCnt),
  
)
for(i in 1:subCnt) {

  #Generates RNG values for horse, confidence, accuracy, then caluclates confidence bin and win/lose
m <- tibble(
  #Horse = c(rep(1, colLength / 2), rep(2, colLength / 2)),
  HorseRNG = if_else(
    runif(colLength) < .5,'h1','h2'),
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
loConf1 <-count(m,P1Conf=='lo') 
PloConf1 <- loConf1[2,2]/(count(m))
loConf2 <-count(m,P2Conf=='lo') 
PloConf2 <- loConf2[2,2]/(count(m))
data[i,1]=PloConf1
data[i,2]=PloConf2


lowAndw1 <- count(m,P1Conf=='lo'& P1Acc=='w') 
PlowAndw1 <- lowAndw1[2,2]/loConf1[2,2]


lowAndw2 <- count(m,P2Conf=='lo'& P2Acc=='w') 
PlowAndw2 <- lowAndw2[2,2]/loConf2[2,2]

data[i,3]=PlowAndw1
data[i,4]=PlowAndw2

#################
hiConf1 <-count(m,P1Conf=='hi') 
PhiConf1 <- hiConf1[2,2]/(count(m))
hiConf2 <-count(m,P2Conf=='hi') 
PhiConf2 <- hiConf2[2,2]/(count(m))
data[i,5]=PhiConf1
data[i,6]=PhiConf2


hiwAndw1 <- count(m,P1Conf=='hi'& P1Acc=='w') 
PhiwAndw1 <- hiwAndw1[2,2]/hiConf1[2,2]


hiwAndw2 <- count(m,P2Conf=='hi'& P2Acc=='w') 
PhiwAndw2 <- hiwAndw2[2,2]/hiConf2[2,2]

data[i,7]=PhiwAndw1
data[i,8]=PhiwAndw2

data[i,9] <- count(m,P1Acc=='w')[2,2]/colLength 
data[i,10] <- count(m,P2Acc=='w')[2,2]/colLength  

}
data <- mutate(data,wDiff = wTotal1 -wTotal2 )
print(data,n=30)

mean(data$lowAndw1)
mean(data$lowAndw2)
mean(data$hiAndw1)
mean(data$hiAndw2)
mean(data$wDiff)
