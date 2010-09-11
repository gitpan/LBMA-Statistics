use inc::Module::Install;

name 'LBMA-Statistics';
all_from 'lib/LBMA/Statistics.pm';
author 'Thomas Fahle <cpan@thomas-fahle.de>';
license 'perl';

configure_requires 'ExtUtils::MakeMaker' => '6.56';

build_requires 'ExtUtils::MakeMaker' => '6.56';
build_requires 'Test::More'          => '0';
build_requires 'Test::Exception'     => '0.25';
build_requires 'Test::Warn'          => '0.22';

requires 'WWW::Mechanize'     => '1.34';
requires 'HTML::TableExtract' => '2.10';
requires 'DateTime'           => '0.41';
requires 'Encode'             => '2.23';
requires 'Log::Log4perl'      => '1.30';

repository "http://github.com/tomfahle/LBMA-Statistics";

auto_install;

WriteAll;

