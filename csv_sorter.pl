#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my $start = time();
print "\n";

open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
my @order;
my $first_line = <$data>;
my @header = split ",", $first_line;
my %hash;
my @sorted_row;

print "The header row is: ", "@header";

while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line; # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) {
        foreach (@row) {
            $_ =~ s/0*(\d+)/$1/;
        }
        if (!(@order)) {
                @order = join( ',', @row);
                @order = sort { lc($a) cmp lc($b) } @row;
                print "The key being used is: ", "@order\n\n";
        }
            # if integers and not alphabetical chars
    }       #remove leading zeros from elements

    #default sort: upper/lower case equal, integers lead
    #    @sorted_row;#what our hash will sort
    @sorted_row = join( ',', @row);
    foreach (@sorted_row){
        print $fh "$_\n";
    }
}
close $fh;
my $end = time();
print "Time elapsed: ", $end-$start, " seconds\n\n";
