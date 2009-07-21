#!perl -T

use Test::More tests => 1;
use LBMA::Statistics::SilverFixing::Daily;
my $lbma =  LBMA::Statistics::SilverFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 
my @methods = qw(new year day_pattern retrieve_row _parse _init);
can_ok($lbma, @methods);
diag( "Testing can LBMA::Statistics::SilverFixing::Daily $LBMA::Statistics::SilverFixing::Daily::VERSION");

