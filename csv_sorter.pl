#!/usr/bin/perl
use strict;
use warnings;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
my @sorted_list;

print "\n";
print "Sorted rows:";
print "\n";
open(my $data, '<', $input) or die "Error opening $input!\nCheck your file type and try again.\n";
#open our new csv file:
open my $fh, '>', "output_csv.txt" or die "Can't open output_csv.txt!";
while (my $line = <$data>) {
    chomp $line;
    my @list = split ",", $line;
    if (grep( /^[0-9]*$/, @list)) {
        if (!grep( /^[a-zA-Z]*$/, @list)) {
            print "only numbers!";
            foreach (@list) {
                $_ =~ s/0*(\d+)/$1/;
            }
        }
    }
    @sorted_list = sort { lc($a) cmp lc($b) } @list;
    print join( ',', @sorted_list);
    foreach (@sorted_list) {
        print $fh "$_\n";
    }
    print "\n";
}
close $fh;
print "\n";
