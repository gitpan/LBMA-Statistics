#!perl -T
use strict;
use warnings;
use Test::More;
use LBMA::Statistics;

BEGIN {

    # Internet-Access required
    # Skip these tests in automated enviroments

    plan( skip_all => 'set NETWORK_TEST to enable these tests' )
      unless $ENV{NETWORK_TEST};
}

plan( tests => 17 );

my $lbma = LBMA::Statistics->new() or die;

my @fixings = $lbma->dailygoldfixing( year => 2009, month => 2, day => 2 );

ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '02-Feb-09', 'Date 02-Feb-09' );
ok( $fixings[1] == 913.75,  'Gold A.M. USD' );
ok( $fixings[2] == 642.581, 'Gold A.M. GBP' );
ok( $fixings[3] == 717.736, 'Gold A.M. EUR' );
ok( $fixings[4] == 918.25,  'Gold P.M. USD' );
ok( $fixings[5] == 649.123, 'Gold P.M. GBP' );
ok( $fixings[6] == 717.831, 'Gold P.M. EUR' );

# wantarray
my $fixings = $lbma->dailygoldfixing( year => 2000, month => 1, day => 4 );

ok( ref $fixings eq 'ARRAY', 'Returns an Arrayref' );

@fixings = @$fixings;
ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '04-Jan-00', 'Date 04-Jan-00' );
ok( $fixings[1] == 282.05,  'Gold A.M. USD' );
ok( $fixings[2] == 172.166, 'Gold A.M. GBP' );
ok( $fixings[3] == 275.305, 'Gold A.M. EUR' );
ok( $fixings[4] == 281.50,  'Gold P.M. USD' );
ok( $fixings[5] == 171.929, 'Gold P.M. GBP' );
ok( $fixings[6] == 272.402, 'Gold P.M. EUR' );

diag("LBMA::Statistics $LBMA::Statistics::VERSION. Test dailygoldfixing");
