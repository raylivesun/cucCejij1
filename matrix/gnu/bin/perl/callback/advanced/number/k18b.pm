#!/usr/bin/perl -w 

use strict;
use warnings;

use FindBin;
use File::Find;

sub process_file {
    my $file = $File::Find::name;
    my $dir = $File::Find::dir;

    if (-f $file) {
        my $line_count = scalar `wc -l < $file`;
        print "$dir/$file: $line_count lines\n";
    }
    if (-d $file) {
        find(sub { process_file($_) }, $file);
    }
    return;
}

find(sub { process_file($_) }, FindBin::distdir);

