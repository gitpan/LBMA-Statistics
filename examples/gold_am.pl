#!/usr/bin/perl
use warnings;
use strict;

use lib '../lib';

use LBMA::Statistics;

use Log::Log4perl qw/:easy/;

Log::Log4perl->easy_init();

my $lbma = LBMA::Statistics->new();

# @fixings
# 0 date
# 1 GOLD A.M. USD
# 2 GOLD A.M. GBP
# 3 GOLD A.M. EUR
print join( "|", $lbma->dailygoldfixing_am() ), "\n";
print join( "|", $lbma->dailygoldfixing_am( year => 2009, month => 2, day => 2 ) ), "\n";
print join( "|", $lbma->dailygoldfixing_am( year => 2000, month => 1, day => 4 ) ), "\n";
