#!perl -T

use Test::More tests => 3;

use LBMA::Statistics::Date;


###############################################################################
# 1
###############################################################################

my $year = 1968;
my $month = 8;
my $day = 21;

my $date = LBMA::Statistics::Date->new( year => $year,
                                        month => $month,
                                        day => $day,
                                ) or die $!;

ok($date->year() == 1968, 'Year 1968');

###############################################################################
# 2
###############################################################################
undef $date;

SKIP: {
  eval { use Test::Exception };
  skip 'Test::Exception not installed', 1 if $@;

        # Invalid date
	$year  = 2001;
	$month = 2;
	$day   = 29;
  dies_ok { $date = LBMA::Statistics::Date->new( year => $year,
                                               month => $month,
                                               day => $day,
                                              ) }
                                              'expecting to die on invalid dates' ;
}

###############################################################################
# 3 Today
###############################################################################
undef $date;
$date = LBMA::Statistics::Date->new(); 
#$year = (localtime())[5];
$year = (gmtime())[5];
$year += 1900;
ok($date->year() == $year, 'Testing Today');

