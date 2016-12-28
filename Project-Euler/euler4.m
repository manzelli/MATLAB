%% Project Euler: Problem 4
% A palindromic number reads the same both ways. 
% The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
% Find the largest palindrome made from the product of two 3-digit numbers.

% I tackled this problem with a nested for loop. Each loop starts with the
% largest 3-digit number, 999, and decreases to the smallest 3-digit
% number, 100. The inner loop creates a product of the two current numbers,
% and checks if it is a palindrome by converting it to a string. If it is
% larger than the maximum, the program replaces the maximum and continues
% checking. 

maxpal = 0;

for i = 999:-1:100 % Start with bigger numbers and decrease to find largest palindrome faster
    for j = 999:-1:100
        prod = i * j; % Product of two current numbers
        sprod = num2str(prod);
        if all(sprod == sprod(end:-1:1)) == 1 && prod > maxpal % If it is a palindrome, and larger than the current max
            maxpal = prod; % Replace the maximum palindrome
            break % Return to outer loop
        end
        if prod < maxpal
            break % Return to outer loop
        end
    end
end

fprintf('The largest palindrome made from the product of two 3-digit numbers is %d \n', maxpal)