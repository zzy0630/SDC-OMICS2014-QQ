###This file records the code that used to draw the plots when analyzing the QQ chat log. Data came from the omics2014 QQ group chat dialog from 2014-9-14 to 2015-2-28;
library(ggplot2)
setwd("/where/you/store/your/data")

###Q1###Who sent the message most frequent?
###order the bar plot based on their value;
###you have to reorder the levels of the factor which is used as X-axis, the default is based on the alphabetic order;
###use theme to adjust the lable and title of the axises of the plot: color and size;
ori<-read.table("qq_data",head=T)
k<-order(summary(ori$Person))
ori$Person<-factor(ori$Person,levels=names(summary(ori$Person))[k])
q1<-ggplot(data=ori)+geom_bar(aes(x=Person),method="identity",fill="steelblue")+labs(title="Distribution of Messages")+theme(axis.text=element_text(color="black",size=15),axis.title=element_text(color="black",size=18),plot.title=element_text(color="black",size=20))
q1
ggsave("q1_message_distribution.pdf",width=10,height=6,dpi=600)
ggsave("q1_message_distribution.png",width=10,height=6,dpi=600)

###Q2###Message distribution among different genders and nationalities;
###You can do such analysis on your own if possible to know the personal information of the members from your QQ group;

###Q3 && Q4###Who sent figures most? Who sent emoji most? Who is the most meaningful(high quality message, more words) guy? Who is the meaningless(low quality message, only picture or emoji) guy?
###Integrated boxplot of words, figures and emoji from each individual;
###Note that you have to use package "gridExtra" to integrate 3 boxplots or transformat data frame then use facet;
library(grid)
library(gridExtra)
a<-ggplot(data=ori)+geom_boxplot(aes(x=Person,y=Words,fill=Person))+ylab("Words/Message")+labs(title="Boxplot of Words per Message")+theme(legend.position=0,axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))
b<-ggplot(data=ori)+geom_boxplot(aes(x=Person,y=Figure,fill=Person))+ylab("Figures/Message")+labs(title="Boxplot of Figures per Message")+theme(legend.position=0,axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))+scale_y_continuous(breaks=c(1,3,5,7,9))
c<-ggplot(data=ori)+geom_boxplot(aes(x=Person,y=Emoji,fill=Person))+ylab("Emoji/Message")+labs(title="Boxplot of Emoji per Message")+theme(legend.position=0,axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))
grid.arrange(a,b,c)#then you have to export this image manually in Rstudio;
###Rarrange the data by perl script #transform_omics.pl# create qq_summary file then plot the ratio between (Figure+Emoji)/Word, I define this ratio as meaningless ratio as the higher this ratio is the more boring that person is;
all<-read.table("qq_summary",head=T)
all$Person<-factor(all$Person,levels=all$Person[order((all$Figure+all$Emoji)/all$Word)])
ggplot(data=all)+geom_bar(aes(x=Person,y=(Figure+Emoji)/Word),stat="identity",fill="orangered")+labs(title="Pictures vs. Words")+theme(axis.title=element_text(color="black",size=15),axis.text=element_text(color="black",size=13),plot.title=element_text(color="black",size=18))
ggsave("q3_ratio_pictures_words.png",width=10,height=6,dpi=600)
ggsave("q3_ratio_pictures_words.pdf",width=10,height=6,dpi=600)
###Still use qq_summary this data file, plot figure on x axis and emoji on y axis, the sizes is adjusted by words number, and the dots are labeled by name;
ggplot(data=all)+geom_point(aes(x=Figure,y=Emoji,color=Person,size=Word))+geom_text(aes(x=Figure,y=Emoji,label=Person),size=3,hjust=1,vjust=1,angle=10)+theme(legend.position=0)+labs(title="Figure vs. Emoji vs. Word")
ggsave("q3_fig-emoji-words_whole.png",width=10,height=6,dpi=600)
ggsave("q3_fig-emoji-words_whole.pdf",width=10,height=6,dpi=600)
###If there are lots of overlapped dots, please use alpha parameter within geom_point() or zoomin by xlim() and ylim();
###Still use omics_summary file, plot a simple words distribution, ordered by the words count to see whom speak most words!
omics_sum<-read.table("qq_summary",head=T)
order(omics_sum$Word)->k
omics_sum$Person<-factor(omics_sum$Person,levels=(omics_sum$Person[k]))
ggplot(data=omics_sum)+geom_bar(aes(x=Person,y=Word),stat="identity",fill="steelblue")+labs(title="Distribution of Words")+theme(axis.text=element_text(color="black",size=15),axis.title=element_text(color="black",size=18),plot.title=element_text(color="black",size=20))
ggsave("q3_words_dist.pdf",width=10,height=6,dpi=600)
ggsave("q3_words_dist.png",width=10,height=6,dpi=600)
###Then normalize words count  by message numbers, that is words per message;
order(omics_sum$Word/omics_sum$Message)->k
omics_sum$Person<-factor(omics_sum$Person,levels=(omics_sum$Person[k]))
ggplot(data=omics_sum)+geom_bar(aes(x=Person,y=Word/Message),stat="identity",fill="steelblue")+labs(title="Distribution of Words/Messages")+theme(axis.text=element_text(color="black",size=15),axis.title=element_text(color="black",size=18),plot.title=element_text(color="black",size=20))
ggsave("q3_words_message_dist.pdf",width=10,height=6,dpi=600)
ggsave("q3_words_message_dist.png",width=10,height=6,dpi=600)

