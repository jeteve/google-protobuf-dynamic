package t::lib::DummyTiedHash;

use strict;
use warnings;
use Tie::Hash;

our @ISA = qw(Tie::StdHash);

sub TIEHASH {
    my ($class, $init) = @_;

    return bless { value => ($init || {}), count => 0 }, $class;
}

sub FETCH {
    $_[0]->{count}++;

    return $_[0]->{value}{$_[1]};
}

sub EXISTS {
    return exists $_[0]->{value}{$_[1]};
}

sub fetch_count {
    return {
        count => $_[0]->{count},
        inner => t::lib::DummyTiedScalar::inner_fetch_count($_[0]->{value}),
    };
}

1;
