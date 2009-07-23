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
	# 1 GOLD A.M. USD 
	# 2 GOLD A.M. GBP
	# 3 GOLD A.M. EUR
	# 4 GOLD P.M. USD
	# 5 GOLD P.M. GBP
	# 6 GOLD P.M. EUR 
	
my $fixings ; # ArrayRef

$fixings = $lbma->dailygoldfixing();
$dumper->dumpValue($fixings);
print "\n";

$fixings = $lbma->dailygoldfixing( year => 2009, month => 2, day => 2);
$dumper->dumpValue($fixings);
print "\n";

$fixings = $lbma->dailygoldfixing( year => 2000, month => 1, day => 4);
$dumper->dumpValue($fixings);
print "\n";


