package IO::Crypt::RSA;

use strict;
use warnings;

use Symbol;

sub new {
    my ($cls, @args) = @_;
    my %args;
    %args = (
        %args,
        @args,
        'buffer' => [],
    );
    my $self = bless Symbol::gensym(), $cls;
    foreach (keys %args) {
        *$self->{$_} = $args{$_};
    }
    return $self->init;
}

sub init {
    my ($self) = @_;
    my $path = $self->path;
    my $fh   = $self->handle;
    if ($fh) {
        # --- Nothing to do
    }
    elsif (defined $path) {
        $self->open($path, $self->mode);
    }
    else {
        # --- Nothing to do
    }
    $self->tie; # unless $self->dont_tie;
    return $self;
}

sub path   { scalar @_ > 1 ? *{$_[0]}->{'path'} = $_[1] : *{$_[0]}->{'path'} }
sub mode   { scalar @_ > 1 ? *{$_[0]}->{'mode'} = $_[1] : *{$_[0]}->{'mode'} }
sub buffer { scalar @_ > 1 ? *{$_[0]}->{'buffer'} = $_[1] : *{$_[0]}->{'buffer'} }
sub handle { scalar @_ > 1 ? *{$_[0]}->{'handle'} = $_[1] : *{$_[0]}->{'handle'} }

sub tie {
    my ($self) = @_;
    tie *$self, $self; 
    return $self;
}

sub TIEHANDLE() {
    return $_[0] if ref $_[0];
    my $class = shift;
    my $self = bless Symbol::gensym(), $class;
    $self->init(@_);
}

1;

=head1 NAME

IO::Crypt::RSA - read and write encrypted large streams

=head1 SYNOPSIS

    use IO::Crypt::RSA;
    
    $io = IO::Crypt::RSA->new(
        'handle'     => $fh,
        'mode'       => '>',  # or 'w'; '<' or 'r'; '>>' or 'a'
        'public_key' => '/path/to/a/file'
    );
    
    print $io $mystring;

    $io = IO::Crypt::RSA->new(
        'handle'      => $fh,
        'mode'        => '<',  # or 'w'; '<' or 'r'; '>>' or 'a'
        'private_key' => '/path/to/a/file'
    );


=head1 DESCRIPTION

B<IO::Crypt::RSA> may be used to read and write large encrypted files
using RSA and AES to secure the contents. 

Internally, the module generates a random key and uses that to encrypt
the stream data. The main stream contents is encrypted using AES, and 
the provided public key is used encrypt the random key so the data can
be read back. 

=head1 AUTHOR

Stuart Watt (stuart AT morungos DOT com)

=head1 COPYRIGHT

Copyright 2015 Stuart Watt.

This is free software, and is made available under the same terms as
Perl itself.