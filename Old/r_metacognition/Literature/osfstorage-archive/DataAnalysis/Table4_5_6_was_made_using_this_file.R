# Table 4, 5, and 6 were made using this script.

device <- 1 # Change this device number every running this script.
if (device == 1){
  dat <- read.csv('Study1_ProBook.csv', header = F)
} else if (device == 2){
  dat <- read.csv('Study1_OptiPlex.csv', header = F)
} else if (device == 3){
  dat <- read.csv('Study1_MacBookPro.csv', header = F)
} else {
  dat <- read.csv('Study1_iMac.csv', header = F)
}
# "edge" is replaced by "safari" for Mac.
myColNames <- c(
	"chrome_no_plugin_opto2_onset", "chrome_no_plugin_opto2_offset", "chrome_no_plugin_opto2_duration",
	"chrome_no_plugin_opto1_onset", "chrome_no_plugin_opto1_offset", "chrome_no_plugin_opto1_duration",
	"chrome_plugin_opto2_onset", "chrome_plugin_opto2_offset", "chrome_plugin_opto2_duration",
	"chrome_plugin_opto1_onset", "chrome_plugin_opto1_offset", "chrome_plugin_opto1_duration",
	"firefox_no_plugin_opto2_onset", "firefox_no_plugin_opto2_offset", "firefox_no_plugin_opto2_duration",
	"firefox_no_plugin_opto1_onset", "firefox_no_plugin_opto1_offset", "firefox_no_plugin_opto1_duration",
	"firefox_plugin_opto2_onset", "firefox_plugin_opto2_offset", "firefox_plugin_opto2_duration",
	"firefox_plugin_opto1_onset", "firefox_plugin_opto1_offset", "firefox_plugin_opto1_duration",
	"edge_no_plugin_opto2_onset", "edge_no_plugin_opto2_offset", "edge_no_plugin_opto2_duration",
	"edge_no_plugin_opto1_onset", "edge_no_plugin_opto1_offset", "edge_no_plugin_opto1_duration",
	"edge_plugin_opto2_onset", "edge_plugin_opto2_offset", "edge_plugin_opto2_duration",
	"edge_plugin_opto1_onset", "edge_plugin_opto1_offset", "edge_plugin_opto1_duration")
colnames(dat) <- myColNames

intended_times <- c(20, 50, 150, 500)

##############
# No plugin
no_plugin_chrome_mean <- c(
	mean(dat$chrome_no_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$chrome_no_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$chrome_no_plugin_opto1_duration[401:800], na.rm=T))

no_plugin_chrome_sd <- c(
	sd(dat$chrome_no_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$chrome_no_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$chrome_no_plugin_opto1_duration[401:800], na.rm=T))

no_plugin_firefox_mean <- c(
	mean(dat$firefox_no_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$firefox_no_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$firefox_no_plugin_opto1_duration[401:800], na.rm=T))

no_plugin_firefox_sd <- c(
	sd(dat$firefox_no_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$firefox_no_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$firefox_no_plugin_opto1_duration[401:800], na.rm=T))

no_plugin_edge_mean <- c(
	mean(dat$edge_no_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$edge_no_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$edge_no_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$edge_no_plugin_opto1_duration[401:800], na.rm=T))

no_plugin_edge_sd <- c(
	sd(dat$edge_no_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$edge_no_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$edge_no_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$edge_no_plugin_opto1_duration[401:800], na.rm=T))

##############
# Plugin
plugin_chrome_mean <- c(
	mean(dat$chrome_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$chrome_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$chrome_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$chrome_plugin_opto1_duration[401:800], na.rm=T))

plugin_chrome_sd <- c(
	sd(dat$chrome_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$chrome_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$chrome_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$chrome_plugin_opto1_duration[401:800], na.rm=T))

plugin_firefox_mean <- c(
	mean(dat$firefox_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$firefox_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$firefox_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$firefox_plugin_opto1_duration[401:800], na.rm=T))

