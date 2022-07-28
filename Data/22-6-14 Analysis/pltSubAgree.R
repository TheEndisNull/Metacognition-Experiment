pltSubAgree <-
  function(advAgreement, subject = 'all', CairoPlt=F, savePlt=F) {
    df = mutate(data,
                advAgree = ifelse(hiRslt == loRslt, 1, 0),)
    
    if (subject == 'all') {
      df = filter(df, advAgree == advAgreement)
    } else {
      df = filter(df, advAgree == advAgreement,
                  subID == subject)
    }
    
    df = group_by(df, subID) %>%
      summarize(
        disagree = sum(advAgree != ''),
        HH = sum(hiConf == 1 & loConf == 1),
        HL = sum(hiConf == 1 & loConf == 0),
        LL = sum(hiConf == 0 & loConf == 0),
        LH = sum(hiConf == 0 & loConf == 1),
        
        H_HH = sum(hiConf == 1 &
                     loConf == 1 &
                     correct == hiRslt) / HH,
        H_HL = sum(hiConf == 1 &
                     loConf == 0 &
                     correct == hiRslt) / HL,
        H_LH = sum(hiConf == 0 &
                     loConf == 1 &
                     correct == hiRslt) / LH,
        H_LL = sum(hiConf == 0 &
                     loConf == 0 &
                     correct == hiRslt) / LL,

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
    
    if (subject == 'all') {
      pltTitle = 'Agreement with advisors for ALL subjects'
    } else {
      pltTitle = paste('Agreement with advisors for subject:', subject)
    }
    
    graphdf =
      summarySEwithin(df,
                      measurevar = "value",
                      withinvars = 'name',
                      idvar = "subID")
    
    #print(df)
    #print(graphdf)
    
    width = .8
    dodgeWidth = .85
    errWidth = .4
    errdodgeWidth = .85
    
    plt = ggplot(graphdf, aes(y = value,
                              x = name,
                              fill = name)) +
      geom_bar(
        stat = "identity",
        width = width,
        position = position_dodge(dodgeWidth),
        color = 'black'
      ) +
      
      geom_errorbar(
        aes(ymin = value - se,
            ymax = value + se),
        width = errWidth,
        position = position_dodge(errdodgeWidth),
        colour = "azure4",
        size = 1
      ) +
      geom_hline(yintercept = .50,
                 linetype = "dashed",
                 color = "black") +
      coord_cartesian(ylim = c(0, 1)) +
      labs(title = pltTitle,
           x = 'Advisors Confidence \n(Calibrated/Non-calibrated)',
           y = 'Proportion of Agreement \nwith Calibrated Advisor') +
      
      scale_fill_manual(values = c(
        H_HL = 'blue',
        H_HH = 'red',
        H_LL = 'green',
        H_LH = 'yellow'
      )) +
      scale_x_discrete(
        limits = c('H_HL',
                   'H_HH',
                   'H_LL',
                   'H_LH'),
        labels = c(
          'H_HL' = 'High/Low',
          'H_HH' = 'High/High',
          'H_LL' = 'Low/Low',
          'H_LH' = 'Low/High'
        )
      ) +
      theme_bw() +
      theme(
        plot.title = element_text(size = 15),
        plot.title.position = 'panel',
        axis.title.x = element_text(size = 15),
        axis.title.y = element_text(size = 15),
        legend.position = 'none',
        legend.title = element_text(size = 10),
        legend.text = element_text(size = 10),
        axis.text = element_text(size = 15),
        axis.title = element_text(size = 15),
        axis.line = element_line(colour = "black"),
        panel.grid.major.x = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()
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
        filename = paste0('pAgree.png'),
        dpi = 300,
        type = "cairo",
        width = 8.25,
        height = 4.4,
        units = "in"
      )
    }
    return(df)
  }