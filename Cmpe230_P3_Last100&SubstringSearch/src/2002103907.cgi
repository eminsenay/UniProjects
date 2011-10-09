#!/usr/bin/perl -w

#Student ID:2002103907
#Name: Emin Şenay
#Project 3: Visitor Logger

#loading CGI and Flock libraries
use CGI qw(:standard);
use Fcntl qw(:flock);

$pname=param("name");	#taking the parameter

#beginning of the html page, charset modifications are to cope with Turkish characters
print header(-charset=>'UTF-8'),start_html(-title=>'Last 100 Names',-encoding=> 'UTF-8',-lang=>'trk:TRK');

#opening and locking the file
open (FH,"+>>/tmp/last100.txt") or die("Cannot open file: $!");
flock (FH,LOCK_EX) or die("Could not get exclusive lock: $!");
seek(FH,0,0);

#reading all adresses from the file
while(<FH>)
{
	@addresses=split(/,/,$_); #name,ip,name,ip,...
}

#unlocking and closing the file
flock(FH,LOCK_UN) or die("Could not unlock file: $!");
close(FH) or die("Cannot close file: $!");
#adding new name and IP address if it is given
if (defined($pname))
{
	unshift(@addresses,$ENV{"REMOTE_ADDR"});
	unshift(@addresses,$pname);
}

#printing results in a table
print '<table border="0">',Tr(td("Name"),td("IP_Address"));
for($i=0;$i<200;$i++)
{
	last if(!defined($addresses[$i]));
	print Tr(td($addresses[$i]),td($addresses[++$i]));
}

#writing to the file if new name is given. If it is not given, it is no need to write it again
if (defined($pname))
{
	open (FH,">/tmp/last100.txt") or die("Cannot open file: $!");
	#locking the file
	flock (FH,LOCK_EX) or die("Could not get exclusive lock: $!");
	for($i=0; $i<200; $i++)
	{
		last if(!defined($addresses[$i]));
		print(FH "$addresses[$i]");
		print(FH ",");
	}
	#unlocking and closing the file
	flock (FH,LOCK_UN) or die("Could not unlock file:$!");
	close (FH);
}
#end of the table and html page
print '</table>',end_html();
