#!/usr/bin/perl

use HTML::TokeParser;

@filelist=getfiles();

$stu=$filelist[0];
$req=$filelist[1];
$cc=$filelist[2];
$hss=$filelist[3];

our @requiredcourses;
our @hsscourses;
our @cccourses;
our @othercourses;
our @reqlist;
our @hsslist;
our @cclist;
#open required files to read
open(REQ,$req) or die("Cannot open $req.\n");
open(HSS,$hss) or die("Cannot open $hss.\n");
open(CC,$cc) or die("Cannot open $cc.\n");

#taking the elements of the required courses
while(<REQ>)
{
	last if($_=~/COURSE_CODE/);
}
while (<REQ>)
{
	chomp($_);
	next if($_=~/#|CC|HSS|%|^\s/);
	@temparr=split(/\t/,$_,4); #CMPE	256	nothing	4
	$tempval=$temparr[0] ." ". $temparr[1]; #CMPE 256
	push(@reqlist,$tempval);
}
#finished taking the elements of the required courses. Close the file
close(REQ);
#taking HSS list
while(<HSS>)
{
	chomp($_);
	next if($_=~/%|^\s/);
	@temparr=split(/ /); #PHIL 101 Introduction to Philosophy I (Felsefeye Giris I)
	$tempval=$temparr[0]." ".$temparr[1]; #PHIL 101
	push(@hsslist,$tempval);
}
#finished taking HSS list, Close the file
close(HSS);
#taking cc list
while(<CC>)
{
    $exfound=0;
    if($_=~/^\w/)
    {
        @tmplist=split(/ /,$_);
        $code=shift(@tmplist); #CMPE EE etc.
        foreach $i(@tmplist)
        {
            if($i=~/-/)
            {
                ($min,$max)=split(/-/,$i);
                for ($j=$min;$j<$max;$j++)
                {
                    $lec=$code." ".$j;
                    push(@cclist,$lec);
                }
            }
            elsif($i eq "except")
            {
                $exfound=1;
                last;
            }
        }
        if($exfound)
        {
            foreach $i(@tmplist)
            {
                next unless($i eq "except");
                $lec=$code." ".$i;
                for ($k=0;$k<@cclist;$k++)
                {
                    if($lec eq $cclist[$k])
                    {
                        $cclist[$k]=undef;
                        last;
                    }
                }
            }
        }
    } #endof if
    else{
        next;
    }
}#end of while
#end of taking cc list 
#now, reading from html file
$page=new HTML::TokeParser($stu) or die("Cannot open $stu");
#finding the place of the department info
#do{
#	$token=$page->get_token();
#	$text=$token->[1];
#}until($text=~/Department/);
#taking the department info
#$token=$page->get_token();
#$token=$page->get_token();
#$token=$page->get_token();
#$token=$page->get_token();
#$department=$token->[1];
#$department=~tr/\t+(&nbsp;)//d;
#print "$department\n";
#took the department info, now finding the place of lectures
do{
	$token=$page->get_token();
	$text=$token->[1];
}until($text=~/Overall/);
while(1)
{
	do{
		$token=$page->get_token();
		$type=$token->[0];	
		$tag=$token->[1];
		$attribute=$token->[2];
	}until(($type eq "S" && $tag eq "table" && $attribute->{id} eq "Table3") || ($type eq "E" && $tag eq "html")); #table started
	
	last if($type eq "E" && $tag eq "html");
	
	@lectures=getlectures(); #we took the list of the lectures (lecture codes, names etc.)
	#print "@lectures\n";
	#Now, checking lists to determine the place of the lecture
	$repeat=0;
	foreach $i(@repeatlist)
	{
		$tmp=$lectures[0];
		$tmp=~tr/ //d;
		$tmp2=$i;
		$tmp2=~tr/ //d;
		if($tmp=~/$tmp2/)
		{
			$repeat=1;
			last;
		}
	}
	unless($lectures[2]=~/F/ or $repeat==1 or $lectures[2]=~/W/)
	{
		if($lectures[4] eq "R")
		{
			push(@repeatlist,$lectures[5]);
		}
		#if student is taken the lecture and haven't taken the grade yet
		elsif($lectures[3] eq "R")
		{
			push(@repeatlist,$lectures[4]);
		}
		$matched=0;
		$tmp=$lectures[0];
		$tmp=~tr/ //d;
		chop($tmp);chop($tmp);chop($tmp);
		foreach (@reqlist)
		{
			$_=~tr/ //d;
			if($_=~/$tmp/){
				push (@requiredcourses,[($lectures[0],$lectures[1])]);
				$matched=1;
				last;
			}
			
		}
		if ($matched==0)
		{
			foreach (@hsslist)
			{
				$_=~tr/ //d;
				$tmp=$lectures[0];
				$tmp=~tr/ //d;
				if($tmp =~/$_/){
					push (@hsscourses,[($lectures[0],$lectures[1])]);
					$matched=1;
					last;
				}
			}
		}
		#now, cc match becomes...
		if($matched==0)
		{
			foreach (@cclist)
			{
				$_=~tr/ //d;
				$tmp=$lectures[0];
				$tmp=~tr/ //d;
				if($tmp =~/$_/)
				{
					push (@cccourses,[($lectures[0],$lectures[1])]);
					$matched=1;
					last;
				}
			}
		}
		#if the lecture is not matched up to here i.ie $matched=0, it will be in the others list
		push (@othercourses,[($lectures[0],$lectures[1])]) if ($matched==0);
	}
}

sub getlectures
{
	my @lectures;
	do{
		$token=$page->get_token();
		$type=$token->[0];
		$tag=$token->[1];
		$tmptext=$tag;
		$tmptext=~tr/\t\n\r\f//d;
		$tmptext=~s/&nbsp;//;
		$tmptext=~s/^ +//;
		chomp($tmptext);
		($text,@tmp)=split(/\r/,$tmptext);
		if(($type eq "T") and ($text=~/^\w+/)){
			push(@lectures,$text);
		}
	}until($tag eq "table" && $type eq "E");
	return(@lectures);
}

print "\n\n\nREQUIRED COURSES\n\n";
foreach (@requiredcourses)
{
	print "@$_\n";
}
print "\n\n\nHSS COURSES\n\n";
foreach (@hsscourses)
{
	print "@$_\n";
}
print "\n\n\nCOMPLIMENTARY COURSES\n\n";
foreach (@cccourses)
{
	print "@$_\n";
}
print "\n\n\nOTHER COURSES\n\n";
foreach (@othercourses)
{
	print "@$_\n";
}

sub getfiles
{
	my @filelist=qw/student.html required.txt cc.txt hss.txt/;
	if(defined($ARGV[0]))
	{
		if($ARGV[0] eq "-t"){
			$filelist[0]=$ARGV[1];}
		elsif($ARGV[0] eq "-r"){
			$filelist[1]=$ARGV[1];}
		elsif($ARGV[0] eq "-c"){
			$filelist[2]=$ARGV[1];}
		elsif($ARGV[0] eq "-h"){
			$filelist[3]=$ARGV[1];}
		elsif($ARGV[0] eq "--h" or $ARGV[0] eq "--help")
		{
			die("\n--h or --help: Prints this message\n-t:Transcript file\n",
			"-r:Required_courses_file\n-c:cc_file\n-h:hss_file\n",
			"\nDefault values:\n\nTranscript File:student.html\n",
			"Required_courses_file:required.txt\ncc_file:cc.txt\n",
			"hss_file:hss.txt\n\n");
		}
		else{
			die("Invalid input. For help type $0 --help");}
		if(defined($ARGV[2]))
		{
			if($ARGV[2] eq "-t"){
				$filelist[0]=$ARGV[3];}
			elsif($ARGV[2] eq "-r"){
				$filelist[1]=$ARGV[3];}
			elsif($ARGV[2] eq "-c"){
				$filelist[2]=$ARGV[3];}
			elsif($ARGV[2] eq "-h"){
				$filelist[3]=$ARGV[3];}
			else{
				die("Invalid input. For help type $0 --help");}
			if(defined($ARGV[4]))
			{
				if($ARGV[4] eq "-t"){
					$filelist[0]=$ARGV[5];}
				elsif($ARGV[4] eq "-r"){
					$filelist[1]=$ARGV[5];}
				elsif($ARGV[4] eq "-c"){
					$filelist[2]=$ARGV[5];}
				elsif($ARGV[4] eq "-h"){
					$filelist[3]=$ARGV[5];}
				else{
					die("Invalid input. For help type $0 --help");}
				if(defined($ARGV[6]))
				{
					if($ARGV[6] eq "-t"){
						$filelist[0]=$ARGV[7];}
					elsif($ARGV[6] eq "-r"){
						$filelist[1]=$ARGV[7];}
					elsif($ARGV[6] eq "-c"){
						$filelist[2]=$ARGV[7];}
					elsif($ARGV[6] eq "-h"){
						$filelist[3]=$ARGV[7];}
					else{
						die("Invalid input. For help type $0 --help");}
				}
			}
		}
	}
	return (@filelist);
}
