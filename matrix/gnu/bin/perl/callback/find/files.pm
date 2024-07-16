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
            }");
            my $word_count = scalar(split /\s+/, $content);
            print "$file: $word_count words\n";
        }
        elsif ($ext eq 'jpg' || $ext eq 'JPG') {
            print "$file: Unsupported file format\n";
            system("identify '$file' | grep -o -E '[0-9]+x[0-9]+'");
            my $size = system("identify -format '%w x %h' '$file'");
            print "$file: $size pixels\n";
        }
        elsif ($ext eq 'mp4' || $ext == 'MP4') {
            print "$file: Unsupported file format\n";
            system("ffprobe -i '$file' 2>&1 | grep 'Duration: ' | awk '{print $2}' | sed 's/,.*//'");
            my $duration = system("ffprobe -i '$file' 2>&1 | grep '
            }");
            print "$file: $duration seconds\n";
        }
        else {
            print "$file: Unsupported file format\n";
        }
    }
    elsif (-d $file) {
        print "$file:\n";
    }
}

find(\&process_file, $dir);
