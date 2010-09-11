#!perl -T
use strict;
use warnings;

use Test::More tests => 6 ;

use LBMA::Statistics::Date;

my $year  = 1968;
my $month = 8;
my $day   = 21;

my $date = LBMA::Statistics::Date->new(
    year  => $year,
    month => $month,
    day   => $day,
) or die $!;

ok( $date->year() == 1968, 'Year 1968' );

$year  = 2010;
$month = 1;
$day   = 1;
$date = LBMA::Statistics::Date->new(
    year  => $year,
    month => $month,
    day   => $day,
) or die $!;

ok( $date->year() == 2010, 'Year 2010' );

# Today
$date = LBMA::Statistics::Date->new();
$year = ( gmtime() )[5];
$year += 1900;
ok( $date->year() == $year, "Today $year" );


SKIP: {
    eval {  use Test::Exception };
    skip 'Test::Exception not installed', 3 if $@;

    # Invalid date
    $year  = 2001;
    $month = 2;
    $day   = 29;
    dies_ok {
        $date = LBMA::Statistics::Date->new(
            year  => $year,
            month => $month,
            day   => $day,
        );
    }
    'expecting to die on invalid dates';

    # No data before 1968
    $year  = 1965;
    $month = 1;
    $day   = 1;
    dies_ok {
        $date = LBMA::Statistics::Date->new(
            year  => $year,
            month => $month,
            day   => $day,
        );
    }
    'No data before 1968';
    # No data in the future 
    $year  = 4999;
    $month = 1;
    $day   = 1;
    dies_ok {
        $date = LBMA::Statistics::Date->new(
            year  => $year,
            month => $month,
            day   => $day,
        );
    }
    'No data in the future';
}



