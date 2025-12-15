#! /usr/bin/perl -w
use strict;
use warnings;

if(@ARGV!=3)
{
	print "\nperl $0 <seq.fa> <prefix, such as 'TafA'> <output>\n";
	exit;
}

open OUT,">$ARGV[2]";
open F,"$ARGV[0]" || die "Cannot open the file '$ARGV[0]'.\n";
while(<F>)
{
	chomp;
	if($_=~/^>/)
	{
		my $infor=(split(/\s+/,$_))[0];
		$infor=~s/>//;
		$infor=">$ARGV[1]\|".$infor;
		print OUT "$infor\n";
	}
	elsif($_ ne "")
	{
		print OUT "$_\n";
	}
}
close F;


__END__
