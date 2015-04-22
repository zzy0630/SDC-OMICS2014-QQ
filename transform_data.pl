#1/usr/bin/perl -w
#transform the format of qq_data, like a summary;
open(READ,"qq_data");
@read=<READ>;
close READ;
open(RESULT,"> qq_summary");
foreach$creat_hash(@read){
  next if $creat_hash=~/^Date/;
  @creat_array=split(/	/,$creat_hash);
  $hash{$creat_array[2]}=0;
}
%hash_freq=%hash;
%hash_fig=%hash;
%hash_emoji=%hash;
print RESULT "Person\tWord\tFigure\tEmoji\tMessage\n";
foreach$single(@read){
  next if $single=~/^Date/;
  @sub_array=split(/	/,$single);
  $hash_freq{$sub_array[2]}++;
  $hash{$sub_array[2]}=$hash{$sub_array[2]}+$sub_array[5];
  $hash_fig{$sub_array[2]}=$hash_fig{$sub_array[2]}+$sub_array[4];
  $hash_emoji{$sub_array[2]}=$hash_emoji{$sub_array[2]}+$sub_array[3];
}
@name_array=keys%hash;
foreach$names(@name_array){
  print RESULT $names,"\t",$hash{$names},"\t",$hash_fig{$names},"\t",$hash_emoji{$names},"\t",$hash_freq{$names},"\n";
}
