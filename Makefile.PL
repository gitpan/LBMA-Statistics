use inc::Module::Install;

name 'LBMA-Statistics';
all_from 'lib/LBMA/Statistics.pm';
author 'Thomas Fahle <cpan@thomas-fahle.de>';
license 'perl';

configure_requires 'Module::Install'     => '1.00';
configure_requires 'ExtUtils::MakeMaker' => '6.56';
configure_requires 'Module::AutoInstall';

build_requires 'Test::More';
build_requires 'Module::Install'     => '1.00';
build_requires 'Module::AutoInstall';
build_requires 'ExtUtils::MakeMaker' => '6.56';
build_requires 'Test::Exception'     => '0.25';

requires 'WWW::Mechanize'     => '1.34';
requires 'HTML::TableExtract' => '2.10';
requires 'DateTime'           => '0.41';
requires 'Encode'             => '2.23';
requires 'Log::Log4perl'      => '1.30';

repository "http://github.com/tomfahle/LBMA-Statistics";

auto_install;

WriteAll;

