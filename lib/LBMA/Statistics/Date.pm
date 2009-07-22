package LBMA::Statistics::Date;
use strict;
use warnings;

our $VERSION = '0.01';

use DateTime;

=head1 NAME

LBMA::Statistics::Date - Common date methods for LBMA::Statistics (internal only)

=head1 DESCRIPTON

LBMA::Statistics::Date handles common date methods for LBMA::Statistics.

This module is for internal use only. There's no need to access it directly.


=head1 SYNOPSIS


=head2 new - Constructor 

=head3 Parameters

Parameters are all lowercase.

=over 4

=item * year - four digit year (1968 .. )

=item * month - one or two digit month (1 .. 12)

=item * day - one or two digit day (1 .. 31)

=back



    use strict;

    use warnings;

    use LBMA::Statistics::Date;

    my $date = LBMA::Statistics::Date->new( year => $year,
			                    month => $month,
			                    day => $day, 
 	) or die $!;

If no parameters are passed to this class, today is assumed.
Today is determined using UTC. In doubt pass a valid date.


    my $date = LBMA::Statistics::Date->new( ); 

Dies if supplied date isn't valid or year is before 1968.

=cut

sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    $self->_init(@_);
    return $self;
}

=head2 year - returns the year

	print $date->year(), "\n";

=cut

sub year {
    my $self = shift;
    return $self->{year};
}

=head2 day_pattern - returns a date/day-pattern YY-MMM-DD  

	print $date->day_pattern(), "\n";

=cut

sub day_pattern {
    my $self = shift;
    return $self->{day_pattern};
}

=head1 INTERNAL METHODS


=head2 _init 

formats date strings from supplied year, month, day

=cut

sub _init {
    my $self = shift;
    my ( $year, $month, $day );
    my $dt;
    if (@_) {
	# Use supplied date
        my %args = @_;
        $year  = $args{year};
        $month = $args{month};
        $day   = $args{day};
        $dt = DateTime->new(
            year   => $year,
            day    => $day,
            month  => $month,
            locale => 'en_GB',    # It's a british site
        ) or die $!;

    }
    else {
	# Use current date
        $dt = DateTime->now( locale => 'en_GB' ) or die $!;    # It's a british site
        $year  = $dt->year();
        $month = $dt->month();
        $day   = $dt->day();
    }

    # Sanity check for the wild ones
    if ( $year < 1968 ) {
		die "Historic daily prices and monthly and annual averages are available back to 1968."; 
    }

    # Format the date to match (DD-MMM-YY)
    # %b The abbreviated month name ( locale => 'en_GB' ) 
    # %d The day of the month as a decimal number (range 01 to 31)
    # %y The year as a decimal number without a century (range 00 to 99).
    my $day_pattern = $dt->strftime('%d-%b-%y');

    #print "Pattern: $day_pattern\n";
    $self->{day_pattern} = $day_pattern;
    $self->{year}        = $year;
    $self->{month}       = $month;
    $self->{day}         = $day;
}


# return true;
1;
__END__


=head1 PREREQUISITES

=over 4

=item *   DateTime L<http://search.cpan.org/perldoc?DateTime>

=back

=head1 AUTHOR

Thomas Fahle, C<< <cpan at thomas-fahle.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lbma-statistics at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LBMA-Statistics>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc LBMA::Statistics::Date


=head1 COPYRIGHT & LICENSE

Copyright 2009 Thomas Fahle

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
