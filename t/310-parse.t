#!perl -T

use Test::More tests => 4;

use LBMA::Statistics::SilverFixing::Daily;

# The Basic Idea is to use a locally saved file to test the parsing stage
SKIP: {

	skip 'Test needs some investigation ', 4;

	my $lbma =  LBMA::Statistics::SilverFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 


	my @fixings;
	open(FH,"<", './t/html/LBMA-Silver-2007-Statistics.html') or die $!;
	local undef $/;
	my $content = <FH>;
	close(FH) or die $!;
	no warnings;
	@fixings = $lbma->_parse( $content ) ;


	ok($fixings[0] eq '01-Aug-07');
	ok($fixings[1] ==  1277.00 );
	ok($fixings[2] ==  630.617 );
	ok($fixings[3] ==  935.189 );

}

