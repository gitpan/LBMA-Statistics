#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'LBMA::Statistics' );
}

diag( "Testing LBMA::Statistics $LBMA::Statistics::VERSION, Perl $], $^X" );
