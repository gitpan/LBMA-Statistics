#!perl -T

use Test::More tests => 1;

use LBMA::Statistics::Date;
my $date = LBMA::Statistics::Date->new();
isa_ok($date, LBMA::Statistics::Date);
diag( "Testing isa LBMA::Statistics::Date $LBMA::Statistics::Date::VERSION" );

