#! /usr/bin/perl -w
use strict;
use warnings;

if(@ARGV!=2)
{
	print "\nperl $0 <orthoMCLgroups> <output>\n";
	exit;
}

# VFGFO7145: SC|YBR183W AF|Afu3g01270 FOR|VFPFO_05090 MA|EFZ01925.1 BB|EJP61633.1 FOL|FOXG_05826T0 FV|FVEG_03705T0

open OUT,">$ARGV[1]";
open F,"$ARGV[0]" || die "Cannot open the file '$ARGV[1]'.\n";
while(<F>)
{
	chomp;
	my @sp=split(/\s+/,$_);
	my %gene;
	if($_ ne "")
	{
		for(my $i=1;$i<@sp;$i++)
		{
			my @gsp=split(/\|/,$sp[$i]);
			$gene{$gsp[0]}{$gsp[1]}=1;
		}
		my $out="$sp[0]";
		foreach my $s(sort keys %gene)
		{
			foreach my $name(sort keys %{$gene{$s}})
			{
				$out.=" $s\|$name";
			}
		}
		print OUT "$out\n";
	}
}
close F;
close OUT;
