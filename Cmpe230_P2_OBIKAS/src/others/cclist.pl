#!/usr/bin/perl -w

our@cclist;
$cc="cc.txt";
open(CC,$cc) or die("Cannot open $cc.\n");

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
                        
			($name,$code)=split(/ /,$lectures[0]); #i.e. $name=cmpe $code=230 
			while(<CC>){
				next if($_ =~/^#/);
				if($_=~/%/)
				{
					if($_=~/$department/)#m vardi burada
					{
						do{
							$_=<CC>;
							next if($_=~/^#/);
							@tmp=split(/ +,/,$_);
							$tmpname=shift(@tmp); #tmpname eq sth like CMPE
							if($name eq $tmpname)
							{
								$exfound=0;
								foreach $i(@tmp)
								{
									if($i=~/except/){
										$exfound=1;
										last;
									}
									$ismatched=matchpatt($i,$code);
									if($ismatched)
									{
										push(@cccourses,[$lectures[0],$lectures[1]]);
										$matched=1;
									}
								}
								if($exfound)
								{
									foreach $i(@tmp)
									{
										next if($i ne "except");
										$ismatched=matchpatt($i,$code);
										if($ismatched)
										{
											pop(@cccourses);
											$matched=0;
										}
									}
								}
							}
							else
							{
								next;
							}
						}unless($_=~/%/ || $_==EOF); #???
					}
					else
					{
						next;
					}
				}
				else
				{
					next;
				}
			}
		seek(CC, 0, 0);#rewinding the file handle to use it again 
		}#cc match is over                    