#!/usr/bin/perl -w
###this script is written to convert the exact time into time point represented by hour from qq_data to qq_time file;
open(READ,"qq_data");
@read=<READ>;
close READ;
open(RESULT,"> qq_time");
print RESULT "Date\tTime\tPerson\tEmoji\tFigure\tWords\tTimePoint\n";
foreach$single(@read){
  next if $single=~/^Date/;
  chomp $single;
  @sub_array=split(/	/,$single);
  @time_array=split(/:/,$sub_array[1]);
  $timepoint=$time_array[0];
  print RESULT $single,"\t",$timepoint,"\n";
}
