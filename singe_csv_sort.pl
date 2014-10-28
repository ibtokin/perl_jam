#!/usr/bin/perl
# An alternative example provided by /u/singe at /r/perl
use strict;
use warnings;

BEGIN {
package resstrs;
sub new {
    my $self  = {};
    sub str1 { return "string1\n";}
    sub str2 { return "string2";} 
    sub fname { return "output.csv";} 
    sub strError { my ($self,$m)=@_; return "Exit, error. L=$m\n"; }
    bless($self);
    return $self;
}       
}

my $strO=resstrs->new; 

print $0 ." ". $strO->str1;

my %hash=();
$hash{ $strO->str2 } = "A suggestion"; 

open my $fh, '>', $strO->fname or die $strO->strError(__LINE__);
