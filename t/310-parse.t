#!perl -T
use strict;

use Test::More tests => 7;

use LBMA::Statistics::SilverFixing::Daily;

# The Basic Idea is to use a locally saved file to test the parsing stage

my $lbma = LBMA::Statistics::SilverFixing::Daily->new(
    year        => 2009,
    day_pattern => '03-Aug-09'
);

my @fixings = get_fixings( $lbma, './t/html/LBMA-Silver-2009-Statistics.html');

ok( $fixings[0] eq '03-Aug-09' );
ok( $fixings[1] == 1429.00 );
ok( $fixings[2] == 848.827 );
ok( $fixings[3] == 1000.000 );

$lbma = LBMA::Statistics::SilverFixing::Daily->new(
    year        => 1968,
    day_pattern => '08-May-68'
);
@fixings = get_fixings( $lbma, './t/html/LBMA-Silver-1968-Statistics.html');

ok( $fixings[0] eq '08-May-68' );
ok( $fixings[1] == 232.100 );
ok( $fixings[2] == 96.875 );


sub get_fixings {
    my $lbma = shift @_;
    my $file = shift;

    open( FH, "<", $file ) or die $!;
    local undef $/;
    my $content = <FH>;
    close(FH) or die $!;

    my @fixings;

    eval {
        no warnings;
        @fixings = $lbma->_parse($content);
    };
    return @fixings;
}

