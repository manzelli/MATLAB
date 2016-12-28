% EK301
% Rachel Manzelli
%
% Section: A4 
% Group: "The Last Straw"
%
% This program serves to optimize the truss design and analysis process
% using properties of matrices and array operations as well as other
% linear algebra techniques.
%
% 18 Nov 2016
% v.1.0.0

%% Given information

% F(L) = C/L^2
% F is the maximum compressive force prior to buckling, as a function of
% length, in units of Newtons. 
% C is a fitting coefficient equal to 1277.78 N*cm^2.
% L is the straw length in units of centimeters.

%% Fetching data from input file

clear
clc

% We are using a .mat input file for our truss designs.
% To get the data from the .mat file, we use the simple load command
% followed by the variables we are loading from the file.

% General .mat input file code
inputfile = input('Enter the name of your .mat file (not including the ''.mat''!): ','s');
inputfile = strcat(inputfile, '.mat');
load(inputfile,'C','Sx','Sy','X','Y','L');

% Save number of joints and number of members according to the format of the
% connection matrix
[joints, members] = size(C);

%% Manipulating the data to solve the matrix equation, using procedure on assignment

% Invert first 1 in each column of the connection matrix to -1
for i = 1:members
    % Finding the indices of the first 1 in each column
    ind = find(C(:, i), 1);
    % Changing the 1 to -1 in the given indices of the matrix
    C(ind, i) = -1;
end

% Finding the x and y components between the joints
xdiff = repmat(X * C, joints, 1);
ydiff = repmat(Y * C, joints, 1);

% Creating an array of the distances between x and y, and calculating x and
% y components 
distance = sqrt(xdiff.^2 + ydiff.^2);

xcomp = C .* xdiff ./ distance;
ycomp = C .* ydiff ./ distance;

% concatenating the "A" matrix with all of our known information
A = [xcomp, Sx; ycomp, Sy];

% Solving the matrix equation AT = -L for T, which simplifies to multiplying
% the inverse of the matrix by L in its correct format
% T will be a column vector that represents the forces of each member
% T = A^(-1)* L;
T = A\(-L);

%% Printing results

fprintf('-----------------------------------------------------------------------------------------------------\n')
fprintf('                       Welcome to the EK301 Truss Analysis Extraordinaire                             \n')
fprintf('-----------------------------------------------------------------------------------------------------\n\n')
fprintf('Date of Analysis: %s\n',date)
fprintf('Total Load Applied: %.2f N\n\n', abs(sum(L)))
fprintf('Internal member forces in Newtons:\n')

% Print member, force on the member, and whether compression or tension. m(member): (force) N (C or T)
for i = 1:members
    if T(i) > 0
        % Tension
        fprintf('Member %d: %.3f N (T)\n', i, T(i))
    elseif T(i) < 0
        % Compression
        fprintf('Member %d: %.3f N (C)\n', i, -(T(i)))
    elseif T(i) == 0
        % Zero force member
        fprintf('Member %d: 0 N\n', i)
    else % Catch any possible errors - these are usually ZFM
        fprintf('Member %d: 0 N\n', i)
    end
end
fprintf('\n')

% Determining the total cost of the truss
cost = (10 * joints) + sum(distance(1, :));

% Preallocating an empty vector for members in compression
compression = [];
% Create a vector of members in compression
for i = 1:length(T)
    if T(i) > 0
        compression(1,i) = 0;
    elseif T(i) < 0
        compression(1,i) = abs(T(i));
    end
end

% Determine the maximum load the truss members can handle before buckling
buckleload = zeros(1, members);

for i = 1:members
    % F(L) = C/L^2 using given C and our own straw lengths
    buckleload(1, i) = 1277.78 * (distance(1, i)).^(-2);
end

% Create an array of the ratios of actual loads/maximum loads each member
% can stand, only taking into account members in compression
ratio = zeros(1, members);
for i = 1:members
    ratio(1, i) = compression(1, i)./ buckleload(1, i);
end

% Finds the index (or indices) of member that fails (a member in compression will
% fail)
fail = max(ratio);
failmem = [];

for i = 1:length(ratio)
    if ratio(i) == fail
        failmem(i) = i;
    end
end

failmember = find(failmem);

% Calculate the maximum theoretical load the truss can withstand before buckling
maxload = abs(sum(L)) * 1/fail;

% Calculating the uncertainty, accounting for each failing member (just in
% case there are multiple)
alldist = distance(1,:); % Creating a vector of the distances
uncert = zeros(1:length(failmember));

for i = 1:length(failmember)
    % uncertainty = U_Force/L^3, using given U_Force and our own straw lengths
    uncert(i) = (643.7125)/alldist(failmember(i)).^3;
end

avguncert = sum(uncert)/length(uncert);

% The trusses we are dealing with are pinned at one joint, with a roller support at the other joint.
% Thus, they have 3 total reaction forces: 2 at the pin (the pin restricts motion in the x and y directions) and 1 at the
% roller (the roller only restricts movement in the y-direction). 
% Printing the 3 reaction forces of the truss: Sx (pin x-force), Sy1 (pin
% y-force) and Sy2 (roller y-force):
fprintf('External reaction forces in Newtons:\n')
fprintf('Sx1 (Pin): 0 N\n')
fprintf('Sy1 (Pin): %.3f N\n', -(T(members + 2)))
fprintf('Sy2 (Roller): %.3f N\n', -(T(members + 3)))
fprintf('\n')

%Print total cost
fprintf('Your truss will cost $%.2f.\n', cost)

%Print theoretical maximum load the truss can support
fprintf('The theoretical maximum load the truss can support is %.4f N. \n',maxload)

% Print maximum load/cost ratio
fprintf('Thus, the theoretical max load/cost ratio is %.4f.\n\n', maxload/cost)

% Printing which members will fail first
fprintf('According to your design labels, the following member will fail first: ')

for i = 1:length(failmember)
    fprintf('%d', failmember(i))
end

fprintf('. This is the critical member of your truss.\n')

%Print buckling strength of critical member
fprintf('The buckling strength of the critical member is %.4f N. \n\n', buckleload(failmember))

%Print uncertainty
fprintf('The average uncertainty of the failing member(s) is %.4f N.\n', avguncert)