###Q4###Word Cloud analysis;
###This aims to find out which word spoke most frequently in the qq group, hard to apply this on Chinese, I will do it later;
###Use perl script #generate_text.pl# to generate the text for word cloud analysis;

###Q5###Time series analysis;
###How does the words frequency change during the time?
library(scales)
ori<-read.table("qq_data",head=T)
ori$Date<-as.Date(ori$Date)
ggplot(data=ori)+geom_point(aes(x=Date,y=Words,color=Person))+scale_x_date(breaks=date_breaks("week"))+labs(title="Words Count Change Pattern")+theme(axis.text=element_text(angle=90))+theme(axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))
ggsave("q5_words_freq_weekly.pdf",width=10,height=10,dpi=600)
ggsave("q5_words_freq_weekly.png",width=10,height=10,dpi=600)
###Data reformed by perl script #integrate_words_by_day.pl# transfer the qq_data into qq_by_day which is an updated version that words come from one person in one day are added up; Points and lines are grouped by person;
ori1<-read.table("qq_by_day",head=T)
ori1$Date<-as.Date(ori1$Date)
ggplot(data=ori1)+geom_point(aes(x=Date,y=Word,color=Person))+scale_x_date(breaks="week")+labs(title="Words Freq. Change Pattern")+theme(axis.text=element_text(angle=90,color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))+geom_line(aes(x=Date,y=Word,color=Person,group=Person))
ggsave("q5_words_added.pdf",width=20,height=10,dpi=600)
ggsave("q5_words_added.png",width=20,height=10,dpi=600)
###Tried to add events like holiday and presentations to find a chat pattern;
###You have to create this events dataframe yourself based on the included holiday and events within the time range of your data, in this case, here is just an example;
presentation<-c("2014-09-19","2014-09-28","2014-10-14","2014-10-21","2014-10-24","2014-11-03","2014-11-05","2014-11-07","2014-11-03","2014-12-04","2014-12-11","2014-12-16","2015-01-08","2015-01-12","2015-01-14")
holiday<-c("2014-10-1","2014-12-25","2015-01-01","2015-02-19")
#You can create the events on your own, here is just an example;
preset<-as.Date(presentation)
holi<-as.Date(holiday)
event2<-rep("Presentation or Exam",length(preset))
event1<-rep("Holiday",length(holi))
Event<-c(event1,event2)
Date<-c(holi,preset)
events<-data.frame(Date,Event)
ggplot(data=ori1)+geom_point(aes(x=Date,y=Word,color=Person))+scale_x_date(breaks="week")+labs(title="Words Freq. Change Pattern")+theme(axis.text=element_text(angle=90,color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))+geom_line(aes(x=Date,y=Word,color=Person,group=Person))+geom_rect(data=events,aes(xmin=Date,xmax=Date+0.5,fill=Event),ymin=0,ymax=700,alpha=0.5)
ggsave("q5_words_added_events.pdf",width=20,height=10,dpi=600)
ggsave("q5_words_added_events.png",width=20,height=10,dpi=600)
###Time point analysis at each hour in a day to see the chat pattern;
###Original data qq_data is transform by perl script #time_serial.pl# to creat qq_time used in this analysis; Because I can't find a way to convert Time column into time format without adding the present date infront of the time, so I used the above perl script to do such job;
ori1<-read.table("qq_time",head=T)
#ggplot(data=ori1)+geom_bar(aes(x=TimePoint,fill=Person),stat="bin",binwidth=1,position="stack")+theme(axis.text=element_text(color="black",size=13),axis.title=element_text(color="black",size=15),plot.title=element_text(color="black",size=18))+scale_x_continuous(breaks=0:23)+labs(title="Overall Message Distribution in a Day")+xlab("Hour")+ylab("Messages")
#ggsave("q5_dist_one_day.pdf",width=15,height=10,dpi=600)
#ggsave("q5_dist_one_day.png",width=15,height=10,dpi=600)
###Last plot facted by person using facet_wrap to creat 4X4 facets;
ggplot(data=ori1)+geom_bar(aes(x=TimePoint,fill=Person),stat="bin",binwidth=1,position="stack")+theme(axis.text=element_text(color="black",size=10,angle=90),legend.position=0)+scale_x_continuous(breaks=0:23)+labs(title="Overall Message Distribution in a Day")+xlab("Hour")+ylab("Messages")+facet_wrap(~Person,ncol=4,scales="free_y")
ggsave("q5_dist_one_day_facet.pdf",width=15,height=10,dpi=600)
ggsave("q5_dist_one_day_facet.png",width=15,height=10,dpi=600)
###Use perl script #time_freq.pl# to convert qq_time to qq_time_freq. This new file is a 16X24 table which can be used to create a heatmap, then I can do clustering to see who have the same time schedule pattern.
library(gplots)
freq<-read.table("qq_time_freq",head=T,row.name=1)
freq_matrix<-as.matrix(freq)
freq_matrix<-t(freq_matrix)
pdf("q5_one_day_heatmap.pdf")
col=colorpanel(10,low="blue",high="yellow")
heatmap.2(freq_matrix,Colv=T,Rowv=F,col=col,margins=c(4,4),dendrogram="column",trace="none",keysize=(0.9),density.info="none",main="Rhythm Table",scale="column",cexCol=1,srtCol=45,cexRow=1,adjCol=c(0.8,0.8),key.title=NA,symkey=T,key.xlab=NA,key.par=list(mgp=c(1.5, 0.5, 0),mar=c(2.5, 2.5, 2.0, 0)))
dev.off()
png("q5_one_day_heatmap.png")
col=colorpanel(10,low="blue",high="yellow")
heatmap.2(freq_matrix,Colv=T,Rowv=F,col=col,margins=c(4,4),dendrogram="column",trace="none",keysize=(0.9),density.info="none",main="Rhythm Table",scale="column",cexCol=1,srtCol=45,cexRow=1,adjCol=c(0.8,0.8),key.title=NA,symkey=T,key.xlab=NA,key.par=list(mgp=c(1.5, 0.5, 0),mar=c(2.5, 2.5, 2.0, 0)))
dev.off()
###Cluster both among persons and time;
pdf("q5_one_day_heatmap_both.pdf")
col=colorpanel(10,low="blue",high="yellow")
heatmap.2(freq_matrix,Colv=T,Rowv=T,col=col,margins=c(4,4),dendrogram="both",trace="none",keysize=(0.9),density.info="none",main="Rhythm Table",scale="column",cexCol=1,srtCol=45,cexRow=1,adjCol=c(0.8,0.8),key.title=NA,symkey=T,key.xlab=NA,key.par=list(mgp=c(1.5, 0.5, 0),mar=c(2.5, 2.5, 2.0, 0)))
dev.off()
png("q5_one_day_heatmap_both.png")
col=colorpanel(10,low="blue",high="yellow")
heatmap.2(freq_matrix,Colv=T,Rowv=T,col=col,margins=c(4,4),dendrogram="both",trace="none",keysize=(0.9),density.info="none",main="Rhythm Table",scale="column",cexCol=1,srtCol=45,cexRow=1,adjCol=c(0.8,0.8),key.title=NA,symkey=T,key.xlab=NA,key.par=list(mgp=c(1.5, 0.5, 0),mar=c(2.5, 2.5, 2.0, 0)))
dev.off()

