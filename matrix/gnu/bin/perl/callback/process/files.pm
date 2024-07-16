#!/usr/bin/perl -w 

use strict;
use warnings;

use FindBin::Bin;
use File::Basename;
use File::Find;

my $dir = $File::Find::Bin;

sub process_file {
    my $file = $File::Find::name;
    my $base = basename $file;

    if (-f $file) {
        my $ext = (split /\./, $base)[-1];
        if ($ext eq 'txt' || $ext eq 'TXT') {
            open my $fh, '<', $file or die "Can't open file '$file': $!";
            my $content = <$fh>;
            close $fh;

            my $word_count = scalar(split /\s+/, $content);
            print "$file: $word_count words\n";
        }
        elsif ($ext eq 'pdf') {
            print "$file: Unsupported file format\n";
            system("pdftotext -layout '$file' - | grep -o -E '\\b
            (?:\\p{L}+|[\\p{N}_])(?:\\p{L

                |\\p{N}_])*\\b' | wc -l");
        }
        elsif ($ext eq 'docx' || $ext eq 'doc') {
            print "$file: Unsupported file format\n";
            system("antiword '$file' | wc -l");
        }
        else {
            print "$file: Unknown file format\n";
        }
    }
    elsif (-d $file) {
        print "$file:\n";
        process_dir($file);
    }
    else {
        print "$file: Not a regular file or directory\n";
    }
    return;
}

sub process_dir {
    my $dir = shift;
    find(sub { process_file($_) }, $dir);
}

process_dir($dir);
