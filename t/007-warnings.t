#!perl -T
use warnings;
use strict;

use Test::More;
use LBMA::Statistics;

BEGIN {
    eval ' use Test::Warn ';
    plan( skip_all => "Install Test::Warn to enable these tests" ) if $@;

    # Internet-Access required
    # Skip these tests in automated enviroments
    plan( skip_all => 'set NETWORK_TEST to enable these tests' )
       unless $ENV{NETWORK_TEST};
}

plan( tests => 3 );

my $lbma = LBMA::Statistics->new();

# This is a Sunday, that is there are no fixings

my $year  = 2010;
my $month = 9;
my $day   = 5;

warning_like { $lbma->dailygoldfixing( year => $year, month => $month, day => $day )    } qr/No Goldfixing Results/, 'warning dailygoldfixing';
warning_like { $lbma->dailysilverfixing( year => $year, month => $month, day => $day )  } qr/No Silverfixing Results/, 'warning dailysilverfixing';
warning_like { $lbma->dailygoldfixing_am( year => $year, month => $month, day => $day ) } qr/No Goldfixing AM Results/, 'warning dailygoldfixing_am';

