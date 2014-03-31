#!perl -T
use Test::More;
use LBMA::Statistics::SilverFixing::Daily;

BEGIN {

        # Internet-Access required
        # Skip these tests in automated enviroments

        plan( skip_all => 'set NETWORK_TEST to enable these tests' )
               unless $ENV{NETWORK_TEST};
}
plan( tests => 11 );


my $lbma;

# 04-Feb-00 523.000 329.345 530.695
my $year = 2000;
my $day_pattern = '04-Feb-00';


$lbma = LBMA::Statistics::SilverFixing::Daily->new( 
            year => $year,
            day_pattern => $day_pattern
) or die $!;


my @fixings = $lbma->retrieve_row();

ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  5.23000, 'Silver USD' );
ok($fixings[2] ==  3.29345, 'Silver GBP' );
ok($fixings[3] ==  5.30695, 'Silver EUR');

my $fixings = $lbma->retrieve_row();

@fixings = @$fixings;
ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  5.23000, 'Silver USD' );
ok($fixings[2] ==  3.29345, 'Silver GBP' );
ok($fixings[3] ==  5.30695, 'Silver EUR');

#05-Feb-68      82.917
$year = 1968;
$day_pattern = '05-Feb-68';
$lbma = LBMA::Statistics::SilverFixing::Daily->new( 
            year => $year,
            day_pattern => $day_pattern
) or die $!;
@fixings = $lbma->retrieve_row();
ok($fixings[0] eq '05-Feb-68');
ok($fixings[1] ==  2.00000, 'Silver USD' );
ok($fixings[2] ==  0.82917, 'Silver GBP' );

