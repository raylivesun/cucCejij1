#!/usr/bin/perl -w 

use strict;
use warnings;

unit_index_file = "./unit_index";

sub get_unit_index {
    my ($unit_id) = @_;

    open(my $fh, '<', $unit_index_file) or die "Cannot open unit index file: $!";

    while (my $line = <$fh>) {
        chomp $line;
        my ($id, $name) = split /\t/, $line;

        next unless $id eq $unit_id;

        return $name;
    }

    close($fh);

    return undef;
}

my $unit_id = "U12345";
my $unit_name = get_unit_index($unit_id);

if (defined $unit_name) {
    print "Unit $unit_id: $unit_name\n";
    print "Unit $unit_id has been found in the unit index.\n";
    exit 0;
}
else {
    print "Unit $unit_id not found in the unit index.\n";
    exit 1;
}

