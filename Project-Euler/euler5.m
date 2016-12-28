%% Project Euler: Problem 5
% 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
% What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

% I address this problem with a nested for loop. The outer loop increases
% snum, which is the smallest positive number we are looking for. The inner
% loop checks divisibility by each of the numbers 1-20. The inner loop
% breaks if snum is not divisible by all of the numbers, represented by j. If
% j ever reaches 1, snum is divisible by 1-20, and the loop breaks (the
% first time this happens, snum is the smallest number).

% Initialize limit we know is greater than the smallest number
snum = 0;
lim = 1e10;

for i = 20:20:lim % Increasing by 20 to the limit it won't hit
    for j = 20:-1:1
        if mod(i,j) ~= 0 % If the remainder is ever not zero, it isn't divisible
            break % Return to outer loop
        end
    end
    
    if j == 1 % If j ever gets to one without the loop breaking, it successfully divided through all of the others
        snum = i;
        break % Return to main script
    end
end

fprintf('The smallest positive number that is evenly divisible by all of the numbers from 1 to 20 is %d\n',snum)