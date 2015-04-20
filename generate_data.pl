#!/usr/bin/perl -w
# the qq_data file counts one english words as half chinese words;
open(READ,"your_qq_record.txt");
@read=<READ>;
close READ;
open(RESULT,"> qq_data");
print RESULT "Date\tTime\tPerson\tEmoji\tFigure\tWords\tGender\tNationality\n";
$n=0;
$hash{739187426}="LS";#Liu Shan
$hash{1053260140}="TYF";#Tan Yifan
$hash{130191630}="ZZY";#Zhang Zeyu
$hash{402374688}="ZJJ";#Zhu Junjie
$hash{745682036}="ZYX";#Zhang Yuxing
$hash{3068126483}="MNT";#Martin
$hash{511189681}="SXP";#Shen Xipeng
$hash{236315059}="LRH";#Liu Ronghui
$hash{1507966345}="JNN";#Jakob
$hash{1518792714}="YM";#Yang Ming
$hash{1282204196}="ZL";#Zhang Lu
$hash{1628685595}="WX";#Wang Xing
$hash{136798799}="WJ";#Wang Jia
$hash{292724348}="LYB";#Liu Yanbo
$hash{125410424}="GWH";#Guo Wenhui
$hash{287382318}="ZR";#Zhang Rong
foreach$single(@read){
  $emoji=0;
  $fig=0;
  $words=0;
  if($single=~/^201[45]-[0-9][0-9]-[0-9][0-9]/){
    chomp$single;
    chomp$read[$n+1];
    @sub_array=split(/	/,$single);
    $date=$sub_array[0];
    $time=$sub_array[1];
    $sub_array[2]=~/([0-9]*)/;
    $person=$1 unless $1==10000 or $1==2160;
    if($hash{$person}=~/LS|TYF|ZL|WJ|GWH|ZR/){
      $gender="female";
    }else{
      $gender="male";
    }
    if($hash{$person}=~/MNT|JNN/){
      $nation="DK";#Denmark
    }else{
      $nation="CN";#China
    }
    @sub_array1=split(/ /,$read[$n+1]);
    foreach$single1(@sub_array1){
      #$emoji++ if $single1=~/emoji/;
      #$fig++ if $single1=~/fig/;
      if($single1=~/emoji/){
        @sub_array2=split(/emoj/,$single1);
        $emoji=@sub_array2;$emoji=$emoji-1 unless $emoji==0;
      }
       if($single1=~/fig/){
        @sub_array3=split(/fig/,$single1);
        $fig=@sub_array3;$fig=$fig-1 unless $fig==0;
      }
      if($single1!~/emoji/ and $single1!~/fig/){
        $words=$words+0.5 if $single1=~/[a-zA-Z]/;
        ##take into account that two english word equals to two chinese words!;
        if($single1!~/[a-zA-Z]/){
          @sub_array4=split(//,$single1);
          $max_n=@sub_array4;
          $words=$words+int(($max_n-1)/3);
        }
      }
    }
    print RESULT $date,"\t",$time,"\t",$hash{$person},"\t",$emoji,"\t",$fig,"\t",$words,"\t",$gender,"\t",$nation,"\n" unless ($person==10000 or $person==2160);
  }
  $n++;
}

