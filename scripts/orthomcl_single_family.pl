#! /usr/bin/perl -w
use strict;
use warnings;

if(@ARGV!=3)
{
	print "\nperl $0 <orthoMCLgroups.rename> <species number> <output>\n";
	exit;
}

open OUT,">$ARGV[2]";
open G,"$ARGV[0]" || die "Cannot open the file '$ARGV[0]'.\n";
while(<G>)
{
	chomp;
	my $tag=0;
	my %usetag;
	my @sp=split(/\s+/,$_);
	if($_ ne "")
	{
		if(@sp==($ARGV[1]+1))
		{
			for(my $i=1;$i<@sp;$i++)
			{
				my @gsp=split(/\|/,$sp[$i]);
				if(!(defined $usetag{$gsp[0]}))
				{
					$usetag{$gsp[0]}=$sp[$i];
					$tag++;
				}
				else
				{
					last;
				}
			}
			my $out=$sp[0];
			foreach my $id(sort keys %usetag)
			{
				$out.=" $usetag{$id}";
			}
			print OUT "$out\n" if($tag==$ARGV[1]);
		}
	}
}
close G;
close OUT;

