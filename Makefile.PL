use inc::Module::Install;

name     'LBMA-Statistics';
all_from 'lib/LBMA/Statistics.pm';
author   'Thomas Fahle <cpan@thomas-fahle.de>';
license  'perl';


configure_requires 'Module::Install' => '0.92';

build_requires 'Test::More';
build_requires 'Module::Install' => '0.92';
build_requires 'Test::Exception' => '0.25';

requires       'WWW::Mechanize'  => '1.34';
requires       'HTML::TableExtract'  => '2.10';
requires       'DateTime'  => '0.41';
requires       'Encode'  => '2.23';

# Needs higher Version of Module::Install 
#resources homepage   => 'http://github.com/tomfahle/LBMA-Statistics/tree/master';
#resources repository => 'git://github.com/tomfahle/LBMA-Statistics.git'; 

auto_install;

WriteAll;


