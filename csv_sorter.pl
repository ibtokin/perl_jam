#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";

my $start = time();
open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output.csv" or die "Can't open $input!";

my $first_line = <$data>;
my @header = split ",", $first_line;
chomp @header;
print "\n", "The header row is: ", "@header\n";
my @order = join( ',', @header);
@order = sort { lc($a) cmp lc($b) } @header; # 123-abc sort
foreach (@order){
    print $fh "$_";
}
print $fh "\n";

while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line;

    # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) {
        foreach (@row) { #^if ints, no alphabetical:
            $_ =~ s/0*(\d+)/$1/; #remove trailing zeroes
        }
    }
    my @aa = @header;
    my @bb = @row;
    my @idx = sort { $aa[$a] cmp $aa[$b] } 0 .. $#aa;
    @aa = @aa[@idx];
    @bb = @bb[@idx];
    print $fh "@aa\n";
    #This is where we have to sort
    #We have to sort the array '@row'
    my $sorted = join( ',', @bb);
    print $fh $sorted, "\n";
    }

close $fh;
my $end = time();
print "Time elapsed: ", $end-$start, " seconds\n\n";