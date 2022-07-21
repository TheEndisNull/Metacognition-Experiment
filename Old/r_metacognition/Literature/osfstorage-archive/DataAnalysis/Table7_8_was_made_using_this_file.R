# Table 7 and 8 were made using this script.

device <- 1 # Change this device number every running this script.
if (device == 1){
  dat <- read.csv('Study2_ProBook.csv', header = F)
  dat2 <- read.csv('Study2_ProBook_post_hoc.csv', header = F)
} else if (device == 2){
  dat <- read.csv('Study2_OptiPlex.csv', header = F)
  dat2 <- read.csv('Study2_OptiPlex_post_hoc.csv', header = F)
} else if (device == 3){
  dat <- read.csv('Study2_MacBookPro.csv', header = F)
  dat2 <- read.csv('Study2_MacBookPro_post_hoc.csv', header = F)
} else {
  dat <- read.csv('Study2_iMac.csv', header = F)
  dat2 <- read.csv('Study2_iMac_post_hoc.csv', header = F)
}

# "edge" is replaced by "safari" for Mac.
myColNames <- c(
	"chrome_opto1_onset", "chrome_opto1_offset", "chrome_opto1_duration",
	"chrome_mic1_onset", "chrome_mic1_offset", "chrome_mic1_duration",
	"firefox_opto1_onset", "firefox_opto1_offset", "firefox_opto1_duration",
	"firefox_mic1_onset", "firefox_mic1_offset", "firefox_mic1_duration",
	"edge_opto1_onset", "edge_opto1_offset", "edge_opto1_duration",
	"edge_mic1_onset", "edge_mic1_offset", "edge_mic1_duration")

colnames(dat) <- myColNames
colnames(dat2) <- myColNames
intended_times <- c(500, 100) # visual, sound