plugin_firefox_sd <- c(
	sd(dat$firefox_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$firefox_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$firefox_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$firefox_plugin_opto1_duration[401:800], na.rm=T))

plugin_edge_mean <- c(
	mean(dat$edge_plugin_opto2_duration[1:400], na.rm=T),
	mean(dat$edge_plugin_opto2_duration[401:800], na.rm=T),
	mean(dat$edge_plugin_opto1_duration[1:400], na.rm=T),
	mean(dat$edge_plugin_opto1_duration[401:800], na.rm=T))

plugin_edge_sd <- c(
	sd(dat$edge_plugin_opto2_duration[1:400], na.rm=T),
	sd(dat$edge_plugin_opto2_duration[401:800], na.rm=T),
	sd(dat$edge_plugin_opto1_duration[1:400], na.rm=T),
	sd(dat$edge_plugin_opto1_duration[401:800], na.rm=T))


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

write.table(outputData, "duration.csv", sep=",", row.names=F, append=T, col.names=T)

######################
## SOA 150-20

no_plugin_chrome_soa_mean <- c(
	mean(dat$chrome_no_plugin_opto2_onset[1:100] - dat$chrome_no_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[101:200] - dat$chrome_no_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[201:300] - dat$chrome_no_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[301:400] - dat$chrome_no_plugin_opto1_onset[301:400], na.rm=T))

no_plugin_chrome_soa_sd <- c(
	sd(dat$chrome_no_plugin_opto2_onset[1:100] - dat$chrome_no_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[101:200] - dat$chrome_no_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[201:300] - dat$chrome_no_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[301:400] - dat$chrome_no_plugin_opto1_onset[301:400], na.rm=T))

no_plugin_firefox_soa_mean <- c(
	mean(dat$firefox_no_plugin_opto2_onset[1:100] - dat$firefox_no_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[101:200] - dat$firefox_no_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[201:300] - dat$firefox_no_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[301:400] - dat$firefox_no_plugin_opto1_onset[301:400], na.rm=T))

no_plugin_firefox_soa_sd <- c(
	sd(dat$firefox_no_plugin_opto2_onset[1:100] - dat$firefox_no_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[101:200] - dat$firefox_no_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[201:300] - dat$firefox_no_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[301:400] - dat$firefox_no_plugin_opto1_onset[301:400], na.rm=T))

no_plugin_edge_soa_mean <- c(
	mean(dat$edge_no_plugin_opto2_onset[1:100] - dat$edge_no_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[101:200] - dat$edge_no_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[201:300] - dat$edge_no_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[301:400] - dat$edge_no_plugin_opto1_onset[301:400], na.rm=T))

no_plugin_edge_soa_sd <- c(
	sd(dat$edge_no_plugin_opto2_onset[1:100] - dat$edge_no_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[101:200] - dat$edge_no_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[201:300] - dat$edge_no_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[301:400] - dat$edge_no_plugin_opto1_onset[301:400], na.rm=T))
	
plugin_chrome_soa_mean <- c(
	mean(dat$chrome_plugin_opto2_onset[1:100] - dat$chrome_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[101:200] - dat$chrome_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[201:300] - dat$chrome_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[301:400] - dat$chrome_plugin_opto1_onset[301:400], na.rm=T))

plugin_chrome_soa_sd <- c(
	sd(dat$chrome_plugin_opto2_onset[1:100] - dat$chrome_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[101:200] - dat$chrome_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[201:300] - dat$chrome_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[301:400] - dat$chrome_plugin_opto1_onset[301:400], na.rm=T))

plugin_firefox_soa_mean <- c(
	mean(dat$firefox_plugin_opto2_onset[1:100] - dat$firefox_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[101:200] - dat$firefox_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[201:300] - dat$firefox_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[301:400] - dat$firefox_plugin_opto1_onset[301:400], na.rm=T))

plugin_firefox_soa_sd <- c(
	sd(dat$firefox_plugin_opto2_onset[1:100] - dat$firefox_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[101:200] - dat$firefox_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[201:300] - dat$firefox_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[301:400] - dat$firefox_plugin_opto1_onset[301:400], na.rm=T))

