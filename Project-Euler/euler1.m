%% Project Euler: Problem 1
% If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. 
% The sum of these multiples is 23. Find the sum of all the multiples of 3 or 5 below 1000.

% I tackle this problem by creating two vectors and collecting all of the terms
% under 1000 that are multiples of 3 and 5, respectively. I then
% concatenate those two vectors and sum them.

tvec = [];
fvec = []; 
for i = 1:999 % Numbers below 1000
    if mod(i,3) == 0 % Is divisible by 3
        tvec(i) = i; % Add to vector
    end
end
for i = 1:999
    if mod(i,5) == 0 % Is divisible by 5
        fvec(i) = i;
    end
end
vec = union(fvec, tvec); % Joins vectors with no overlapping terms

fprintf('The sum of all the multiples of 3 or 5 below 1000 is %d \n',sum(vec))