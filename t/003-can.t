#!perl -T

use Test::More tests => 1;

use LBMA::Statistics;
my $lbma = LBMA::Statistics->new();
my @methods = qw/new dailygoldfixing dailysilverfixing /;
can_ok($lbma, @methods);

