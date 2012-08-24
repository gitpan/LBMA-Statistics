package LBMA::Statistics;

use warnings;
use strict;

our $VERSION = '0.055';

use LBMA::Statistics::Date;
use LBMA::Statistics::GoldFixing::Daily;
use LBMA::Statistics::SilverFixing::Daily;
use Log::Log4perl qw/:easy/;

=head1 NAME

LBMA::Statistics - Obtain Gold and Silver Fixings (Prices) from London Bullion Market 

=head1 DESCRIPTION

This module obtains Gold and Silver Fixings (Prices) from Statistics of the London Bullion Market L<http://www.lbma.org.uk/pages/index.cfm?page_id=48&title=historical_statistics>.

Information returned by this module is governed by LBMA's terms and conditions. 

C<If you wish to use the gold or silver Fixing prices for commercial purposes, including
 to incorporate them into commercial products which you intend to market, sell or otherwise
 provide to third parties, you must pay the required fee and obtain a licence from
 The London Gold Market Fixing Limited and / or The London Silver Market Fixing Limited as appropriate.
 See www.goldfixing.com and www.silverfixing.com for full details.>

It's designed to use with cron to retrieve data on a B<daily> basis in the evening.

If your looking for historical data (complete years) consider downloading CSV-Files instead.

=over 4

=item * Gold Fixings L<http://www.lbma.org.uk/pages/index.cfm?page_id=53&title=gold_fixings>

=item * Silver Fixings L<http://www.lbma.org.uk/pages/index.cfm?page_id=54&title=silver_fixings> 

=back

=head2 London Gold Fixing

