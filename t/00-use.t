use Test::More 'tests' => 2;

use_ok( 'IO::Crypt::RSA' );

my $obj = IO::Crypt::RSA->new;

isa_ok( $obj, 'IO::Crypt::RSA' );
