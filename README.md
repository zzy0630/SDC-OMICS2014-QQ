#SDC-OMICS2014-QQ
Depository of scripts used to analyze QQ log.
Analysis of QQ group chat log
# Note: scripts are not all extentable, some of them need to be modified.
This pepline can help you find out the questions below
### Q1: General information: including message count distribution, word count distribution, figure count distribution and emoji count distribution;
### Q2: Who tend to be outliers among above distributions? Who is the most interesting one? Who is the most boring person?
### Q3: The correlation between conversation starter and terminator;
### Q4: The chat pattern and its correlation with daily events;
### Q5: The balance of relationships among people, that is are people gain as much as they give?
### Q6: To be continued...

You have to export the chat log before you do this analysis, also you should have Perl and R in your computer;
Once you got all you need, let's just do it step by step;  
Note that you have to put these scripts in the same directory as your qq log data;  
First, run following script with the exact order, this will generate several new files from your origin file;  
Scripts:  
generate_data.pl  
transform_data.pl  
integrate_words_by_day.pl  
time_serial.pl  
time_freq.pl  
chat.pl  
You can then run the shell script to run all the perl script at once use the following command if you are using Linux system, before this you have to change the name of your file;  
sh analysis.sh  
Second, open plots.R file, you have to change the front line by typing in the directory where you store your data and newly generated files;  
You can either run this plots.R file at once to see what happen or just draw one figure at a time by copying and pasting respective command, and of course, you can change the code based on your own requirement;  
Third, open tests.R file, do the same thing as you did to plots.R to change the directory;  
This file can help you do four kinds of statistical tests, you can do it yourself if you are interested;  
  
Have fun