From Wikipedia (L<http://en.wikipedia.org/wiki/Gold_Fixing>):

I<The Gold Fixing (also known as the London Gold Fixing or Gold Fix) is the procedure by which the price of gold is set on the London market by the five members of the London Gold Pool. It is designed to fix a price for settling contracts between members of the London bullion market, but informally the Gold Fixing provides a recognized rate that is used as a benchmark for pricing the majority of gold products and derivatives throughout the world's markets. The Gold Fixing is conducted twice a day by telephone, at 10:30 GMT and 15:00 GMT.>

Gold prices are fixed in United States dollars (USD), Pound sterling (GBP) and since 1999 European euros (EUR).

Historic daily prices are available back to 1968.


=head2 London Silver Fixing


Silver prices are fixed in United States dollars (USD), Pound sterling (GBP) and since 1999 European euros (EUR).

Published once a day at 12:00 GMT. 

Historic daily prices are available back to 1968.

=head1 SYNOPSIS

=head2 new - Constructor 

    use strict;

    use warnings;

    use LBMA::Statistics;

    my $lbma = LBMA::Statistics->new() or die $!;

=cut

sub new {
    my $class = shift;
    my $self  = {};
    bless $self, $class;
    return $self;
}

=head2 dailygoldfixing 

=head3 Parameters

Parameters are all lowercase.

=over 4

=item * year - four digit year (1968 .. )

=item * month - one or two digit month (1 .. 12)

=item * day - one or two digit day (1 .. 31)

=back

    my @fixings = $lbma->dailygoldfixing(
                               year  => $year,
                               month => $month,
                               day   => $day,
                              ) or die;

If no parameters are passed to this method, today is assumed.

Today is determined using UTC. In doubt pass a valid date.

    my @fixings = $lbma->dailygoldfixing( );

Dies if supplied date ain't valid or before 1968.


=head3 return values

Returns an array of fixings.

The number and order of elements varies depending on the year data is retrieved.
There is no EUR before 1999.


        # @fixings 1999 --  
        # 0 date (DD-MMM-YY)
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD A.M. EUR
        # 4 GOLD P.M. USD
        # 5 GOLD P.M. GBP
        # 6 GOLD P.M. EUR 
        #
        # @fixings 1968 -- 1998  
        # 0 date (DD-MMM-YY)
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD P.M. USD
        # 4 GOLD P.M. GBP

In scalar context a reference to an array is returned.

Returns undef or empty list if data can't be retrieved e.g. dates without fixing like holidays.

Returns an array with the date slot filled and undef for all other slots if you're trying to fetch data before A.M. fixing.

Returns an array with the date and A.M. slots filled and whitespace for all other slots if you're trying to fetch data before P.M. and after A.M. fixing.


=cut

sub dailygoldfixing {
    my $self        = shift;
    my $date        = LBMA::Statistics::Date->new(@_);
    my $year        = $date->year();
    my $day_pattern = $date->day_pattern();
    my $dailygold   = LBMA::Statistics::GoldFixing::Daily->new(
        year        => $year,
        day_pattern => $day_pattern,
    );
    my $goldfixing = $dailygold->retrieve_row();

    if ( scalar @$goldfixing > 1 ) {
        DEBUG( "Goldfixing Result: ", join( ', ', @$goldfixing ) );
    }
    else {
        LOGWARN("No Goldfixing Results: $year, $day_pattern");
    }

    return wantarray ? @$goldfixing : $goldfixing;
}

=head2 dailygoldfixing_am 

same as dailygoldfixing but returns just the A.M. Fixing Data

        my @fixings = $lbma->dailygoldfixing_am( );

        my @fixings = $lbma->dailygoldfixing_am(
                               year  => $year,
                               month => $month,
                               day   => $day,
                              ) or die;

        # @fixings 1999 - ... 
        # 0 date
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD A.M. EUR
        # @fixings 1968 - 1998 
        # 0 date
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP

=cut

sub dailygoldfixing_am {
    my $self        = shift;
    my $date        = LBMA::Statistics::Date->new(@_);
    my $year        = $date->year();
    my $day_pattern = $date->day_pattern();
    my $dailygold   = LBMA::Statistics::GoldFixing::Daily->new(
        year        => $year,
        day_pattern => $day_pattern,
    );
    my $goldfixing = $dailygold->retrieve_row_am();

    if ( scalar @$goldfixing > 1 ) {
        DEBUG( "Goldfixing AM Result: ", join( ', ', @$goldfixing ) );
    }
    else {
        LOGWARN("No Goldfixing AM Results: $year, $day_pattern");
    }

    return wantarray ? @$goldfixing : $goldfixing;
}

=head2 dailysilverfixing

=head3 Parameters

Parameters are all lowercase.

=over 4

=item * year - four digit year (1968 .. )

=item * month - one or two digit month (1 .. 12)

=item * day - one or two digit day (1 .. 31)

=back

        my @fixings = $lbma->dailysilverfixing(
                                 year  => $year,
                                 month => $month,
                                 day   => $day,
                              ) or die;

If no parameters are passed to this class, today is assumed.
Today is determined using UTC. In doubt pass a valid date.

        my @fixings = $lbma->dailysilverfixing( );

Dies if supplied date ain't valid or before 1968.


=head3 return values

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

In scalar context a reference to an array is returned.

Returns undef or empty list if data can't be retrieved e.g. dates without fixing like holidays.

Returns an array(ref) with the date slot filled and undef for all other slots if you're trying to fetch data before the fixing.


=cut

sub dailysilverfixing {
    my $self        = shift;
    my $date        = LBMA::Statistics::Date->new(@_);
    my $year        = $date->year();
    my $day_pattern = $date->day_pattern();
    my $dailysilver = LBMA::Statistics::SilverFixing::Daily->new(
        year        => $year,
        day_pattern => $day_pattern,
    );
    my $silverfixing = $dailysilver->retrieve_row();
    if ( scalar @$silverfixing > 1 ) {
        DEBUG( "Silverfixing Result: ", join( ', ', @$silverfixing ) );
    }
    else {
        LOGWARN("No Silverfixing Results: $year, $day_pattern");
    }
    return wantarray ? @$silverfixing : $silverfixing;
}

=head1 EXAMPLES

=head2 Example 1 Daily Gold Fixing

        #!/usr/bin/perl
        use warnings;
        use strict;

        use LBMA::Statistics;

        use Log::Log4perl qw/:easy/;

        Log::Log4perl->easy_init();

        my $lbma =  LBMA::Statistics->new();

        print join("|",$lbma->dailygoldfixing() ) ,"\n";
        print join("|",$lbma->dailygoldfixing( year => 2009, month => 2, day => 2) ) , "\n";
        print join("|",$lbma->dailygoldfixing( year => 2000, month => 1, day => 4) ) , "\n";


=head2 Example 2 Daily Goldy Fixing A.M. data

    #!/usr/bin/perl
    use warnings;
    use strict;

    use LBMA::Statistics;

    use Log::Log4perl qw/:easy/;

    Log::Log4perl->easy_init();

    my $lbma =  LBMA::Statistics->new();

        # @fixings 
        # 0 date
        # 1 GOLD A.M. USD 
        # 2 GOLD A.M. GBP
        # 3 GOLD A.M. EUR
    print join("|",$lbma->dailygoldfixing_am() ) ,"\n";
    print join("|",$lbma->dailygoldfixing_am( year => 2009, month => 2, day => 2) ) , "\n";
    print join("|",$lbma->dailygoldfixing_am( year => 2000, month => 1, day => 4) ) , "\n";


=head2 Example 3 Daily Silver Fixing

        #!/usr/bin/perl
        use warnings;
        use strict;

        use LBMA::Statistics;

        use Log::Log4perl qw/:easy/;

        Log::Log4perl->easy_init();

        my $lbma =  LBMA::Statistics->new();

        print join("|",$lbma->dailysilverfixing() ) ,"\n";
        print join("|",$lbma->dailysilverfixing( year => 2009, month => 2, day => 2) ) , "\n";
        print join("|",$lbma->dailysilverfixing( year => 2000, month => 1, day => 4) ) , "\n";


=head1 SEE ALSO

=over 4

=item * Statistics of the London Bullion Market L<http://www.lbma.org.uk/pages/index.cfm?page_id=48&title=historical_statistics>

=item * LBMA Statistics Gold Fixing L<http://www.lbma.org.uk/pages/index.cfm?page_id=53&title=gold_fixings>

=item * LBMA Statistics Silver Fixing L<http://www.lbma.org.uk/pages/?page_id=54&title=silver_fixings>

=item * Finance::Quote::GoldMoney L<http://search.cpan.org/perldoc?Finance::Quote::GoldMoney>

=back

=head1 PREREQUISITES

=over 4

=item *   DateTime L<http://search.cpan.org/perldoc?DateTime>

=item *   WWW::Mechanize L<http://search.cpan.org/perldoc?WWW::Mechanize>

=item *   HTML::TableExtract L<http://search.cpan.org/perldoc?HTML::TableExtract>

=item *   Log::Log4perl L<http://search.cpan.org/perldoc?Log::Log4perl>

=back

=head1 TODO


=over 4

=item * Write more tests

=item * Find a solution for handling years before 1999 (the years before the european EUR)

=item * Add methods to return hashes for data rows 


=back


=head1 AUTHOR

Thomas Fahle, C<< <cpan at thomas-fahle.de> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-lbma-statistics at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=LBMA-Statistics>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc LBMA::Statistics


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=LBMA-Statistics>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/LBMA-Statistics>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/LBMA-Statistics>

=item * Search CPAN

L<http://search.cpan.org/dist/LBMA-Statistics/>

=back


=head1 COPYRIGHT & LICENSE

Copyright 2009, 2010, 2012 Thomas Fahle

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut

1;    # End of LBMA::Statistics
