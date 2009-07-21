#!perl -T

use Test::More tests => 1;

use LBMA::Statistics::GoldFixing::Daily;
my $lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 
isa_ok($lbma, LBMA::Statistics::GoldFixing::Daily);

diag( "Testing isa LBMA::Statistics::GoldFixing::Daily $LBMA::Statistics::GoldFixing::Daily::VERSION" );


