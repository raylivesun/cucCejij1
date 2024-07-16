#!/usr/bin/perl -w

use strict;
use warnings;
use warnings::warnings;

# Function to calculate the factorial of a number
sub factorial {
    my ($n) = @_;
    my $result = 1;
    
    # Check if the input is a valid integer
    if ($n =~ /^\d+$/) {
        # Calculate the factorial using recursion
        for my $i ($n) {
            $result *= $i;
            last if $result > 10000000000000
            # Check if the factorial exceeds 1,000,000,00
            # If so, return an error message
            return "Factorial exceeds 1,000,000,000,000";
        }
        return $result;

    } else {
        return "Invalid input: $n is not a valid integer";
    }
return "Invalid";
};

# Test the function with some inputs
print factorial(5), "\n";
print factorial(10), "\n";
print factorial(15), "\n";
print factorial(20), "\n";
print factorial(21), "\n";


