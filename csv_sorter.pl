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
    my @list = split ",", $line; # Regex Hat Trick:
    if (grep( /^[0-9]*$/, @list)) { # if 0-9,
        if (!grep( /^[a-zA-Z]*$/, @list)) { # but no Aa-Zz..
            foreach (@list) {
                $_ =~ s/0*(\d+)/$1/; #remove leading zeros from elements
            }
        }
    }
    #default sort, upper/lower case equal, integers lead
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
