#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'LBMA::Statistics::SilverFixing::Daily' );
}

diag( "Testing LBMA::Statistics::SilverFixing::Daily $LBMA::Statistics::SilverFixing::Daily::VERSION" );
