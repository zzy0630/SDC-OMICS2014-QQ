#!/usr/bin/perl -w
###this script is written to convert omics_data to omics_chat_matrix which represent the intemacy between two persons;
open(READ,"qq_data");
@read=<READ>;
close READ;
open(RESULT,"> qq_chat_matrix");
open(RESULT1,"> qq_start_end");
print RESULT1 "Person\tStart\tEnd\n";
$n=1;
$max=@read;
foreach$creat_hash(@read){
  next if $creat_hash=~/^Date/;
  @creat_array=split(/	/,$creat_hash);
  $hash_names{$creat_array[2]}=0;
}
%hash=%hash_names;
@name=keys%hash_names;
#%hash=();
#%hash_ref=();
foreach$temp_name(@name){
  foreach$temp_name1(@name){
    $hash_ref{$temp_name}{$temp_name1}=0;
  }
  
}
%hash_end=%hash;
while($n<$max-2){
  chomp $read[$n];
  chomp $read[$n+1];
  @sub_array=split(/	/,$read[$n]);
  @sub_array1=split(/	/,$read[$n+1]);
  $sub_array[0]=~/^[0-9][0-9][0-9][0-9]\-[0-9][0-9]\-([0-9][0-9])$/;
  $day1=$1;
  $sub_array1[0]=~/^[0-9][0-9][0-9][0-9]\-[0-9][0-9]\-([0-9][0-9])$/;
  $day2=$1;
  $sub_array[1]=~/^([0-9]?[0-9])\:([0-9][0-9])\:[0-9][0-9]$/;
  $hour1=$1;
  $min1=$2;
  $sub_array1[1]=~/^([0-9]?[0-9])\:([0-9][0-9])\:[0-9][0-9]$/;
  $hour2=$1;
  $min2=$2;
  #$secondday=~/^[0-9][0-9][0-9][0-9][0-9][0-9]([0-9][0-9])([0-9][0-9])([0-9][0-9])[0-9][0-9]$/;
  #$day2=$1;
  #$hour2=$2;
  #$min2=$3;
  $ref=$hash_ref{$sub_array[2]};
  if(abs($hour2-$hour1)>=1){
    if(($min2-$min1)>=0){
      #$$ref{$sub_array1[2]}++;
      $hash{$sub_array1[2]}++;
      $hash_end{$sub_array[2]}++;
    }else{
      $$ref{$sub_array1[2]}++;
      #$hash{$sub_array1[2]}++;
      #$hash_end{$sub_array[2]}++;
    }
  }else{
    if($day2==$day1){
      $$ref{$sub_array1[2]}++;
    }else{
      $hash{$sub_array1[2]}++;
      $hash_end{$sub_array[2]}++;
    }
  }
  $n++;
}
print RESULT "Person";
foreach(@name){
  chomp $_;
  print RESULT "\t",$_,"b";
}
print RESULT "\n";
###the output result is a 16x16 matrix whose rows represent the person who speak at the first place and columns represent the person who response for it;
foreach$single(@name){
  chomp $single;
  print RESULT1 $single,"\t",$hash{$single},"\t",$hash_end{$single},"\n";
  print RESULT $single,"a\t";
  $ref2=$hash_ref{$single};
  foreach $single1(@name){
    chomp $single1;
    print RESULT $$ref2{$single1},"\t";
  }
  print RESULT "\n";
}
