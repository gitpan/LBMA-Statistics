#!perl -T

use Test::More tests => 1;
use LBMA::Statistics::GoldFixing::Daily;
my $lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 

ok($lbma->day_pattern() eq '01-Aug-07' );

