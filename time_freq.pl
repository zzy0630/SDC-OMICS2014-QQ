#!/usr/bin/perl -w
###this script is written to convert qq_time to qq_time_freq message frequence then draw a heatmap to see who has the same schedule pattern.
open(READ,"qq_time");
@read=<READ>;
close READ;
open(RESULT,"> qq_time_freq");
%hash=();
print RESULT "Person\th00\th01\th02\th03\th04\th05\th06\th07\th08\th09\th10\th11\th12\th13\th14\th15\th16\th17\th18\th19\th20\th21\th22\th23\n";
foreach$single(@read){
  next if $single=~/^Date/;
  chomp $single;
  @sub_array=split(/	/,$single);
  $keys=$sub_array[2].$sub_array[-1];
  $hash{$keys}++;
}
foreach$creat_hash(@read){
  next if $creat_hash=~/^Date/;
  @creat_array=split(/	/,$creat_hash);
  $hash_names{$creat_array[2]}=0;
}
@names=keys%hash_names;

foreach$person(@names){
#print $person,"\n";}
  $n=0;
  print RESULT $person,"\t";
  while(1){
    last if $n==24;
    $sub_key=$person.$n;
    $hash{$sub_key}=0 unless$hash{$sub_key};
    print RESULT $hash{$sub_key},"\t";
    $n++;
  }
  print RESULT "\n";
}
