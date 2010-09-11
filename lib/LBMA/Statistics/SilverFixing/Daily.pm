package LBMA::Statistics::SilverFixing::Daily;

use warnings;
use strict;

our $VERSION = '0.053';

use WWW::Mechanize;
use HTML::TableExtract;
use Encode;
use Log::Log4perl qw/:easy/;

=head1 NAME

LBMA::Statistics::SilverFixing::Daily - Daily Prices Silver Fixings London Bullion Market (Internal only) 

=head1 DESCRIPTION

Does the hard work.


=head1 SYNOPSIS


This modul is for internal use only. There's no need to use it directly.

Everthing is done by LBMA::Statistics (See L<http://search.cpan.org/perldoc?LBMA::Statistics>).

=head2 new - Constructor 

    use strict;

    use warnings;

    use LBMA::Statistics::SilverFixing::Daily;

    my $lbma = LBMA::Statistics::GoldFixing::Daily->new( 
                                        year => $year,
                                                day_pattern => $day_pattern
                                        ) or die $!;

=cut

sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    $self->_init(@_);
    return $self;
}

=head2 _init 

private method to initialize the object

=cut  

sub _init {
    my $self = shift;
    my %args = @_;
    $self->{year}        = $args{year};
    $self->{day_pattern} = $args{day_pattern};
    LOGDIE "Missing mandantory parameter year" unless $self->{year};
    LOGDIE "Missing mandantory parameter day_pattern"
      unless $self->{day_pattern};

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

=head2 dailystatsurl 

determines url for daily silverstats 

=cut

sub dailystatsurl {
    my $self = shift;
    my $url = 'http://www.lbma.org.uk/pages/?page_id=54&title=silver_fixings&show=';
    $url .= $self->year();
    $url .= '&type=daily';
    DEBUG("url: $url");
    return $url;
}

=head2 retrieve_row 

Returns an array of fixings
The number and order of elements varies depending on the year data is retrieved.
There is no EUR before 1999.

        # @fixings 1999 -- 
        # 0 date
        # 1 SILVER USD 
        # 2 SILVER GBP
        # 3 SILVER EUR
        #
        # @fixings 1968 -- 1998  
        # 0 date
        # 1 SILVER USD 
        # 2 SILVER GBP

=cut

sub retrieve_row {
    my $self = shift;
    my $url  = $self->dailystatsurl();

    my $browser = WWW::Mechanize->new(
        stack_depth => 0,
        autocheck   => 1,
    ) or LOGDIE $!;

    $browser->agent_alias('Windows IE 6');    # Hide crawler

    $browser->get($url) or LOGDIE $!;

    my $fixings = $self->_parse( $browser->content() );
    {
        no warnings;
        foreach my $fixing ( @$fixings ) {
                TRACE("Fixing: $fixing");
        }
    }
    return wantarray ? @$fixings : $fixings;
}

=head2 _parse 

parses the content of the retrieved HTML page 

=cut

sub _parse {
    my $self    = shift;
    my $content = shift @_;
    $content = decode_utf8($content);
    my $day_pattern = $self->day_pattern();
    my @fixings     = ();
    my $te          = HTML::TableExtract->new() or LOGDIE $!;
    $te->parse($content) or LOGDIE $!;
  TABLE: foreach my $ts ( $te->tables ) {
      ROW: foreach my $row ( $ts->rows ) {
            next ROW unless defined @$row[0];
            {
                no warnings;
                TRACE( "Current Row: ", join( "|", @$row ) );
            }
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

Copyright 2009, 2010 Thomas Fahle

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

