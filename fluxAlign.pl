#!/usr/bin/perl -s
use strict;
use warnings;

#Perl script for determining the accuracy of alignment of flux RNA-Seq reads
my $filename = shift ;
if (-e $filename) {}
else {print "\n File $filename not found, please check file exists\n"; exit;}

#Usage
if (($help == 1) or ($h == 1))
	{
	print "\nFluxAligned\n\nUsage: \"./fluxAligned.pl <arguments> <inputfile>\" \n\nOptions: -accuracy=<integer> -help / -h (This helpful message)\n\n";
	print "accuracy allows user to set the base pairs within which the read must align (default 100)\n";
	print "Input file must be a sam file, read names must be flux simulator reads.\n\n";
 	exit;
	}
print "\nFlux Simulator Alignment Accuracy Finder\n\nUsage: \"./fluxAligned.pl <arguments> <inputfile>\" -h or -help for help/arguments\n\n";

