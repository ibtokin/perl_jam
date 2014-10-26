#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes;

my $input = $ARGV[0] or die "You must specify a CSV file as a command line argument!\n";
open my $data, '<', $input or die "Error opening $input!\nCheck your file type.\n";
open my $fh, '>', "output2.csv" or die "error opening output.csv!\n";
my $start = [ Time::HiRes::gettimeofday( ) ];

my @header = split ",", <$data>;
chomp @header;
print "\n", "Mapping indices according to: ", "\n", "@header\n\n";
my @order = sort { lc($a) cmp lc($b) } @header; # 123-abc natural sort
print $fh join ',', @order,"\n";
while (my $line = <$data>) {
    chomp $line;
    my @row = split ",", $line;
    # Regex Hat Trick:
    if (grep( ((/^[0-9]*$/) && !(/^[a-zA-Z]*$/)), @row) ) {
        foreach (@row) { #if ints and not alphabetical..
            $_ =~ s/0*(\d+)/$1/; #remove trailing zeros
        }
    }#create new vars to simplify the mapping alg:
    my @aa = @header;
    my @bb = @row;
    my @index = sort { $aa[$a] cmp $aa[$b] } 0 .. $#aa;
    @bb = @bb[@index];
    print $fh join ',', @bb, "\n";
}
close $fh;
my $elapsed = Time::HiRes::tv_interval( $start );
print "Elapsed time: $elapsed seconds!\n";