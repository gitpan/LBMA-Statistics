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

plan( tests => 16 );

my $lbma = LBMA::Statistics->new() or die;

my @fixings = $lbma->dailysilverfixing( year => 2009, month => 2, day => 2 );

ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '02-Feb-09', 'Date 02-Feb-09' );
ok( $fixings[1] == 12.4300, 'Silver USD' );
ok( $fixings[2] == 8.80312, 'Silver GBP' );
ok( $fixings[3] == 9.71853, 'Silver EUR' );

# wantarray
my $fixings = $lbma->dailysilverfixing( year => 2000, month => 1, day => 4 );

ok( ref $fixings eq 'ARRAY', 'Returns an Arrayref' );

@fixings = @$fixings;

ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '04-Jan-00', 'Date 04-Jan-00' );
ok( $fixings[1] == 5.30250, 'Silver USD' );
ok( $fixings[2] == 3.23225, 'Silver GBP' );
ok( $fixings[3] == 5.13808, 'Silver EUR' );

@fixings = $lbma->dailysilverfixing( year => 1968, month => 1, day => 31 );
ok( scalar @fixings > 0, 'Array Contains Data' );
ok( $fixings[0] eq '31-Jan-68', 'Date 31-Jan-68' );
ok( $fixings[1] == 1.96000, 'Silver USD' );
ok( $fixings[2] == 0.81250,  'Silver GBP' );
isnt( $fixings[3], defined,     'Ok undefined' );

diag("LBMA::Statistics $LBMA::Statistics::VERSION. Test dailysilverfixing");
