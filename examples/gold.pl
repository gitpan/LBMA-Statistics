#!/usr/bin/perl
use warnings;
use strict;

use lib '../lib';

use LBMA::Statistics;

my $lbma =  LBMA::Statistics->new();

	# @fixings 
	# 0 date
	# 1 GOLD A.M. USD 
	# 2 GOLD A.M. GBP
	# 3 GOLD A.M. EUR
	# 4 GOLD P.M. USD
	# 5 GOLD P.M. GBP
	# 6 GOLD P.M. EUR 
print join("|",$lbma->dailygoldfixing() ) ,"\n";
print join("|",$lbma->dailygoldfixing( year => 2009, month => 2, day => 2) ) , "\n";
print join("|",$lbma->dailygoldfixing( year => 2000, month => 1, day => 4) ) , "\n";
