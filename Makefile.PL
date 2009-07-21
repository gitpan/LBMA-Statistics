use inc::Module::Install;

name     'LBMA-Statistics';
all_from 'lib/LBMA/Statistics.pm';
author   'Thomas Fahle <cpan@thomas-fahle.de>';
license  'perl';

build_requires 'Test::More';

requires       'WWW::Mechanize'  => '1.34';
requires       'HTML::TableExtract'  => '2.10';
requires       'DateTime'  => '0.41';

auto_install;

WriteAll;

