#!/usr/bin/perl

# see http://perlmonks.org/?node_id=970879

use strict;
use warnings;

use 5.014;

use Sort::Key::IPv4 'netipv4keysort';

my %data = (
    '127' => {
        'network' => '10.182.48.0/24',
        'VLAN' => '3509'
    },
    '32' => {
        'network' => '10.182.12.0/25',
        'VLAN' => '2121'
    },
    '36' => {
        'network' => '10.182.2.0/25',
        'VLAN' => '2222'
    },
    '90' => {
        'network' => '10.183.243.128/25',
        'VLAN' => '3494'
    }
);

my @sorted_keys = netipv4keysort { $data{$_}{network} } keys %data;

for my $key (@sorted_keys) {
    printf "%4d%20s%6s\n", $key, $data{$key}{network}, $data{$key}{VLAN};
}
