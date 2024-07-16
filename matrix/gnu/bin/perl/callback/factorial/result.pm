#!/usr/bin/perl -w 

use strict;
use warnings;
use File::Basename;

# Function to calculate the size of a file in bytes
sub get_file_size {
    my ($file) = @_;
    -f $file && -r $file? -s $file : 0;
}

# Function to calculate the size of a directory in bytes
sub get_directory_size {
    my ($dir) = @_;
    return 0 unless -d $dir;

    my $total_size = 0;
    opendir(my $dh, $dir) or die "Cannot open directory '$dir': $!";
    while (my $file = readdir($dh)) {
        next if $file =~ /^\./;
        $total_size += get_file_size($dir. "/$file") + get_directory_size($dir. "/$file");
    }
    closedir($dh);
    return $total_size;
}

# Function to calculate the size of a file in human-readable format
sub format_size {
    my ($bytes) = @_;
    my @units = ("bytes", "KB", "MB", "GB", "TB", "PB");
    my $unit_index = 0;
    while ($bytes >= 1024 && $unit_index < scalar(@units)) {
        $bytes /= 1024;
        $unit_index++;
    }
    return sprintf("%.2f %s", $bytes, $units[$unit_index]);
}

# Main script
my $dir = $ARGV[0];
if (!$dir) {
    die "Usage: $0 <directory_path>\n";
    exit 1;
}

my $file_count = 0;
my $directory_size = get_directory_size($dir);
opendir(my $dh, $dir) or die "Cannot open directory '$dir':"
while (my $file = readdir($dh)) {
    next if $file =~ /^\./;
    $file_count++;
}
closedir($dh);

print "Directory: $dir\n";


print "Total files: $file_count\n";
print "Total size: ". format_size($directory_size). "\n";


print "Files:\n";
opendir(my $dh, $dir) or die "Cannot open directory '$dir':"
while (my $file = readdir($dh)) {
    next if $file =~ /^\./;
    print "    $file: ". format_size(get_file_size($dir. "/$file")). "\n";
}


closedir($dh);






