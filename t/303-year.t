#!perl -T

use Test::More tests => 1;
use LBMA::Statistics::SilverFixing::Daily;
my $lbma =  LBMA::Statistics::SilverFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 

ok($lbma->year() eq 2007);

