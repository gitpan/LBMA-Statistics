#!/usr/bin/perl
use warnings;
use strict;

use lib '../lib';

use LBMA::Statistics;

use Log::Log4perl qw/:easy/;

Log::Log4perl->easy_init();
Log::Log4perl->easy_init( level => $DEBUG,
                          layout => '%d [%M] %F %L > %m%n',
                       );


my $lbma = LBMA::Statistics->new();

# @fixings
# 0 date
# 1 Silver USD
# 2 Silver GBP
# 3 Silver EUR

print join( "|", $lbma->dailysilverfixing() ), "\n";
print join( "|", $lbma->dailysilverfixing( year => 2009, month => 2, day => 2 ) ), "\n";
print join( "|", $lbma->dailysilverfixing( year => 2000, month => 1, day => 4 ) ), "\n";

# Should give no results
print join( "|", $lbma->dailysilverfixing( year => 4099, month => 1, day => 4 ) ), "\n";

