use strict;
use warnings;

my @aa = qw/ 1 6 8 4 5 /;
my @bb = qw/ a c d f w /;

my @idx = sort { $aa[$a] <=> $aa[$b] } 0 .. $#aa;

@aa = @aa[@idx];
@bb = @bb[@idx];

print "@aa\n";
print "@bb\n";