#!perl -T

use Test::More tests => 7 ;

use LBMA::Statistics::GoldFixing::Daily;

# The Basic Idea is to use a locally saved file to test the parsing stage


	my $lbma =  LBMA::Statistics::GoldFixing::Daily->new( year => 2007, day_pattern => '01-Aug-07'); 


	my @fixings;
	open(FH,"<", './t/html/LBMA-Gold-2007-Statistics.html') or die $!;
	local undef $/;
	my $content = <FH>;
	close(FH) or die $!;
	no warnings;
	@fixings = $lbma->_parse( $content ) ;

	ok($fixings[0] eq '01-Aug-07');
	ok($fixings[1] ==  660.25 );
	ok($fixings[2] ==  326.549 );
	ok($fixings[3] ==  483.771 );
	ok($fixings[4] ==  665.75 );
	ok($fixings[5] ==  327.568 );
	ok($fixings[6] ==  486.055 );


