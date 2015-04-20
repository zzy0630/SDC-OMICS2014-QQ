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
@name=qw(LS TYF ZZY ZJJ ZYX MNT SXP LRH JNN YM ZL WX WJ LYB GWH ZR);
#%hash=();
%hash_ref=();
foreach(@name){
  $hash_ref{$_}={LS=>0,TYF=>0,ZZY=>0,ZJJ=>0,ZYX=>0,MNT=>0,SXP=>0,LRH=>0,JNN=>0,YM=>0,ZL=>0,WX=>0,WJ=>0,LYB=>0,GWH=>0,ZR=>0};
}
$hash{LS}=0;#Liu Shan
$hash{TYF}=0;#Tan Yifan
$hash{ZZY}=0;#Zhang Zeyu
$hash{ZJJ}=0;#Zhu Junjie
$hash{ZYX}=0;#Zhang Yuxing
$hash{MNT}=0;#Martin
$hash{SXP}=0;#Shen Xipeng
$hash{LRH}=0;#Liu Ronghui
$hash{JNN}=0;#Jakob
$hash{YM}=0;#Yang Ming
$hash{ZL}=0;#Zhang Lu
$hash{WX}=0;#Wang Xing
$hash{WJ}=0;#Wang Jia
$hash{LYB}=0;#Liu Yanbo
$hash{GWH}=0;#Guo Wenhui
$hash{ZR}=0;#Zhang Rong
%hash_end=%hash;
#%hash_start={LS=>0,TYF=>0,ZZY=>0,ZJJ=>0,ZYX=>0,MNT=>0,SXP=>0,LRH=>0,JNN=>0,YM=>0,ZL=>0,WX=>0,WJ=>0,LYB=>0,GWH=>0,ZR=>0};
#%hash_end={LS=>0,TYF=>0,ZZY=>0,ZJJ=>0,ZYX=>0,MNT=>0,SXP=>0,LRH=>0,JNN=>0,YM=>0,ZL=>0,WX=>0,WJ=>0,LYB=>0,GWH=>0,ZR=>0};
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
      $$ref{$sub_array1[2]}++;
    }else{
      $hash{$sub_array1[2]}++;
      $hash_end{$sub_array[2]}++;
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
  print RESULT "\t",$_,"2";
}
print RESULT "\n";
###the output result is a 16x16 matrin whose rows represent the person who speak at the first place and columns represent the person who response for it;
foreach$single(@name){
  chomp $single;
  print RESULT1 $single,"\t",$hash{$single},"\t",$hash_end{$single},"\n";
  print RESULT $single,"1\t";
  $ref2=$hash_ref{$single};
  foreach $single1(@name){
    chomp $single1;
    print RESULT $$ref2{$single1},"\t";
  }
  print RESULT "\n";
}







