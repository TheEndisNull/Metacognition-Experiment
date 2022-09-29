pltAdvsrAcc <-
  function(subject = "all", CairoPlt, savePlt) {
    if (subject == "all") {
      df <- data
    } else {
      df <- filter(data, subID == subject)
    }
    
    varName <- c("_loConf", "_hiConf")
    for (i in 0:1) {
      assign(
        paste0("hiCal", varName[i + 1]),
        mutate(
          df,
          hiConf = ifelse(hiConf == i, hiConf, NA),
          hiRslt = ifelse(hiConf == i, hiRslt, NA),
        ) %>%
          mutate(
            winSum = cumsum(replace_na(hiRslt, 0)),
            winTemp = winSum / cumsum(ifelse(is.na(hiRslt), 0, 1)),
            winRate = ifelse(is.na(winTemp), 0.5, winTemp),
            group = paste0("hiCal", varName[i + 1])
          ),
      )

      assign(
        paste0("loCal", varName[i + 1]),
        mutate(
          df,
          loConf = ifelse(loConf == i, loConf, NA),
          loRslt = ifelse(loConf == i, loRslt, NA)
        ) %>%
          mutate(
            winSum = cumsum(replace_na(loRslt, 0)),
            winTemp = winSum / cumsum(ifelse(is.na(loRslt), 0, 1)),
            winRate = ifelse(is.na(winTemp), 0.5, winTemp),
            group = paste0("loCal", varName[i + 1])
          ),
      )
    }

    pltDf <- bind_rows(
      hiCal_hiConf,
      hiCal_loConf,
      loCal_hiConf,
      loCal_loConf
    ) %>%
      arrange(group) %>%
      select(subID, trialNum, winRate, group)

    pltDf <- summarySEwithin(
      pltDf,
      measurevar = "winRate",
      withinvars = c("group", "trialNum"),
      idvar = "subID"
    )

    pltDf$trialNum <- as.numeric(pltDf$trialNum)

    if (subject == "all") {
      pltTitle <- "Advisor accuracy averaged accross all subjects"
    } else {
      pltTitle <- paste("Advisor accuracy for subject:", subject)
    }

    plt <- ggplot(
      pltDf,
      aes(
        x = trialNum,
        y = winRate,
        group = group,
        color = group
      )
    ) +
      scale_color_manual(
        values = c(
          hiCal_hiConf = "red",
          hiCal_loConf = "blue",
          loCal_hiConf = "orange",
          loCal_loConf = "green"
        ),
        name = "Advisors",
        labels = c(
          "Calibrated High Confidence",
          "Calibrated Low Confidence",
          "Non-Calibrated High Confidence",
          "Non-Calibrated Low Confidence"
        )
      ) +
      guides(color = guide_legend(ncol = 2)) +
      labs(
        title = pltTitle,
        x = "Trial Number",
        y = "Proportion Correct"
      ) +
      coord_cartesian(
        ylim = c(0, 1),
        xlim = c(0, 500)
      ) +
      geom_ribbon(aes(ymin = winRate - sd, ymax = winRate + sd), fill = "lightgrey", alpha = .7) +
      geom_line() +
      theme(
        plot.title = element_text(size = 15),
        plot.title.position = "panel",
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = "bottom",
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
      geom_hline(
        yintercept = .80,
        linetype = "dashed",
        color = "azure4"
      ) +
      geom_hline(
        yintercept = .70,
        linetype = "dashed",
        color = "azure4"
      ) +
      geom_hline(
        yintercept = .60,
        linetype = "dashed",
        color = "azure4"
      )

    if (CairoPlt == T) {
      CairoWin()
      print(plt)
    } else {
      print(plt)
    }

    if (savePlt == T) {
      ggsave(
        plt,
        filename = paste0("AdvPlt ", subject, ".png"),
        dpi = 300,
        type = "cairo",
        width = 8.25,
        height = 3,
        units = "in"
      )
    }

    # print(df)
    # print(pltDf)
    return(pltDf)
  }
