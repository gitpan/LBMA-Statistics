#!perl -T

use Test::More tests => 6;

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



ok($date->day_pattern()  eq '21-Aug-68');
###############################################################################
# 2 
###############################################################################
undef $date;
$year = 2009;
$month = 12;
$day = 24;

$date = LBMA::Statistics::Date->new( year => $year,
                                     month => $month,
                                     day => $day,
                                ) or die $!;

ok($date->day_pattern()  eq '24-Dec-09');
###############################################################################
# 3 
###############################################################################
undef $date;
$year = 2005;
$month = 9;
$day = 2;

$date = LBMA::Statistics::Date->new( year => $year,
                                     month => $month,
                                     day => $day,
                                ) or die $!;

ok($date->day_pattern()  eq '02-Sep-05');
###############################################################################
# 4 + 5
###############################################################################
undef $date;

SKIP: {
  eval { use Test::Exception };
  skip 'Test::Exception not installed', 1 if $@;

        # Invalid date (before 1968)
	$year  = 1965;
	$month = 1;
	$day   = 11;
        dies_ok { $date = LBMA::Statistics::Date->new(
                                               year => $year,
                                               month => $month,
                                               day => $day,
                                              ) or die $! } ; 
	dies_ok { $date->day_pattern() };
}

###############################################################################
# 6 Today
###############################################################################
undef $date;
$date = LBMA::Statistics::Date->new(); 
#$year = (localtime())[5];
$year = (gmtime())[5];
$year += 1900;
	# Just the last two digits
$year = substr($year,2,2);
#$day = (localtime())[3];
$day = (gmtime())[3];
$day = sprintf("%02d",$day);
like($date->day_pattern(), qr/$day-...-$year/, 'Testing Today');

