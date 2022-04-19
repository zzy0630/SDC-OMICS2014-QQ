#SDC-OMICS2014-QQ
Depository of scripts used to analyze a QQ log
# Note: scripts are not all extentable, some of them need to be modified.
This pepline can help you find out the questions below
### Q1: General information: including distributions of message count, word count, figure count and emoji count;
### Q2: Who tend to be outliers among above distributions? Who starts the most conversation?
### Q3: Do people have discernable chatting pattern?
### Q4: The chat pattern and its association with daily events;
### Q5: Do people respond to each other equally?
### Q6: To be continued...

To analyze the QQ log:
1. Install Perl and R;

2. Export QQ log and put these scripts in the same directory;

3. Sequentially run the following scripts: 
generate_data.pl  
transform_data.pl  
integrate_words_by_day.pl  
time_serial.pl  
time_freq.pl  
chat.pl  
These scripts will generate new files in the same directory;

4. Open plots.R file, change the directory path in the front line, and draw figures visualizing conversation patterns;
5. Open tests.R file, change the directory path in the front line, and draw statistical conclustions.

Have fun
