#!/usr/bin/perl
use strict;
use warnings;
use List::MoreUtils qw(mesh);

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my $start = time();
print "\n";

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
my @key;
my $first_line = <$data>;
my @header = split ",", $first_line;
my %hash;
my @sorted_row;

print "The header row is: ", "@header";

while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line; # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) { #if digit and not a-z
        foreach (@row) {
            $_ =~ s/0*(\d+)/$1/; #remove leading zeros from each element
            if (@key) {
                print "There's a key!\n", "@key\n";
                #do stuff!
                my @index = sort { $key[$a]  <=> $key[$b]} 0 .. $#key;
                @key = @key[@index];
                @row = @row[@index];
                print "sorted row: @row\n";
                #
            }
            else {
                print "there's no key! :(   \n";
                @key = sort { lc($a) cmp lc($b) } @row;
                print "Key assigned:  @key\n";
                #default sort: upper/lower case equal, integers lead
            }
        }

    }
}
close $fh;
my $end = time();
print "Time elapsed: ", $end-$start, " seconds\n\n";
