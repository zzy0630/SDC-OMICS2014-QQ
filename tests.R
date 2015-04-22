###This file records the code that used to do the statistical analysis of a qq chat log. In this case, examplified OMICS data which came from the omics2014 QQ group chat dialog from 2014-9-14 to 2015-2-28;
setwd("/where/you/store/your/data")

###Q1###Are female and male in this class spoke equally? 
###You could perform such analysis if the personal information is availible;

###Q2###How differ I am from others in the number of daily messages?
###omics_by_day is generated from omics_data by #integrate_words_by_day.pl#; Here I would like to look like the disribution of the number of daily messages disribution to see if it's normal.
library(ggplot2)
ori_day<-read.table("qq_by_day",head=T)
ori_day<-ori_day[ori_day$Messages > 0,]#exclude the rows that person actualy didn't talk at that day;
ggplot(data=ori_day)+geom_density(aes(x=Messages,y=..density..,fill=Person))+facet_wrap(~Person,ncol=4,scales=c("free"))+labs(x="Number of Daily Messages",y="Density")+theme(legend.position=0,axis.text=element_text(color="black",size=10),axis.title=element_text(color="black",size=13))###different distribution and not normal, so I have to use ks.test hereafter;
ggsave("q2_diff_dist_facet.pdf",width=8,height=8,dpi=600)
ggsave("q2_diff_dist_facet.png",width=8,height=8,dpi=600)
###Compare my distribution with the distribution of the average daily messages from others;
###KS-test###
###You have to change the #qqnumber by yourself based on who you are interested;
ori_yes<-ori_day[ori_day$Person == "#qqnumber",]
ori_no<-ori_day[!ori_day$Person == "#qqnumber",]
tapply(X=ori_no$Message,INDEX=ori_day$Date,FUN=mean)->ori_mean
mean_no<-as.vector(ori_mean)
q2_ks_no_less<-ks.test(ori_yes$Messages,mean_no,alternative="less")
###alternative="less" means *not* less than.
q2_ks_no_greater<-ks.test(ori_yes$Messages,mean_no,alternative="greater")

###Q3###Are the relationship from personA to personB equal to that from personB to personA---Are the relationships mutually equal?
###Check the distribution of differences;
rel<-read.table("qq_chat_matrix",head=T,row.name=1)
k=1
diff<-c()
for(i in 1:16){
  for(j in 1:16){
    rel[i,j]-rel[j,i]->diff[k]
    k<-k+1
  }
}
diff[order(diff)]->diff
diff<-c(diff[1:104],diff[121:256])#discard 16x0 because they are yielded from one person minus himself; Also every relationship has its reciprocal nubmber in this dataset, so we have to use the absolute value and devide the density by two;
diff_frame<-as.data.frame(diff)
ggplot(data=diff_frame)+geom_density(aes(x=abs(diff),y=..density../2),fill="steelblue")+labs(x="Difference among Mutual relationships",y="Density",title="Distributon of Difference")+theme(axis.text=element_text(color="black",size=10),axis.title=element_text(color="black",size=13),plot.title=element_text(color="black",size=15))+geom_vline(xintercept=0,size=1,linetype=2,color="red")
ggsave("q3_reciprocal_diff_dist.pdf",width=8,height=8,dpi=600)
ggsave("q3_reciprocal_diff_dist.png",width=8,height=8,dpi=600)
#Severely skewed, so we have to use Wilcoxon Rank Sum test;
###Wilcoxon-test
diff<-abs(diff)[1:(length(diff)/2)]#Only use half of the vector, because it's as same the other half;
q3_t<-wilcox.test(diff,mu=0,alternative = "greater")

###Q4###Does the starts and ends correlate with each other?
###Number of starts and ends are normalized by the total message number of that person. Use shapiro.test to check the normality to see if it's suitable to use Pearson correlation for further analysis;
start_end<-read.table("qq_start_end",head=T)
omics_sum<-read.table("qq_summary",head=T)
omics_start_end<-merge(start_end,omics_sum,ID="Person")
x<-omics_start_end$Start/omics_start_end$Message
y<-omics_start_end$End/omics_start_end$Message
q4_shapiro1<-shapiro.test(x)
q4_shapiro2<-shapiro.test(y)
q4_cor<-cor.test(x,y,method="pearson")
lm(y~x)->y_x###Regression
ggplot(data=omics_start_end)+geom_point(aes(x=Start/Message,y=End/Message,color=Person),size=8)+labs(x="Proportion of Starts",y="Proportion of Ends",title="Starts vs. Ends")+geom_text(aes(x=Start/Message,y=End/Message,label=Person),size=5,angle=45)+theme(axis.text=element_text(size=10,color="black"),legend.position=0)+geom_abline(aes(intercept=y_x$coefficients[1],slope=y_x$coefficients[2]),color="black",size=1.2,linetype=2)+theme(axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))
ggsave("q4_start_end.pdf",width=10,height=10,dpi=600)
ggsave("q4_start_end.png",width=10,height=10,dpi=600)
