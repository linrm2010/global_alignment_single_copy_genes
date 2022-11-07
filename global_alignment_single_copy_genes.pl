#! /usr/bin/perl -w
use strict;
use warnings;

if(@ARGV!=4)
{
	print "\nperl $0 <24species_Orthogroups.single.txt> <sequences.list.txt> <type: 'cds' or 'pep'> <output>\n";
	exit;
}

# using the installed software 'muscle' for sequence alignment
my $muscle="muscle";

my %seq;
my @list;
open S,"$ARGV[1]" || die "Cannot open the file '$ARGV[1]'.\n";
while(<S>)
{
	chomp;
	if($_=~/\t$ARGV[2]/)
	{
		my @sp=split(/\t/,$_);
		push(@list,$sp[0]);
		open F,"$sp[1]" || die "Cannot open the file '$sp[1]'.\n"; # >SC|COB
		$/=">";
		<F>;
		$/="\n";
		while(<F>)
		{
			my $id=(split(/\s+/,$_))[0];
			$/=">";
			$seq{$sp[0]}{$id}=<F>;
			chomp $seq{$sp[0]}{$id};
			$seq{$sp[0]}{$id}=~s/\s+//g;
			$/="\n";
		}
		$/="\n";
		close F;
	}
}
close S;

my %align;
open C,"$ARGV[0]" || die "Cannot open the file '$ARGV[0]'.\n";
while(<C>)
{
	chomp;
	my @sp=split(/\s+/,$_);
	if($_ ne "" && !($_=~/^Species/))
	{
		open OS,">temp.txt";
		for(my $i=1;$i<@sp;$i++)
		{
			my @isp=split(/\|/,$sp[$i]); # AF|COX1
			print OS "\>$isp[0]\n$seq{$isp[0]}{$sp[$i]}\n";
		}
		close OS;
		system(" $muscle -in temp.txt -out temp.out ");
		open OF,"temp.out";
		$/=">";
		<OF>;
		$/="\n";
		while(<OF>)
		{
			chomp;
			my $id=(split(/\s+/,$_))[0]; # only species id
			$/=">";
			my $tempseq=<OF>;
			chomp $tempseq;
			$tempseq=~s/\s+//g;
			$align{$id}.=$tempseq;
			$/="\n";
		}
		$/="\n";
		close OF;
		system(" rm temp.txt temp.out ");
	}
}
close C;

open OUT,">$ARGV[3]";
for(my $i=0;$i<@list;$i++)
{
	print OUT "\>$list[$i]\n$align{$list[$i]}\n" if(defined $align{$list[$i]});
}
close OUT;
