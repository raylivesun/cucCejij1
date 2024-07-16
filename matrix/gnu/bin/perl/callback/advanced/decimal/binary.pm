#!/usr/bin/perl -w 

use strict;
use warnings;
use File::Basename;

my $dir = shift || die "Usage: $0 <directory>";
my $ext = '.txt';

my %files;

foreach my $file (glob "$dir/*$ext") {
    my $base = basename $file;
    my $count = $files{$base}++;
    print "$base: $count\n";
}

