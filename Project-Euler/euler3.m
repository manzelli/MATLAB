%% Project Euler: Problem 3
% The prime factors of 13195 are 5, 7, 13 and 29.
% What is the largest prime factor of the number 600851475143?

% Using the Fundamental Theorem of Arithmetic, we may say that any integer
% greater than 1 is either a prime number, or can be written as a unique
% product of prime numbers (the prime factorization).

% The way I've chosen to address this is with a nested while loop. The
% inside while loop checks to see if the divisor is actually a factor of
% 600851475143. Once a factor is found, the number will be divided by that
% factor. By starting at the lower factors, we essentially create a prime
% factorization by factoring out all of the "primes". In the end, there is
% one large prime number that is divisible by itself.

n = 600851475143;
div = 2; % Divisor (starts at 2, as this is the first prime number)

while n ~= 1 % If n = 1, that means the prime number was found
    while mod(n,div) ~= 0 % Not a factor
        div = div + 1; % Increase divisor by 1
    end
    prime = div;
    n = n/prime; % If you find a low factor, there is a corresponding higher factor that will have its own divisibility
    div = div + 1; % Increase divisor so it doesn't keep checking the same one
end

fprintf('The largest prime factor of the number 600851475143 is %d \n', prime)