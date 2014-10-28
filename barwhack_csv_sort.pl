#!/usr/bin/perl

###vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv# header

###
### 2014.10.24   YourNameHere   Parses and sorts a csv file
###
### notes:
###   This is a bit longer than yours, but it's robust and modifiable
###   include a package name to make this a class (of sorts); it's now available globally in __PACKAGE__
###   the END block in the header can group all the 'globals' without actually making them global (using 'our')
###   use anonymous functions to leave the global space for imported libraries; don't forget the trailing semicolon
###   optional -- use explicit sigil s to search later based on type (I'm a fan);
###   END only run after everything else loads
###     the timer has been moved there and functionalized
###   Data::Dumper is *useful* for debugging complex data structures
###   consider using list-import-style instead of single values
###     then you can manipulate the data as it comes in
###     be aware of array versus scalar context though
###   with a more complex input, it is nice to separate bounds-checking
###     not crucial here, though I did it anyway
###   I like to use $f* for printf formats
###   I like to use $r* for regex content
###   since you are willing to read in the input entirely to memory?
###     bring the open/close in as close as you can and only do it once
###   I moved the timer functionality to the END block
###   you tried to used the <> operator in what seemed like a scalar context
###     if it worked, you are using a method I don't
###     I changed it, though it's probably a lateral delta
###     stripping the carriage-returns windows-proofs it a bit (may not be important)
###   the principle improvement to a sort problem like this?
###     use map with an reorder-index derived from the header
###   the -1 in split permits trailing blank fields if present
###   I functionalized your sort method so that the code documents itself
###   input array context expressly discards after first arg
###   the main body return MUST BE THERE if you use the GOSUB technique
###   GOSUB technique uses goto to put internal procs after the final return
###     it's a clean way to keep internal procedures
###   I didn't implement the rest, but this should get you going good
###
### call tree:
###   INIT
###   END
###     main
###       order
###

package csvsorter;
use strict;
use warnings;
use Time::HiRes;
use Data::Dumper;

INIT
{
  our( $main );
}

END
{
  ### setup
  our( $main );
  my $ftime = "Time elapsed: %s milliseconds\n\n";

  ### do
  my $start = time;
  &$main;
  my $end = time;
  my $time = ( $end - $start );
  printf( $ftime, $time ); ####### output: stdout
}

###vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv# procs

###~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### purpose: coordinate reading, writing, and processing
### input: command line file name
### output: a.out
### call tree:
###   order
our $main = sub
{
  ### setup
  my( $order );
  goto GOSUB; RETURN: ### get internal procs
  my( $input ) = @ARGV; ####### input
  my $rcomma = '\s*[,]\s*';
  my $ffail1 = "Must specify a CSV file as a command line argument!\n";
  my $ffail2 = "Error opening %s!\nCheck your file type.\n";
  my $ffail3 = "Must have content!\n";
  my $fout   = "%s\n";
  if( not $input ) { die( $ffail1 ); } ### early out
  open( my $DATA, '<', $input ) or die( sprintf( $ffail2, $input ) ); ### early out
  my( $header, @in ) = <$DATA>; for( $header, @in ) { chomp; s/\r//; } ####### input: file
  close( $DATA );
  if( not $header ) { die( $ffail3 ); } ### early out
  my @header = split( $rcomma, $header );

  ### do
  my @reorder = sort { &$order( $a, $b, \@header ) } ( 0 .. $#header );
  my $reheader = join( ',', map { $header[$_] } @reorder );
  my @lines;
  for( @in )
  { my @value = split( $rcomma, $_, -1 );
    my @line = map { $value[$_] } @reorder;
    my $line = join( ',', @line );
    push( @lines, $line );
  }
  my $file = 'a.out';
  open( my $OUT, '>', $file );
  printf $OUT( $fout, $reheader );
  for( @lines ) { printf $OUT( $fout, $_ ); } ####### output: file
  close( $OUT );
  return;

  ###---------------------------------------------------------------------------
  GOSUB:
  ### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # purpose: isolate sorting behavior
  # input: two indices and the dictionary itself
  # notes:
  #   you can subsort too, I provided a hook 'byother'
  # output: sort directive
  $order = sub
  {
    ### setup
    my( $a, $b, $index ) = @_; ####### input
    my $headera = $index->[$a];
    my $headerb = $index->[$b];
    my $byindex = ( lc( $headera ) cmp lc( $headerb ) );
    my $byother = 0;

    ### do
    my $directive = ( $byindex or $byother );
    return( $directive ); ####### output
  };
  ### - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  goto RETURN;
};

###
### common functions that you use and port around can go here
###   I'd still make them variables
###   to avoid clashing namespaces with imported packages
###

1;
__END__
