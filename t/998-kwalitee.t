#!perl 
use strict;

use Test::More;
BEGIN {
    plan( skip_all => 'set AUTHOR_TEST to enable this test' )
              unless $ENV{AUTHOR_TEST};
}

eval { require Test::Kwalitee;  };

plan( skip_all => 'Test::Kwalitee not installed; skipping' ) if $@;

Test::Kwalitee->import();
