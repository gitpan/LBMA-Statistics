#!perl -T
use Test::More;
use LBMA::Statistics::GoldFixing::Daily;

BEGIN {

        # Internet-Access required
        # Skip these tests in automated enviroments

        plan( skip_all => 'set NETWORK_TEST to enable these tests' )
               unless $ENV{NETWORK_TEST};
}
plan( tests => 22 );


my $lbma;

#04-Feb-00  287.50  181.068 290.727 293.65  184.767 299.551
my $year = 2000;
my $day_pattern = '04-Feb-00';


$lbma = LBMA::Statistics::GoldFixing::Daily->new( 
            year => $year,
            day_pattern => $day_pattern
) or die $!;

my @fixings = $lbma->retrieve_row();

ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  287.50, 'Gold A.M. USD' );
ok($fixings[2] ==  181.068, 'Gold A.M. GBP' );
ok($fixings[3] ==  290.727, 'Gold A.M. EUR');
ok($fixings[4] ==  293.65 ,'Gold P.M. USD' );
ok($fixings[5] ==  184.767, 'Gold P.M. GPB' );
ok($fixings[6] ==  299.551, 'Gold P.M. EUR' );

my $fixings = $lbma->retrieve_row();

@fixings = @$fixings;
ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  287.50, 'Gold A.M. USD' );
ok($fixings[2] ==  181.068, 'Gold A.M. GBP' );
ok($fixings[3] ==  290.727, 'Gold A.M. EUR');
ok($fixings[4] ==  293.65 ,'Gold P.M. USD' );
ok($fixings[5] ==  184.767, 'Gold P.M. GPB' );
ok($fixings[6] ==  299.551, 'Gold P.M. EUR' );

@fixings = $lbma->retrieve_row_am();
ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  287.50, 'Gold A.M. USD' );
ok($fixings[2] ==  181.068, 'Gold A.M. GBP' );
ok($fixings[3] ==  290.727, 'Gold A.M. EUR');
$fixings = $lbma->retrieve_row_am();

@fixings = @$fixings;
ok($fixings[0] eq '04-Feb-00');
ok($fixings[1] ==  287.50, 'Gold A.M. USD' );
ok($fixings[2] ==  181.068, 'Gold A.M. GBP' );
ok($fixings[3] ==  290.727, 'Gold A.M. EUR');

