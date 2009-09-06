use inc::Module::Install;

name     'LBMA-Statistics';
all_from 'lib/LBMA/Statistics.pm';
author   'Thomas Fahle <cpan@thomas-fahle.de>';
license  'perl';

build_requires 'Test::More';
build_requires 'Module::Install' => '0.68';
build_requires 'Test::Exception' => '0.25';

requires       'WWW::Mechanize'  => '1.34';
requires       'HTML::TableExtract'  => '2.10';
requires       'DateTime'  => '0.41';
requires       'Encode'  => '2.23';

auto_install;

WriteAll;