plugin_edge_soa_mean <- c(
	mean(dat$edge_plugin_opto2_onset[1:100] - dat$edge_plugin_opto1_onset[1:100], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[101:200] - dat$edge_plugin_opto1_onset[101:200], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[201:300] - dat$edge_plugin_opto1_onset[201:300], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[301:400] - dat$edge_plugin_opto1_onset[301:400], na.rm=T))

plugin_edge_soa_sd <- c(
	sd(dat$edge_plugin_opto2_onset[1:100] - dat$edge_plugin_opto1_onset[1:100], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[101:200] - dat$edge_plugin_opto1_onset[101:200], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[201:300] - dat$edge_plugin_opto1_onset[201:300], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[301:400] - dat$edge_plugin_opto1_onset[301:400], na.rm=T))
	
outputData2 <- data.frame(
	no_plugin_chrome_soa_mean = round(no_plugin_chrome_soa_mean - intended_times, 1),
	no_plugin_chrome_soa_sd = round(no_plugin_chrome_soa_sd, 1),
	no_plugin_firefox_soa_mean = round(no_plugin_firefox_soa_mean - intended_times, 1),
	no_plugin_firefox_soa_sd = round(no_plugin_firefox_soa_sd, 1),
	no_plugin_edge_soa_mean = round(no_plugin_edge_soa_mean - intended_times, 1),
	no_plugin_edge_soa_sd = round(no_plugin_edge_soa_sd, 1),
	plugin_chrome_soa_mean = round(plugin_chrome_soa_mean - intended_times, 1),
	plugin_chrome_soa_sd = round(plugin_chrome_soa_sd, 1),
	plugin_firefox_soa_mean = round(plugin_firefox_soa_mean - intended_times, 1),
	plugin_firefox_soa_sd = round(plugin_firefox_soa_sd, 1),
	plugin_edge_soa_mean = round(plugin_edge_soa_mean - intended_times, 1),
	plugin_edge_soa_sd = round(plugin_edge_soa_sd, 1)
	)
	
write.table(outputData2, "SOA_150_20.csv", sep=",", row.names=F, append=T, col.names=T)


######################
## SOA 500-50

no_plugin_chrome_soa_mean <- c(
	mean(dat$chrome_no_plugin_opto2_onset[401:500] - dat$chrome_no_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[501:600] - dat$chrome_no_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[601:700] - dat$chrome_no_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$chrome_no_plugin_opto2_onset[701:800] - dat$chrome_no_plugin_opto1_onset[701:800], na.rm=T))

no_plugin_chrome_soa_sd <- c(
	sd(dat$chrome_no_plugin_opto2_onset[401:500] - dat$chrome_no_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[501:600] - dat$chrome_no_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[601:700] - dat$chrome_no_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$chrome_no_plugin_opto2_onset[701:800] - dat$chrome_no_plugin_opto1_onset[701:800], na.rm=T))

no_plugin_firefox_soa_mean <- c(
	mean(dat$firefox_no_plugin_opto2_onset[401:500] - dat$firefox_no_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[501:600] - dat$firefox_no_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[601:700] - dat$firefox_no_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$firefox_no_plugin_opto2_onset[701:800] - dat$firefox_no_plugin_opto1_onset[701:800], na.rm=T))

no_plugin_firefox_soa_sd <- c(
	sd(dat$firefox_no_plugin_opto2_onset[401:500] - dat$firefox_no_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[501:600] - dat$firefox_no_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[601:700] - dat$firefox_no_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$firefox_no_plugin_opto2_onset[701:800] - dat$firefox_no_plugin_opto1_onset[701:800], na.rm=T))

no_plugin_edge_soa_mean <- c(
	mean(dat$edge_no_plugin_opto2_onset[401:500] - dat$edge_no_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[501:600] - dat$edge_no_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[601:700] - dat$edge_no_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$edge_no_plugin_opto2_onset[701:800] - dat$edge_no_plugin_opto1_onset[701:800], na.rm=T))

