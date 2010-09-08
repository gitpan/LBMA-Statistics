#!perl -T
use strict;

use Test::More tests => 12 ;

use LBMA::Statistics::GoldFixing::Daily;

# The Basic Idea is to use a locally saved file to test the parsing stage


my $lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 2009, day_pattern => '03-Aug-09'); 
my @fixings = get_fixings($lbma,'./t/html/LBMA-Gold-2009-Statistics.html');

ok($fixings[0] eq '03-Aug-09');
ok($fixings[1] ==  954.25 );
ok($fixings[2] ==  565.985 );
ok($fixings[3] ==  667.635 );
ok($fixings[4] ==  959.75 );
ok($fixings[5] ==  568.034 );
ok($fixings[6] ==  667.049 );

$lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 1968, day_pattern => '05-Jul-68'); 
@fixings = get_fixings($lbma,'./t/html/LBMA-Gold-1968-Statistics.html');

ok($fixings[0] eq '05-Jul-68');
ok($fixings[1] ==  41.100 );
ok($fixings[2] ==  17.250 );
ok($fixings[3] ==  41.000 );
ok($fixings[4] ==  17.2083 );


sub get_fixings {
    my $lbma = shift @_;
    my $file = shift;

    open(FH,"<", $file) or die $!;
    local undef $/;
    my $content = <FH>;
    close(FH) or die $!;

    my @fixings;

    eval {
        no warnings;
        @fixings = $lbma->_parse( $content ) ;
    };
    return @fixings;
}

