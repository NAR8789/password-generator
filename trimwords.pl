#!/usr/bin/env perl

while(<>) {
  chomp;
  my $length = length($_);
  print("$length $_\n") if $length >= 3 && $length <= 7;
}
