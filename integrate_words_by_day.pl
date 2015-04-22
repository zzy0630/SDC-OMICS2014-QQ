#!/usr/bin/perl -w
#This script is written to add up the words said by one person in one day separately. Thus, we will get the #words from one person day by day;
open(READ,"qq_data");
@read=<READ>;
close READ;
open(RESULT,"> qq_by_day");
foreach$creat_hash(@read){
  next if $creat_hash=~/^Date/;
  @creat_array=split(/	/,$creat_hash);
  $hash{$creat_array[2]}=0;
}
%hash_fig=%hash;
%hash_emoji=%hash;
%hash_message=%hash;
$n=1;
$max=@read;
print RESULT "Date\tPerson\tWord\tEmoji\tFigure\tMessages\n";
while($n<$max-1){
  @sub_array1=split(/	/,$read[$n]);
  @sub_array2=split(/	/,$read[$n+1]);
  if($sub_array1[0]=~$sub_array2[0]){
    $hash{$sub_array1[2]}=$hash{$sub_array1[2]}+$sub_array1[5];
    $hash_fig{$sub_array1[2]}=$hash_fig{$sub_array1[2]}+$sub_array1[4];
    $hash_emoji{$sub_array1[2]}=$hash_emoji{$sub_array1[2]}+$sub_array1[3];
    $hash_message{$sub_array1[2]}++;
  }else{
    $hash{$sub_array1[2]}=$hash{$sub_array1[2]}+$sub_array1[5];
    $hash_fig{$sub_array1[2]}=$hash_fig{$sub_array1[2]}+$sub_array1[4];
    $hash_emoji{$sub_array1[2]}=$hash_emoji{$sub_array1[2]}+$sub_array1[3];
    $hash_message{$sub_array1[2]}++;
    @names=keys%hash;
    foreach$single(@names){
       #next if $hash{$single}+$hash_emoji{$single}+$hash_fig{$single}==0;
       print RESULT $sub_array1[0],"\t",$single,"\t",$hash{$single},"\t",$hash_emoji{$single},"\t",$hash_fig{$single},"\t",$hash_message{$single},"\n";
    }
    foreach$creat_hash1(@read){
    next if $creat_hash1=~/^Date/;
    @creat_array1=split(/	/,$creat_hash1);
    $hash{$creat_array1[2]}=0;
    }
    %hash_fig=%hash;
    %hash_emoji=%hash;
    %hash_message=%hash;
    }
  $n++;
}
