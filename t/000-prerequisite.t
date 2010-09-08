#!perl -T

use Test::More tests => 4;

use_ok('Log::Log4perl');
use_ok('DateTime');
use_ok('HTML::TableExtract');
use_ok('WWW::Mechanize');

diag("Test Prerequisite Modules: Perl $], $^X");

