#!/usr/bin/perl
use warnings;
use strict;

use Dumpvalue;

use lib '../lib';

use LBMA::Statistics;

my $lbma =  LBMA::Statistics->new();

my $dumper = new Dumpvalue;

	# @fixings 
	# 0 date
	# 1 Silver USD 
	# 2 Silver GBP
	# 3 Silver EUR
	
my $fixings ; # ArrayRef

$fixings = $lbma->dailysilverfixing();
$dumper->dumpValue($fixings);
print "\n";

$fixings = $lbma->dailysilverfixing( year => 2009, month => 2, day => 2);
$dumper->dumpValue($fixings);
print "\n";

$fixings = $lbma->dailysilverfixing( year => 2000, month => 1, day => 4);
$dumper->dumpValue($fixings);
print "\n";


