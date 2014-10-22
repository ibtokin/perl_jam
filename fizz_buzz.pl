# fizz_buzz.pl
# Getting acquainted with Perl. This is my quick n dirty fizz_buzz. Might not be great form, but I'm not familiar at all with Perl conventions.

use feature qw(say);


for my $i (1..100){
    say $i%3==0 && $i%5==0 ? "fizzbuzz"
      : $i%3==0 ? "fizz"
      : $i%5==0 ? "buzz"
      : $i;
}
 
