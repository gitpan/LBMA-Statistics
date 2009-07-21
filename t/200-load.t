#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'LBMA::Statistics::GoldFixing::Daily' );
}

diag( "Testing LBMA::Statistics::GoldFixing::Daily $LBMA::Statistics::GoldFixing::Daily::VERSION" );
