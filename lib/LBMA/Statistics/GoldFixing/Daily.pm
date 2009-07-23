package LBMA::Statistics::GoldFixing::Daily;

use warnings;
use strict;

our $VERSION = '0.01';

use WWW::Mechanize;
use HTML::TableExtract;

=head1 NAME

LBMA::Statistics::GoldFixing::Daily - Daily Prices Gold Fixings London Bullion Market (Internal only) 

=head1 DESCRIPTION

Does the hard work.


=head1 SYNOPSIS


This modul is for internal use only. There's no need to use it directly.

Everthing is done by LBMA::Statistics (See L<http://search.cpan.org/perldoc?LBMA::Statistics>).  


=head2 new - Constructor 

    use strict;

    use warnings;

    use LBMA::Statistics::GoldFixing::Daily;

    my $lbma = LBMA::Statistics::GoldFixing::Daily->new( 
     						year => $year,
				 		day_pattern => $day_pattern
					) or die $!;

=cut

sub new {
    my $class = shift;
    my $self = {};
    bless $self , $class;
    $self->_init(@_);
    return $self;
}

=head2 _init 

	private method to initialize the object

=cut  
sub _init {
	my $self = shift;
	my %args = @_;
	$self->{year} = $args{year};
	$self->{day_pattern} = $args{day_pattern};
	die "Missing mandantory parameter year" unless $self->{year};
	die "Missing mandantory parameter day_pattern" unless $self->{day_pattern};

}

=head2 year 

returns the year to look for

=cut

sub year {
	my $self = shift;
	return $self->{year};
}

=head2 day_pattern

returns the day_pattern to look for

=cut 

sub day_pattern {
	my $self = shift;
	return $self->{day_pattern};
}

=head2 retrieve_row 

Returns an array of fixings.

The number and order of elements varies depending on the year data is retrieved.
There were no EUR befor 1999.


        # @fixings 1999 --  
        # 0 date (DD-MMM-YY)
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD A.M. EUR
        # 4 GOLD P.M. USD
        # 5 GOLD P.M. GBP
        # 6 GOLD P.M. EUR 
        # @fixings 1968 -- 1998  
        # 0 date (DD-MMM-YY)
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD P.M. USD
        # 4 GOLD P.M. GBP
        
In scalar context a reference to an array is returned.

Returns undef or empty list if data can't be retrieved e.g. dates without fixing  like holydays.

=cut

sub retrieve_row {
	my $self = shift;

        my $url = 'http://www.lbma.org.uk/?area=stats&page=gold/';
        $url .= $self->year() ;
        $url .= 'dailygold';

        my $browser = WWW::Mechanize->new(
                        stack_depth => 10,
                        autocheck => 1,
                ) or die $!;

        $browser->agent_alias( 'Windows IE 6' ); # Hide crawler

        $browser->get($url) or die $! or die $!;

        my $fixings = $self->_parse( $browser->content());
        return wantarray ? @$fixings : $fixings;
}

=head2 

parses the content of the retrieved HTML page

=cut


sub _parse {
	my $self = shift;
        my $content = shift @_;
        my $day_pattern = $self->day_pattern();
        my @fixings = ();
        my $te = HTML::TableExtract->new(  ) or die $!;
        $te->parse( $content ) or die $!;
        my $ts; # table structure
TABLE:  foreach $ts ($te->tables) {
ROW:            foreach my $row ($ts->rows) {
                        next ROW unless defined @$row[0];
                        #print join("\t", @$row), "\n";
                        next ROW unless @$row[0] =~ m/$day_pattern/;
                        @fixings = @$row;
                        last TABLE;
                }
        }
        return wantarray ? @fixings : \@fixings;
}




1;
__END__

=head1 AUTHOR

Thomas Fahle, C<< <cpan at thomas-fahle.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lbma-statistics at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LBMA-Statistics>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 COPYRIGHT & LICENSE

Copyright 2009 Thomas Fahle

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