no_plugin_edge_soa_sd <- c(
	sd(dat$edge_no_plugin_opto2_onset[401:500] - dat$edge_no_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[501:600] - dat$edge_no_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[601:700] - dat$edge_no_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$edge_no_plugin_opto2_onset[701:800] - dat$edge_no_plugin_opto1_onset[701:800], na.rm=T))
	
plugin_chrome_soa_mean <- c(
	mean(dat$chrome_plugin_opto2_onset[401:500] - dat$chrome_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[501:600] - dat$chrome_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[601:700] - dat$chrome_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$chrome_plugin_opto2_onset[701:800] - dat$chrome_plugin_opto1_onset[701:800], na.rm=T))

plugin_chrome_soa_sd <- c(
	sd(dat$chrome_plugin_opto2_onset[401:500] - dat$chrome_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[501:600] - dat$chrome_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[601:700] - dat$chrome_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$chrome_plugin_opto2_onset[701:800] - dat$chrome_plugin_opto1_onset[701:800], na.rm=T))

plugin_firefox_soa_mean <- c(
	mean(dat$firefox_plugin_opto2_onset[401:500] - dat$firefox_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[501:600] - dat$firefox_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[601:700] - dat$firefox_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$firefox_plugin_opto2_onset[701:800] - dat$firefox_plugin_opto1_onset[701:800], na.rm=T))

plugin_firefox_soa_sd <- c(
	sd(dat$firefox_plugin_opto2_onset[401:500] - dat$firefox_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[501:600] - dat$firefox_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[601:700] - dat$firefox_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$firefox_plugin_opto2_onset[701:800] - dat$firefox_plugin_opto1_onset[701:800], na.rm=T))

plugin_edge_soa_mean <- c(
	mean(dat$edge_plugin_opto2_onset[401:500] - dat$edge_plugin_opto1_onset[401:500], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[501:600] - dat$edge_plugin_opto1_onset[501:600], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[601:700] - dat$edge_plugin_opto1_onset[601:700], na.rm=T),
	mean(dat$edge_plugin_opto2_onset[701:800] - dat$edge_plugin_opto1_onset[701:800], na.rm=T))

plugin_edge_soa_sd <- c(
	sd(dat$edge_plugin_opto2_onset[401:500] - dat$edge_plugin_opto1_onset[401:500], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[501:600] - dat$edge_plugin_opto1_onset[501:600], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[601:700] - dat$edge_plugin_opto1_onset[601:700], na.rm=T),
	sd(dat$edge_plugin_opto2_onset[701:800] - dat$edge_plugin_opto1_onset[701:800], na.rm=T))
	
outputData3 <- data.frame(
	no_plugin_chrome_soa_mean = round(no_plugin_chrome_soa_mean - intended_times, 1),
	no_plugin_chrome_soa_sd = round(no_plugin_chrome_soa_sd, 1),
	no_plugin_firefox_soa_mean = round(no_plugin_firefox_soa_mean - intended_times, 1),
	no_plugin_firefox_soa_sd = round(no_plugin_firefox_soa_sd, 1),
	no_plugin_edge_soa_mean = round(no_plugin_edge_soa_mean - intended_times, 1),
	no_plugin_edge_soa_sd = round(no_plugin_edge_soa_sd, 1),
	plugin_chrome_soa_mean = round(plugin_chrome_soa_mean - intended_times, 1),
	plugin_chrome_soa_sd = round(plugin_chrome_soa_sd, 1),
	plugin_firefox_soa_mean = round(plugin_firefox_soa_mean - intended_times, 1),
	plugin_firefox_soa_sd = round(plugin_firefox_soa_sd, 1),
	plugin_edge_soa_mean = round(plugin_edge_soa_mean - intended_times, 1),
	plugin_edge_soa_sd = round(plugin_edge_soa_sd, 1)
	)
	
write.table(outputData3, "SOA_500_50.csv", sep=",", row.names=F, append=T, col.names=T)
