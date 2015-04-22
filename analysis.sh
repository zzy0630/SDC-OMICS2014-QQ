#!/bin/bash
perl generate_data.pl your_qq_log
perl transform_data.pl
perl integrate_words_by_day.pl
perl time_serial.pl
perl time_freq.pl
perl chat.pl
R plots.R
R tests.R
