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

plan( tests => 11 );

my $lbma = LBMA::Statistics->new() or die;

my @fixings = $lbma->dailysilverfixing( year => 2009, month => 2, day => 2 );

ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '02-Feb-09', 'Date 02-Feb-09' );
ok( $fixings[1] == 1243.00, 'Silver USD' );
ok( $fixings[2] == 880.312, 'Silver GBP' );
ok( $fixings[3] == 971.853, 'Silver EUR' );

# wantarray
my $fixings = $lbma->dailysilverfixing( year => 2000, month => 1, day => 4 );

ok( ref $fixings eq 'ARRAY', 'Returns an Arrayref' );

@fixings = @$fixings;

ok( scalar @fixings > 0, 'Array Contains Data' );

ok( $fixings[0] eq '04-Jan-00', 'Date 04-Jan-00' );
ok( $fixings[1] == 530.250, 'Silver USD' );
ok( $fixings[2] == 323.225, 'Silver GBP' );
ok( $fixings[3] == 513.808, 'Silver EUR' );

diag("LBMA::Statistics $LBMA::Statistics::VERSION. Test dailysilverfixing");
