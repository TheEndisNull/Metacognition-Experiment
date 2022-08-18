startup <- function() {
  renv::isolate()
  packages <-
    c("Rmisc", "tidyverse", "Cairo", "dqrng", "readr", "ggthemes")
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
  filter(data, cntBalance == "L") %>%
    mutate(
      hiConf = p1conf,
      loConf = p2conf,
      hiRslt = p1rslt,
      loRslt = p2rslt
    ) %>%
    select(-c(7:10)),
  filter(data, cntBalance == "R") %>%
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



source("pltSubAgree.R")
source("pltAdvsrAcc.R")
# df = filter(df, advAgree == 1) #try without filter

dfAdvsrAcc <- group_by(data, subID) %>%
  summarize(
    HH = sum(hiConf == 1 & loConf == 1),
    HL = sum(hiConf == 1 & loConf == 0),
    LL = sum(hiConf == 0 & loConf == 0),
    LH = sum(hiConf == 0 & loConf == 1),

    # Sum of trials in which high calibrated advisor expressed high confidence, & low calibrated advisor expressed high confidence
    # in which the calibrated advisor won
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

    # Sum of trials in which high calibrated advisor expressed high confidence, & low calibrated advisor expressed high confidence
    # in which the non-calibrated advisor won
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
  pivot_longer(cols = c(
    "H_HH", "H_HL", "H_LH", "H_LL",
    "L_HH", "L_HL", "L_LH", "L_LL"
  )) %>%
  select(-c(2:5))

dfAdvsrAcc <-
  summarySEwithin(dfAdvsrAcc,
    measurevar = "value",
    withinvars = "name",
    idvar = "subID"
  ) %>%
  select(1, 3, 5) %>%
  mutate(group = "advsr")
dfAdvsrAcc

# proportion of agreement with the calibrated advisor (and inverse of non-calibrated advisors) in which both advisors expressed high confidence
dfSubAgree <- pltSubAgree(0, "all", F, F) %>%
  select(1, 3, 5)

dfSubAgree <- pltSubAgree(0, "all", F, F) %>%
  select(1, 3, 5) %>%
  add_row(
    value = 1 - dfSubAgree$value,
    se = dfSubAgree$se[1:4],
    name = c("L_HH", "L_HL", "L_LH", "L_LL")
  ) %>%
  mutate(group = "sub")


dfSubAgree
dfAdvsrAcc
graphDf <- bind_rows(
  dfSubAgree,
  dfAdvsrAcc
)

filter(graphDf, grepl("HH", name))
filter(graphDf, grepl("HL", name))
filter(graphDf, grepl("LH", name))
filter(graphDf, grepl("LL", name))

ggplot(graphDf, aes(x = name, y = value, group = group)) +
  geom_line(aes(linetype = group))



testvar <- filter(graphDf, grepl("HH", name)) %>%
  filter(group == "sub") %>%
  select(name, value) %>%
  mutate(emptyvar = "")

p1 <- ggplot(testvar, aes(x = emptyvar, y = value, fill = name)) +
    geom_bar(stat="identity") + 
    geom_text(aes(label = value), 
        position = position_stack(vjust = 0.5)) +
  scale_fill_manual(values = c(
    'H_HH' = "blue",
    'L_HH' = "red"
  )) + mytheme +
  coord_flip()


testvar2 <- filter(graphDf, grepl("HH", name)) %>%
  filter(group == "advsr") %>%
  select(name, value) %>%
  mutate(emptyvar = "")
testvar2


p2 <- ggplot(data=testvar2, aes(x=name, y=value, group=1)) +
  geom_line()+
  geom_point() + 
  ylim(0,1) +
  mytheme


multiplot(p2, p1)



testvar <- filter(graphDf, grepl("HH", name))




testvar

testvar <- tibble(value = c(.57, .43), participant = c("advsr1", "advsr2"))
ggplot(testvar, aes(y = value, x = participant)) +
  geom_bar(stat = "identity")

# create a dataset
specie <- c(rep("sorgho", 3), rep("poacee", 3), rep("banana", 3), rep("triticum", 3))
condition <- rep(c("normal", "stress", "Nitrogen"), 4)
value <- abs(rnorm(12, 0, 15))
data <- data.frame(specie, condition, value)

# Stacked
ggplot(data, aes(fill = condition, y = value, x = specie)) +
  geom_bar(position = "stack", stat = "identity")














source("pltSubAgree.R")
source("pltAdvsrAcc.R")


test <- pltSubAgree(0, , F, F)

test

subDf <- pltSubAgree(0, "0uk", F, F) %>%
  select(1, 3, 5)
subDf <- add_row(subDf,
  value = 1 - subDf$value,
  name = c("L_HH", "L_HL", "L_LH", "L_LL"),
  se = subDf$se
) %>%
  mutate(group = "sub")
subDf

advsrDf <- pltAdvsrAcc("0uk", F, F)
advsrDf <- tibble(
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



mytheme <-   theme_bw() +
  theme(
    plot.title = element_text(size = 15),
    plot.title.position = "panel",
    axis.title.x = element_text(size = 15),
    axis.title.y = element_text(size = 15),
    legend.position = "none",
    legend.title = element_text(size = 10),
    legend.text = element_text(size = 10),
    axis.text = element_text(size = 15),
    axis.title = element_text(size = 15),
    axis.line = element_line(colour = "black"),
    panel.grid.major.x = element_blank(),
    panel.border = element_blank(),
    panel.background = element_blank()
  )


multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}