###Q6###Intimacy between two persons; Who started conversation most? Who ended conversation most?
###Use perl script #chat.pl# to convert qq_data to qq_chat_matrix and qq_start_end file, note that the time interval during which nobody talked to separate two conversations is defined as 1 hour;
###The qq_chat_matrix contains 16x16 matrix which represents the intemacy of two persons. The persons in row are those speak at the first place, the persons in column are those who response for it to make this conversation;
###The qq_start_end file gives the total number of conversations and the person who started or ended these conversations;
###Draw a heatmap using ggplot2 not gplots;
library(reshape2)
omics<-read.table("qq_chat_matrix",head=T)
omi<-melt(omics)
omi$Person<-factor(omi$Person,levels=levels(omi$Person),ordered=T)
ggplot(data=omi)+geom_bin2d(aes(x=Person,y=variable,fill=scale(value)))+scale_fill_gradient(low="white",high="black")+theme(axis.text.x=element_text(color="black",angle=45,size=12),axis.text.y=element_text(color="black",size=12),plot.title=element_text(color="black",size=15))+labs(title="Intimacy among People",x=NULL,y=NULL,fill="Scale")
ggsave("q6_intimacy_heatmap.pdf",width=10,height=10,dpi=600)
ggsave("q6_intimacy_heatmap.png",width=10,height=10,dpi=600)
###Explore who started or ended conversations most;
###The number of started or ended a conversation is normalized by the number of total messages that person gave;
start_end<-read.table("qq_start_end",head=T)
omics_sum<-read.table("qq_summary",head=T)
omics_start_end<-merge(start_end,omics_sum,by="Person")
ggplot(data=omics_start_end)+geom_point(aes(x=Start/Message,y=End/Message,color=Person),size=8)+labs(x="Proportion of Starts",y="Proportion of Ends",title="Starts vs. Ends")+geom_text(aes(x=Start/Message,y=End/Message,label=Person),size=5,angle=45)+theme(axis.text=element_text(size=10,color="black"),legend.position=0)
ggsave("q6_start_end.pdf",width=10,height=10,dpi=600)
ggsave("q6_start_end.png",width=10,height=10,dpi=600)
