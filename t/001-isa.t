#!perl -T

use Test::More tests => 1;

use LBMA::Statistics;
my $lbma = LBMA::Statistics->new();
isa_ok($lbma, 'LBMA::Statistics');

diag( "Testing isa LBMA::Statistics $LBMA::Statistics::VERSION" );

