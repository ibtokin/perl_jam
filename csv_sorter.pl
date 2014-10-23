#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my $start = time();
open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
my $first_line = <$data>;
my @header = split ",", $first_line;
my %hash;
print "\n", "The header row is: ", "@header";
chomp @header;
my @order = join( ',', @header);
@order = sort { lc($a) cmp lc($b) } @header; # 123-abc sort
print "Key: ", "@order\n\n";
foreach (@order){
    print $fh "$_";
}
print $fh "\n";

while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line;

    # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) {
        foreach (@row) {
            $_ =~ s/0*(\d+)/$1/;
        }
    }
    my @to_sort = join( ',', @row);
    foreach (@to_sort){
        #sorting stuff....
        print $fh "SORTED:  ", "$_\n";
    }

}

close $fh;
my $end = time();
print "Time elapsed: ", $end-$start, " seconds\n\n";