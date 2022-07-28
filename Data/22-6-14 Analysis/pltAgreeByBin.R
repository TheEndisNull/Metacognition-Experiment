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
  filter(data, trialNum > 100 &
           trialNum <= 200) %>% mutate(blk = 2),
  filter(data, trialNum > 200 &
           trialNum <= 300) %>% mutate(blk = 3),
  filter(data, trialNum > 300 &
           trialNum <= 400) %>% mutate(blk = 4),
  filter(data, trialNum > 400 & trialNum <= 500) %>% mutate(blk = 5)
) %>% arrange(subID)

data



df = mutate(data,
            advAgree = ifelse(hiRslt == loRslt, 1, 0),)
#df = filter(df, advAgree == 1) #try without filter

df = group_by(df, subID) %>%
  summarize(
    disagree = sum(advAgree != ''),
    HH = sum(hiConf == 1 & loConf == 1),
    HL = sum(hiConf == 1 & loConf == 0),
    LL = sum(hiConf == 0 & loConf == 0),
    LH = sum(hiConf == 0 & loConf == 1),
    
    H_HH = sum(hiConf == 1 &
                 loConf == 1 &
                 hiRslt == 1) / HH,
    H_HL = sum(hiConf == 1 &
                 loConf == 0 &
                 hiRslt == 1) / HL,
    H_LH = sum(hiConf == 0 &
                 loConf == 1 &
                 hiRslt == 1) / LH,
    H_LL = sum(hiConf == 0 &
                 loConf == 0 &
                 hiRslt == 1) / LL,
    
    L_HH = sum(hiConf == 1 &
                 loConf == 1 &
                 loRslt == 1) / HH,
    L_HL = sum(hiConf == 1 &
                 loConf == 0 &
                 loRslt == 1) / HL,
    L_LH = sum(hiConf == 0 &
                 loConf == 1 &
                 loRslt == 1) / LH,
    L_LL = sum(hiConf == 0 &
                 loConf == 0 &
                 loRslt == 1) / LL,
  ) %>%
  pivot_longer(cols = c('H_HH', 'H_HL', 'H_LH', 'H_LL',
                        'L_HH', 'L_HL', 'L_LH', 'L_LL')) %>%
  select(-c(2:6))


source('pltSubAgree.R')
source('pltAdvsrAcc.R')

df 
dfTest = 
  summarySEwithin(df,
                  measurevar = "value",
                  withinvars = 'name',
                  idvar = "subID") %>%
  select(1,3,5) %>%
  mutate(group='advsr')
dfTest

subDf = pltSubAgree(0,'all' , F, F)  %>%
  select(1, 3, 5)

subDf = pltSubAgree(0,'all' , F, F)  %>%
  select(1, 3, 5) %>%
  add_row(value = 1 - subDf$value,
          se = subDf$se[1:4],
          name = c('L_HH', 'L_HL', 'L_LH', 'L_LL')
) %>% 
  mutate(group = 'sub')


subDf
dfTest
graphDf = bind_rows(subDf,
          dfTest
) %>% filter()

graphDf = filter(graphDf, )


ggplot(graphDf, aes(x=name,y=value,group=group)) +
         geom_line(aes(linetype=group))






























subDf <- pltSubAgree(0, , F, F)  %>%
  select(1, 3, 5) %>%
  add_row(value = 1 - subDf$value,
          name = c('L_HH', 'L_HL', 'L_LH', 'L_LL'))
subDf

%>%
  mutate(group = 'sub')
subDf


1 - subDf$value

subDf$se[1:4]





advsrDf <- pltAdvsrAcc('0uk', F, F)


advsrDf = tibble(
  name = c(
    advsrDf$group[nrow(advsrDf) * .25],
    advsrDf$group[nrow(advsrDf) * .5],
    advsrDf$group[nrow(advsrDf) * .75],
    advsrDf$group[nrow(advsrDf)]
  ),
  value = c(
    advsrDf$winRate[nrow(advsrDf) * .25],
    advsrDf$winRate[nrow(advsrDf) * .5],
    advsrDf$winRate[nrow(advsrDf) * .75],
    advsrDf$winRate[nrow(advsrDf)]
  )
)

subDf
advsrDf

nrow(advsrDf)
advsrDf$winRate[515]