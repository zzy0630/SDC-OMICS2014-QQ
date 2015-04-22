#!/usr/bin/perl -w
# the qq_data file counts one english words as half chinese words;
open(READ,"$ARGV[0]");
@read=<READ>;
close READ;
open(RESULT,"> qq_data");
print RESULT "Date\tTime\tPerson\tEmoji\tFigure\tWords\n";
$n=0;
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
    print RESULT $date,"\t",$time,"\t",$person,"\t",$emoji,"\t",$fig,"\t",$words,"\n" unless ($person==10000 or $person==2160);
  }
  $n++;
}
