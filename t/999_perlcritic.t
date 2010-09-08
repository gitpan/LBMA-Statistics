#!perl -T
use Test::More;
use strict;

BEGIN {
    plan( skip_all => 'set AUTHOR_TEST to enable this test' )
            unless $ENV{AUTHOR_TEST};
}


eval 'use Test::Perl::Critic';

plan skip_all => 'Test::Perl::Critic required for testing PBP compliance' if $@;


Test::Perl::Critic::all_critic_ok();

