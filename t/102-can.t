#!perl -T

use Test::More tests => 1;

use LBMA::Statistics::Date;
my $date = LBMA::Statistics::Date->new();
my @methods = qw(new  year day_pattern);

can_ok($date, @methods);



