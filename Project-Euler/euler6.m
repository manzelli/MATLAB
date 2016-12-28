%% Project Euler: Problem 6
% The difference between the sum of the squares of the first ten natural numbers and the square of the sum is 
% 3025 - 385 = 2640.
% Find the difference between the sum of the squares of the first one hundred natural numbers
% and the square of the sum.

% I chose to tackle this problem with one for loop that adds the numbers
% 1-100 as well as their squares to two separate variables. Then, I square
% the sum and find the difference. 

sumsq = 0; % Sum of squares
s = 0; % Sum of natural numbers
sqsum = 0; % Square of sum

for i = 1:100
    sumsq = sumsq + (i .^ 2);
    s = s + i;
end

% Find square of sum
sqsum = s .^ 2;
% Find difference
sdiff = sqsum - sumsq;

fprintf('The difference between the sum of the squares of the first one hundred natural numbers and the square of the sum is %d\n',sdiff)