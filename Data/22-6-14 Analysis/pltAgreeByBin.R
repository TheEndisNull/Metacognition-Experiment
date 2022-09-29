pltAgreeByCond <-
  function(subject = "all", cond, pltOrDf, CairoPlt, savePlt) {
    
    if (subject == "all") {
      df <- data
    } else {
      df <- filter(data, subID == subject)
    }

    dfAdvsrAcc <- group_by(df, subID) %>%
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
    dfSubAgree <- pltSubAgree(0, subject, F, F) %>% #need to keep this first instance here
      select(1, 3, 5)
    dfSubAgree <- pltSubAgree(0, subject, F, F) %>%
      select(1, 3, 5) %>%
      add_row(
        value = 1 - dfSubAgree$value,
        se = dfSubAgree$se[1:4],
        name = c("L_HH", "L_HL", "L_LH", "L_LL")
      ) %>%
      mutate(group = "sub")

    graphDf <- bind_rows(
      dfSubAgree,
      dfAdvsrAcc
    )

    mytheme <- theme_bw() +
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

    p1 <- ggplot(
      testvar <- filter(graphDf, grepl(cond, name) & (group == "sub")) %>%
        mutate(agremnt = ""),
      aes(x = agremnt, y = value, fill = name)
    ) +
      geom_bar(stat = "identity", position = position_stack(reverse = TRUE), width = .4, color = "black") +
      scale_fill_manual(values = c(
        "H_HH" = "red",
        "L_HH" = "orange",
        "H_HL" = "red",
        "L_HL" = "green",
        "H_LH" = "blue",
        "L_LH" = "orange",
        "H_LL" = "blue",
        "L_LL" = "green"
      )) +
      mytheme +
      labs(
        title = " ",
        x = "Uncalibrated (Top)\nCalibrated (Bottom)"
      ) +
      geom_text(aes(label = round(value, 2)),
        position = position_stack(vjust = 0.5, reverse = TRUE)
      ) +
      theme(
        axis.title.y = element_blank()
      )

    p2 <- ggplot(
      filter(graphDf, grepl(cond, name)) %>%
        filter(group == "advsr"),
      aes(x = name, y = value, group = 1)
    ) +
      geom_line(size = 1.1) +
      geom_errorbar(
        aes(
          ymin = value - se,
          ymax = value + se
        ),
        width = .3,
        colour = "azure4",
        size = 1
      ) +
      geom_point(size = 1.2, aes(color = name), ) +
      scale_color_manual(values = c(
        "H_HH" = "red",
        "L_HH" = "orange",
        "H_HL" = "red",
        "L_HL" = "green",
        "H_LH" = "blue",
        "L_LH" = "orange",
        "H_LL" = "blue",
        "L_LL" = "green"
      )) +
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
      ) +
      scale_x_discrete(
        labels = c(
          "H_HH" = "Calibrated\n High Confidence",
          "H_HL" = "Calibrated\n High Confidence",
          "H_LH" = "Calibrated\n Low Confidence",
          "H_LL" = "Calibrated\n Low Confidence",
          "L_HH" = "Un-Calibrated\n High Confidence",
          "L_HL" = "Un-Calibrated\n Low Confidence",
          "L_LH" = "Un-Calibrated\n High Confidence",
          "L_LL" = "Un-Calibrated\n Low Confidence"
        )
      ) +
      labs(
        title = "Advisor Accuracy with Participant Agreement",
        x = "Advisor Calibration & Confidence",
        y = "Advisor Accuracy"
      ) +
      ylim(0, 1) +
      mytheme

    plt <- p2 + p1

    #if (CairoPlt == T) {
    #  CairoWin()
    #  print(plt)
    #} else {
    #  print(plt)
    #}

    if (savePlt == T) {
      ggsave(
        p2,
        filename = paste0("pAgreeByCondLine ", cond, ".png"),
        dpi = 300,
        type = "cairo",
        width = 5,
        height = 4.5,
        units = "in"
      )

      ggsave(
        p1,
        filename = paste0("pAgreeByCondBar ", cond, ".png"),
        dpi = 300,
        type = "cairo",
        width = 3,
        height = 4.5,
        units = "in"
      )
    }

    if(pltOrDf == 1) {
          return(plt) # change to graphdf or plt
    } else {
      return(graphDf)
    }
  }
