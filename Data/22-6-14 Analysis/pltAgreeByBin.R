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
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

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



source('pltSubAgree.R')
source('pltAdvsrAcc.R')
#df = filter(df, advAgree == 1) #try without filter

dfAdvsrAcc = group_by(data, subID) %>%
  summarize(
    HH = sum(hiConf == 1 & loConf == 1),
    HL = sum(hiConf == 1 & loConf == 0),
    LL = sum(hiConf == 0 & loConf == 0),
    LH = sum(hiConf == 0 & loConf == 1),
    
    #Sum of trials in which high calibrated advisor expressed high confidence, & low calibrated advisor expressed high confidence
    #in which the calibrated advisor won 
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
    
    #Sum of trials in which high calibrated advisor expressed high confidence, & low calibrated advisor expressed high confidence
    #in which the non-calibrated advisor won 
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
  select(-c(2:5))
 
dfAdvsrAcc = 
  summarySEwithin(dfAdvsrAcc,
                  measurevar = "value",
                  withinvars = 'name',
                  idvar = "subID") %>%
  select(1,3,5) %>%
  mutate(group='advsr')
dfAdvsrAcc

#proportion of agreement with the calibrated advisor (and inverse of non-calibrated advisors) in which both advisors expressed high confidence
dfSubAgree = pltSubAgree(0,'all' , F, F)  %>%
  select(1, 3, 5)

dfSubAgree = pltSubAgree(0,'all' , F, F)  %>%
  select(1, 3, 5) %>%
  add_row(value = 1 - dfSubAgree$value,
          se = dfSubAgree$se[1:4],
          name = c('L_HH', 'L_HL', 'L_LH', 'L_LL')
) %>% 
  mutate(group = 'sub')


dfSubAgree
dfAdvsrAcc
graphDf = bind_rows(dfSubAgree,
          dfAdvsrAcc
)

HHdf = filter(graphDf, grepl('HH', name))
HLdf = filter(graphDf, grepl('HL', name))
LHdf = filter(graphDf, grepl('LH', name))
LLdf = filter(graphDf, grepl('LL', name))


    width = .8
    dodgeWidth = .85
    errWidth = .4
    errdodgeWidth = .85

testfunc = function(dataset,title) {
ggplot(dataset, aes(x=name,y=value, group=group)) +
      geom_line(aes(color=group)) +
        scale_color_manual(
        values = c(
          advsr = 'red',
          sub = 'blue'
      ),
    name = 'Legend',
    labels = c(
      'Advisor Accuracy',
      'Participant Agreement with Advisor'
    )
  ) +
      geom_errorbar(
        aes(ymin = value - se,
            ymax = value + se),
        width = errWidth,
        #position = position_dodge(errdodgeWidth),
        colour = "azure4",
        size = 1
      ) +
            labs(title = title,
           x = 'Advisors Confidence \n(Calibrated/Non-calibrated)',
           y = 'Proportion of Agreement \nwith Calibrated Advisor') +
                 scale_x_discrete(
        limits = c(dataset$name[1],
                   dataset$name[2])
      ) +
      theme_bw() +
      theme(
        plot.title = element_text(size = 15),
        plot.title.position = 'panel',
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        #legend.position = 'none',
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 15),
        axis.title = element_text(size = 15),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()
      )

}

HHdf = filter(graphDf, grepl('HH', name))
HLdf = filter(graphDf, grepl('HL', name))
LHdf = filter(graphDf, grepl('LH', name))
LLdf = filter(graphDf, grepl('LL', name))
testfunc(HHdf,'Advisor Accuracy and Subject Agreement for trials when Calibrated Advsr has HIGH confidence, and Un-calibrated Advsr has HIGH confidence')
testfunc(HLdf,'Advisor Accuracy and Subject Agreement for trials when Calibrated Advsr has HIGH confidence, and Un-calibrated Advsr has LOW confidence')
testfunc(LHdf,'Advisor Accuracy and Subject Agreement for trials when Calibrated Advsr has LOW confidence, and Un-calibrated Advsr has HIGH confidence')
testfunc(LLdf,'Advisor Accuracy and Subject Agreement for trials when Calibrated Advsr has LOW confidence, and Un-calibrated Advsr has LOW confidence')








ggplot(graphDf, aes(x=name,y=value,group=group)) +
         geom_line(aes(linetype=group))

























source('pltSubAgree.R')
source('pltAdvsrAcc.R')


test = pltSubAgree(0, , F, F) 

test

subDf <- pltSubAgree(0,'0uk', F, F)  %>%
  select(1, 3, 5) 
subDf <- add_row(subDf,value = 1 - subDf$value,
          name = c('L_HH', 'L_HL', 'L_LH', 'L_LL'),
          se = subDf$se
          ) %>%
  mutate(group = 'sub')
subDf

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