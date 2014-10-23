#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my @sorted_list;

print "\n";

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
my $first_line = <$data>;
my @header = split ",", $first_line;
print "header IIIISSSSS....... ---> ";
print "@header\n";
print "Sorted rows:\n";

while (my $line = <$data>) {
    chomp $line;
    my @list = split ",", $line; # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @list) ) {
        foreach (@list) {
            $_ =~ s/0*(\d+)/$1/;
        }# if integers and not alphabetical chars
    }#remove leading zeros from elements.
    #default sort: upper/lower case equal, integers lead
    @sorted_list = sort { lc($a) cmp lc($b) } @list;
    @sorted_list = join( ',', @sorted_list);
    print @sorted_list;

    foreach (@sorted_list){
        print $fh "$_\n";
    }
    print "\n";
}
close $fh;
print "\n";
