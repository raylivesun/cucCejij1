#!/usr/bin/perl -w 

use strict;
use warnings;

use FindBin;
use File::Find;

my $dir = FindBin::RealDirectory;

find(sub {
    my $file = $File::Find::name;
    my $ext = (split /(\.)/, $file)[-1];

    if ($ext eq 'txt') {
        open(my $fh, '<', $file) or die "Couldn't open '$file': $!";
        my $content = <$fh>;
        close $fh;

        my @words = split /\s+/, $content;
        my $count = scalar @words;
        print "$file: $count words\n";
    }
    else {
        print "$file: not a text file\n";
    }
    }, $dir);

