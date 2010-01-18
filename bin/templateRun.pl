#!/usr/bin/perl

# Tempalte is a file with only one line (usually bash script)
# Param is a file with several columns, every line of it will replace @@ in the 
# template file, and then the template line will be executed.

use strict;
use warnings;

my $len=@ARGV;
if ($len !=2)
{
    print "Syntax:";
    print "templateRun.pl <template file> <param file>\n";
    exit(1);
}

	
my $templateFn=$ARGV[0];
my $paramFn=$ARGV[1];

open(TEMPLATE, $templateFn) || die ("Cannont open $templateFn! \n");
my $template=<TEMPLATE>;

open(PARAM, $paramFn) || die("Cannont open $paramFn! \n");
my @param=<PARAM>;

foreach my $p (@param)
{
    #skip empty line
    if (length($p)==0)
    {
	next;
    }

    #split params
    my @params=split(/\s+/, $p);

    #replace @@ with each param
    my $command=$template;
    foreach my $p (@params)
    {
	if ($command =~ /@@/)
	{
	    $command =~ s/@@/$p/;
	}
    }

    print $command. "\n";
    system($command);
}


close(TEMPLATE);
close(PARAM);

#print "\n end\n";
