#!/usr/bin/perl
use warnings;
use strict;

use lib '../lib';

use LBMA::Statistics;

my $lbma =  LBMA::Statistics->new();


        # @fixings 
        # 0 date
        # 1 Silver USD 
        # 2 Silver GBP
        # 3 Silver EUR

print join("|",$lbma->dailysilverfixing() ) ,"\n";
print join("|",$lbma->dailysilverfixing( year => 2009, month => 2, day => 2) ) , "\n";
print join("|",$lbma->dailysilverfixing( year => 2000, month => 1, day => 4) ) , "\n";
