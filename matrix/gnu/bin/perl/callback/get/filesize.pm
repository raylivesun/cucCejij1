#!/usr/bin/perl -w 

use strict;
use warnings;

use FindBin::Bin;
use File::Find;

sub find_files {
    my ($dir, $ext) = @_;
    my @files;

    find(sub {
        my $file = $File::Find::name;
        if (-f $file && $file =~ /\.$ext$/i) {
            push @files, $file;
        }
        return;
        }, $dir);

    return @files;
}

my $dir = FindBin::Bin::RealDirectory;
my @txt_files = find_files($dir, 'txt');

foreach my $txt_file (@txt_files) {
    open(my $fh, '<', $txt_file) or die "Couldn't open file '$txt_file': $!";
    my @lines = <$fh>;
    close($fh);

    my $total_words = 0;
    foreach my $line (@lines) {
        my @words = split(/\s+/, $line);
        $total_words += scalar(@words);
    }
    print "Total words in '$txt_file': $total_words\n";
}



