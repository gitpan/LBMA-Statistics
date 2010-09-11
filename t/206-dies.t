#!perl -T

use Test::More tests => 3;
use LBMA::Statistics::GoldFixing::Daily;
my $lbma;
SKIP: {
    eval {  use Test::Exception };
    skip 'Test::Exception not installed', 3 if $@;

    dies_ok { $lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 2007, ) } 'missing day_pattern'; 
    dies_ok { $lbma =  LBMA::Statistics::GoldFixing::Daily->new( day_pattern => '01-Aug-07') } 'missing year'; 
    dies_ok { $lbma =  LBMA::Statistics::GoldFixing::Daily->new( )} 'missing day and missing day_pattern'; 
}

