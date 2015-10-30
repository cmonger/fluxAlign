#!/usr/bin/perl -s
#use warnings;

#Perl script for determining the accuracy of alignment of flux RNA-Seq reads
my $filename = shift || 'test.sam';
if (-e $filename) {}
else {print "\n File $filename not found, please check file exists\n"; exit;}

#Usage
if (($help == 1) or ($h == 1))
	{
	print "\nFluxAligned - Aligner true accuracy finder\n\nUsage: \"./fluxAligned.pl <arguments> <inputfile>\" \n\nRequired:\n <inputfile>\tSAM file of Flux aligned reads\n -totalReads=<integer>\tAmount of total simulated reads, prealignment\n\nOptions:\n -accuracy=<integer>\taligned within this nucelotide threshold (default 100)\n -help/-h\t(This helpful message)\n\n";
	print "Input file must be a sam file, read names must be flux simulator reads.\n\n";
 	exit;
	}
print "\nFlux Simulator Alignment Accuracy Finder\n\nUsage: \"./fluxAligned.pl <arguments> <inputfile>\" -h or -help for help/arguments\n\n";

#Begin loading the SAM file
if ($totalReads eq "") {print "\nWARNING: Read total undefined, please use -totalReads or use -h for help.\n\n" and die;}
print "Loading SAM\n";
open FPIN, "<$filename" or die;
my @SAM = <FPIN> ;
close FPIN;
print "SAM loaded, calculating alignment specificity\n";



#Defining some variables for later
my $uniqueReads=0 ;
my $uniqueAlignedReads=0 ;
my $readsRead=0;
my $readsOnCorrectChromosome=0;

#Parsing SAM and calculating correct align %
foreach (@SAM)
	{
	$readsRead++;
	#Read the SAM line for name, read origin and alignment chromosome & location
	if (/^(\w+):(\d+)-(\d+)\S+\s+(\S+)\s+(\S+)/)
		{
#		print $1."\t".$2."\t".$3."\t".$4."\t".$5."\n";
		my $originchromosome = $1 ;
		my $originstart = $2 ;
		my $originend = $3 ;
		my $alignedchromosome = $5 ;
		my $alignedposition = $4 ;
		
#		print "start\t$2\tend\t$3\t$4 \n";
		
		chomp $alignedchromosome;
		chomp $originchromosmome;
		
#		print "$alignedchromosome\t$originchromosome\n";
	
		#Check correct chromosome alignment	
		if ($alignedchromosome eq $originchromosome)
			{
			$readsOnCorrectChromosome++;
#			print "Chromosome names match";
			#Check correct alignment position
			if ($alignedposition > $originstart and $alignedposition < $originend)
				{
#				print "Read correctly aligned";
				$uniqueAlignedReads++;	
				}
			}				


		}
	}

print "Reads Aligned to Correct Chromosome = $readsOnCorrectChromosome\n";
print "Total Reads correctly Aligned = $uniqueAlignedReads\n";
print "Unique alignment percentage\t".((100/$totalReads)*$uniqueAlignedReads)."%\n";
if ($uniqueAlignedReads > $totalReads) {print "WARNING:\tRead number exceeds specified total\n"};

