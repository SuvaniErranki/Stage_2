microbial_growth<-read.table("https://raw.githubusercontent.com/HackBio-Internship/public_datasets/main/R/mcb/microbial_stationary_phase.dat",header=TRUE)
head(microbial_growth)
View(microbial_growth)

install.packages("reshape2")
install.packages("ggplot2")
library(reshape2)
library(ggplot2)

?melt()
m<-melt(microbial_growth,id="Time")
head(m)
View(m)
#Plotting ( to check if the samples foloow growth curve with distinct phases)
ggplot(m, aes(Time,value)) + 
  geom_line()+
  facet_wrap(~variable, scales = "free")

########To Determine the time where in each sample bacteria enter stat.phase
## Using slope approach
 #j is cols, i is rows
  ## Firstly, idea is applied for one column at a time
slope<-c()
for (i in 1:54){
  s<-((microbial_growth[i+1,7] - microbial_growth[i,7])/(microbial_growth[i+1,1]-microbial_growth[i,1]))
  slope<-c(slope,s)
}
slope
which.max(slope)
slope[which.max(slope)]


plot(microbial_growth$Time,microbial_growth$A6)
abline(v=microbial_growth[which.max(slope),1])

for(t in which.max(slope):54){
  if (slope[t]<0){
    print(microbial_growth[t,1])
    break;
  }
}
abline(v=microbial_growth[t,1], col="red")


  #########Now for all columns in one go######
for (j in 2:13){
  slope<-c()
  for (i in 1:54){
    s<-((microbial_growth[i+1,j] - microbial_growth[i,j])/(microbial_growth[i+1,1]-microbial_growth[i,1]))
    slope<-c(slope,s)
  }
  #T<-microbial_growth[slope[which.max(slope)],1]
  #ggplot(m, aes(Time,value)) + 
    #geom_line()+
    #facet_wrap(~variable, scales = "free")
  #abline(v=microbial_growth[which.max(slope)],1])
  print(which.max(slope))
  
  
  
   for(t in which.max(slope):54){
     if (slope[t]<0){
         print(t)
         print(microbial_growth[t,1])
         #abline(v=t,col="red")
         break;
     }
   }
  
}  
  
  
##CONCLUSION:
#time point at which microbes enter stat phase for most of the samples(11 out of 12) is same which is 11.8602778  
#and for only the 1st sample it is different which is 5.7386111




