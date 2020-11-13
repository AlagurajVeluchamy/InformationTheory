#!/usr/bin/perl
use CGI qw(:standard);
use warnings;
print header;
print start_html;

my $sequence =param('sequence');

my $file =param('file');
 $file =~ s/.*[\/\\](.*)/$1/;

 my $name = $2;
if($file){
open(LOCAL, ">/tmp/$file") or die $!;
while(<$file>) {
print LOCAL $_;
 }
  }
 else
  {
 $file=substr($sequence,0,8);
 open(LOCAL, ">/tmp/$file") or die $!;
 print LOCAL "$sequence \n";
 close(LOCAL);
  }

$out='output';
for($i=1;$i<=3;$i++){
open(KH,"|/usr/local/bin/compseq");
  print KH "/tmp/$file\n"; #test seq filename
print KH "$i\n";    
print KH "/tmp/$out$i\n";   
}
close KH;

for(my $a=1;$a<=3;$a++){
 if ($a==1){$fileout='output1';}
 if ($a==2){$fileout='output2';}
 if ($a==3){$fileout='output3';}

system("chmod 777 /tmp/$fileout");                                              

 open(FILE, "/tmp/$fileout");
 my @r=<FILE>;
 
 my $u=0;
 my $v=0;
 my $w=0;
 for (my $i=0;$i <$#r;$i++){
        $read=$r[$i];
 
   if (($read=~m/^\w\s/)||($read=~m/^\w\w\s/)||($read=~m/^\w\w\w\s/)){
   $read=~m/(0\..*?)\s/;

 if ($a==1){$pa[$u]=$1;$u++;}
 if ($a==2){$x[$v]=$1;$v++;}
 if ($a==3){$q[$w]=$1;$w++;}
   }
   }
   }

$sum=0;
$sum1=0;
       for ($i=0;$i<=3;$i++){
            $sum=$sum+$pa[$i];}

       for ($i=0;$i<=3;$i++){
        $b[$i]=$pa[$i]/$sum;
$c[$i]=$b[$i]*-(log($b[$i])/log(2));
$sum1=$sum1+$c[$i];}

$j1= $pa[0]/$pa[3];
$j2= $pa[2]/$pa[1];
$d1=2-$sum1;
$tot=0;
$paa=0;
  for ($i=0;$i<=15;$i++){    
       
       $tot=$tot+$x[$i];}

  for ($i=0;$i<=15;$i++){
       $paa[$i]=$x[$i]/$tot;}

$j=0;
$cnt=0;
$hm2=0;

while ($j<=3)
{
   
     for ($i=0;$i<=15;$i++)
           { 
            
     
                 $y[$i]=$paa[$i]/$b[$j];
                 $cnt++;
                 $d[$i]=-(log($y[$i])/log(2));
                 $w[$i]=$b[$j]*$y[$i]*$d[$i];
                 $hm2=$hm2+$w[$i];
                 if ($cnt%4==0)
                  {
                   $j++;
                   $cnt=0;
                  }
                 
               
               }

}

$d2=$sum1-$hm2;

$total=0;
$paaa=0;
      for ($i=0;$i<=63;$i++){
          $total=$total+$q[$i];}
     for ($i=0;$i<=63;$i++){
         $paaa[$i]=$q[$i]/$total;}
$n=0;
$m=0;
$cnt1=0;
$cnt2=0;
$sum3=0;
       while($m<=3)
{
       while($n<=15)
{
       for ($i=0;$i<=63;$i++){
        $z[$i]=$paaa[$i]/$paa[$n];
            $w[$i]=-(log($z[$i])/log(2));
            $pro[$i]=$b[$m]*$y[$n]*$z[$i]*$w[$i];
     $sum3=$sum3+$pro[$i];
     $cnt1++;
    $cnt2++;
              if($cnt1%4==0){
                      $n++;
                       $cnt1=0;}
               if($cnt2==16){
                       $m++;
                  	$cnt2=0;}}	 
}

}
$d3=$hm2-$sum3;
$id=$d1+$d2+$d3;

print "File Name: $file";
print "<li>";
printf ("rd1=%10.3f\n",$d1/$id,"\n");
print "<li>";
printf ("rd2=%10.3f\n",$d2/$id,"\n");
print "<li>";
printf ("rd3=%10.3f\n",$d3/$id,"\n");
print "<li>";
printf ("id=%10.3f\n",$id,"bits","\n");
open(L,"|rm /tmp/$file");
open(L,"|rm /tmp/output1");
open(L,"|rm /tmp/output2");
open(L,"|rm /tmp/output3");
exit;
print end_html;

