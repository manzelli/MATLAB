%% Project Euler: Problem 2
% Each new term in the Fibonacci sequence is generated by adding the previous two terms. 
% By starting with 1 and 2, the first 10 terms will be: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
% By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

% I tackle this problem by creating an initial vector of all of the
% numbers in the Fibonacci sequence (so I can obtain the next one) and a running sum of the even terms. Using
% a while loop with a condition of 4 million, I calculate the next Fibonacci term and, if it is even, add it to the sum.

fibvec = [1 2];
fibsum = 0; % Running sum preallocation
i = 2;

while fibsum < 4000000 % The sum so far is less than 4 million
    i = i + 1;
    fibvec(i) = fibvec(i-1) + fibvec(i-2); % Sums term before and after current term (next Fibonacci term)
    if mod(fibvec(i),2) == 0 % If the term is even
        fibsum = fibsum + fibvec(i); % Add even terms to sum
    end
end

fprintf('The sum of the even-valued terms of the Fibonacci sequence with terms not exceeding four million is %d \n', fibsum)