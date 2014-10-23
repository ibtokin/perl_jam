#!/usr/bin/perl
use strict;
use warnings;


my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my @sorted_list;

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type and try again.\n";

print "\n";
print "Original values:\n";
while (my $row = <$data>) {
    my @values = split ",", $row;
    print @values;
}

print "\n";
print "Sorted rows:";
print "\n";
open(my $sdata, '<', $input) or die "Error opening $input!\nCheck your file type and try again.\n";
while (my $line = <$sdata>) {
    chomp $line;
    my @list = split ",", $line;
    @sorted_list = sort { lc($a) cmp lc($b) } @list;
    foreach(@sorted_list) {
        print "$_,";
    }
    print "\n";
}
print "\n";