##############
# No plugin
no_plugin_chrome_mean <- c(
	mean(dat$chrome_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	mean(dat$chrome_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms

no_plugin_chrome_sd <- c(
	sd(dat$chrome_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	sd(dat$chrome_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms
		
no_plugin_firefox_mean <- c(
	mean(dat$firefox_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	mean(dat$firefox_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms

no_plugin_firefox_sd <- c(
	sd(dat$firefox_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	sd(dat$firefox_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms
	
no_plugin_edge_mean <- c(
	mean(dat$edge_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	mean(dat$edge_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms

no_plugin_edge_sd <- c(
	sd(dat$edge_opto1_duration[1:100], na.rm=T), # no_plugin visual soa=500ms
	sd(dat$edge_mic1_duration[1:100], na.rm=T)) # no_plugin audio soa=500ms


##############
# Plugin
plugin_chrome_mean <- c(
	mean(dat$chrome_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	mean(dat$chrome_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms

plugin_chrome_sd <- c(
	sd(dat$chrome_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	sd(dat$chrome_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms
		
plugin_firefox_mean <- c(
	mean(dat$firefox_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	mean(dat$firefox_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms

plugin_firefox_sd <- c(
	sd(dat$firefox_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	sd(dat$firefox_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms
	
plugin_edge_mean <- c(
	mean(dat$edge_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	mean(dat$edge_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms

plugin_edge_sd <- c(
	sd(dat$edge_opto1_duration[501:600], na.rm=T), # plugin visual soa=500ms
	sd(dat$edge_mic1_duration[501:600], na.rm=T)) # plugin audio soa=500ms
		
outputData <- data.frame(
	no_plugin_chrome_mean = round(no_plugin_chrome_mean - intended_times, 1),
	no_plugin_chrome_sd = round(no_plugin_chrome_sd, 1),
	no_plugin_firefox_mean = round(no_plugin_firefox_mean - intended_times, 1),
	no_plugin_firefox_sd = round(no_plugin_firefox_sd, 1),
	no_plugin_edge_mean = round(no_plugin_edge_mean - intended_times, 1),
	no_plugin_edge_sd = round(no_plugin_edge_sd, 1),
	plugin_chrome_mean = round(plugin_chrome_mean - intended_times, 1),
	plugin_chrome_sd = round(plugin_chrome_sd, 1),
	plugin_firefox_mean = round(plugin_firefox_mean - intended_times, 1),
	plugin_firefox_sd = round(plugin_firefox_sd, 1),
	plugin_edge_mean = round(plugin_edge_mean - intended_times, 1),
	plugin_edge_sd = round(plugin_edge_sd, 1))

write.table(outputData, "visual_sound_duration.csv", sep=",", row.names=F, append=T, col.names=T)

##############
# SOA
intended_times <- c(0,20,50,150,500)
no_plugin_chrome_mean <- c(
  mean(dat2$chrome_mic1_onset[1:100] - dat2$chrome_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	mean(dat$chrome_mic1_onset[1:100] - dat$chrome_opto1_onset[1:100], na.rm=T))
no_plugin_chrome_sd <- c(
  sd(dat2$chrome_mic1_onset[1:100] - dat2$chrome_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	sd(dat$chrome_mic1_onset[1:100] - dat$chrome_opto1_onset[1:100], na.rm=T))	
no_plugin_firefox_mean <- c(
  mean(dat2$firefox_mic1_onset[1:100] - dat2$firefox_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	mean(dat$firefox_mic1_onset[1:100] - dat$firefox_opto1_onset[1:100], na.rm=T))
no_plugin_firefox_sd <- c(
  sd(dat2$firefox_mic1_onset[1:100] - dat2$firefox_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	sd(dat$firefox_mic1_onset[1:100] - dat$firefox_opto1_onset[1:100], na.rm=T))	
no_plugin_edge_mean <- c(
  mean(dat2$edge_mic1_onset[1:100] - dat2$edge_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	mean(dat$edge_mic1_onset[1:100] - dat$edge_opto1_onset[1:100], na.rm=T))
no_plugin_edge_sd <- c(
  sd(dat2$edge_mic1_onset[1:100] - dat2$edge_opto1_onset[1:100], na.rm=T),
  NA,
  NA,
  NA,
	sd(dat$edge_mic1_onset[1:100] - dat$edge_opto1_onset[1:100], na.rm=T))	

plugin_chrome_mean <- c(
	mean(dat$chrome_mic1_onset[101:200] - dat$chrome_opto1_onset[101:200], na.rm=T),
	mean(dat$chrome_mic1_onset[201:300] - dat$chrome_opto1_onset[201:300], na.rm=T),
	mean(dat$chrome_mic1_onset[301:400] - dat$chrome_opto1_onset[301:400], na.rm=T),
	mean(dat$chrome_mic1_onset[401:500] - dat$chrome_opto1_onset[401:500], na.rm=T),
	mean(dat$chrome_mic1_onset[501:600] - dat$chrome_opto1_onset[501:600], na.rm=T))

plugin_chrome_sd <- c(
	sd(dat$chrome_mic1_onset[101:200] - dat$chrome_opto1_onset[101:200], na.rm=T),
	sd(dat$chrome_mic1_onset[201:300] - dat$chrome_opto1_onset[201:300], na.rm=T),
	sd(dat$chrome_mic1_onset[301:400] - dat$chrome_opto1_onset[301:400], na.rm=T),
	sd(dat$chrome_mic1_onset[401:500] - dat$chrome_opto1_onset[401:500], na.rm=T),
	sd(dat$chrome_mic1_onset[501:600] - dat$chrome_opto1_onset[501:600], na.rm=T))

plugin_firefox_mean <- c(
	mean(dat$firefox_mic1_onset[101:200] - dat$firefox_opto1_onset[101:200], na.rm=T),
	mean(dat$firefox_mic1_onset[201:300] - dat$firefox_opto1_onset[201:300], na.rm=T),
	mean(dat$firefox_mic1_onset[301:400] - dat$firefox_opto1_onset[301:400], na.rm=T),
	mean(dat$firefox_mic1_onset[401:500] - dat$firefox_opto1_onset[401:500], na.rm=T),
	mean(dat$firefox_mic1_onset[501:600] - dat$firefox_opto1_onset[501:600], na.rm=T))

plugin_firefox_sd <- c(
	sd(dat$firefox_mic1_onset[101:200] - dat$firefox_opto1_onset[101:200], na.rm=T),
	sd(dat$firefox_mic1_onset[201:300] - dat$firefox_opto1_onset[201:300], na.rm=T),
	sd(dat$firefox_mic1_onset[301:400] - dat$firefox_opto1_onset[301:400], na.rm=T),
	sd(dat$firefox_mic1_onset[401:500] - dat$firefox_opto1_onset[401:500], na.rm=T),
	sd(dat$firefox_mic1_onset[501:600] - dat$firefox_opto1_onset[501:600], na.rm=T))

plugin_edge_mean <- c(
	mean(dat$edge_mic1_onset[101:200] - dat$edge_opto1_onset[101:200], na.rm=T),
	mean(dat$edge_mic1_onset[201:300] - dat$edge_opto1_onset[201:300], na.rm=T),
	mean(dat$edge_mic1_onset[301:400] - dat$edge_opto1_onset[301:400], na.rm=T),
	mean(dat$edge_mic1_onset[401:500] - dat$edge_opto1_onset[401:500], na.rm=T),
	mean(dat$edge_mic1_onset[501:600] - dat$edge_opto1_onset[501:600], na.rm=T))

plugin_edge_sd <- c(
	sd(dat$edge_mic1_onset[101:200] - dat$edge_opto1_onset[101:200], na.rm=T),
	sd(dat$edge_mic1_onset[201:300] - dat$edge_opto1_onset[201:300], na.rm=T),
	sd(dat$edge_mic1_onset[301:400] - dat$edge_opto1_onset[301:400], na.rm=T),
	sd(dat$edge_mic1_onset[401:500] - dat$edge_opto1_onset[401:500], na.rm=T),
	sd(dat$edge_mic1_onset[501:600] - dat$edge_opto1_onset[501:600], na.rm=T))	
		
outputData <- data.frame(
	no_plugin_chrome_mean = round(no_plugin_chrome_mean - intended_times, 1),
	no_plugin_chrome_sd = round(no_plugin_chrome_sd, 1),
	no_plugin_firefox_mean = round(no_plugin_firefox_mean - intended_times, 1),
	no_plugin_firefox_sd = round(no_plugin_firefox_sd, 1),
	no_plugin_edge_mean = round(no_plugin_edge_mean - intended_times, 1),
	no_plugin_edge_sd = round(no_plugin_edge_sd, 1),
	plugin_chrome_mean = round(plugin_chrome_mean - intended_times, 1),
	plugin_chrome_sd = round(plugin_chrome_sd, 1),
	plugin_firefox_mean = round(plugin_firefox_mean - intended_times, 1),
	plugin_firefox_sd = round(plugin_firefox_sd, 1),
	plugin_edge_mean = round(plugin_edge_mean - intended_times, 1),
	plugin_edge_sd = round(plugin_edge_sd, 1))

write.table(outputData, "visual_sound_soa.csv", sep=",", row.names=F, append=T, col.names=T)