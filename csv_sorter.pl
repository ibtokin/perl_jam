#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type and try again.\n";
my $i = 0;
while (my $line = <$data>) {
    my @values = split ",", $line;
    print @values;
}
#my $newline = split(',', input)