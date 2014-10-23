#!/usr/bin/perl
use strict;
use warnings;
use List::MoreUtils qw(mesh);

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my $start = time();
print "\n";

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
my $first_line = <$data>;
my @header = split ",", $first_line;
my %hash;
my @sorted_row;
my @key;

print "The header row is: ", "@header";

while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line; # Regex Hat Trick:
        #do stuff!
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) { #if digit and not a-z
        foreach (@row) {
            $_ =~ s/0*(\d+)/$1/;
            #remove leading zeros from each element in the row
            my @aa = @header;
            my @bb = @row;
            my @index = sort { $key[$a] <=> $key[$b] } 0 .. $#key;
            @key = @key[@index];
            @sorted_row = @row[@index];
            @hash{@key} = @sorted_row;
            my $new_line = join( ",", @hash{@key});
            print $fh "$new_line\n";

        }
    }
}
close $fh;
my $end = time();
print "Time elapsed: ", $end-$start, " seconds\n\n";





