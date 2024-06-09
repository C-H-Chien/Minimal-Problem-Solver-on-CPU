function [ eqs, data0, eqs_data ] = problem_relpose_5p_nineVars( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,5*2*2,1);
end

% -- treat E as a matrix with 9 unknowns --
xx = create_vars(8);

%E = reshape(xx(1:9),3,3);

E = [xx(1), xx(2), xx(3); ...
     xx(4), xx(5), xx(6); ...
     xx(7), xx(8), 1];

% -- 1st set of points, 5 points * 2 dim each, normalized --
X1 = reshape(data0(1:10),2,5);
X1 = [X1; ones(1,5)];

% -- 2nd set of points, 5 points * 2 dim each, normalized --
X2 = reshape(data0(11:20),2,5);
X2 = [X2; ones(1,5)];

% -- five linear equations --
eq1 = X2(:,1)' * E * X1(:,1);
eq2 = X2(:,2)' * E * X1(:,2);
eq3 = X2(:,3)' * E * X1(:,3);
eq4 = X2(:,4)' * E * X1(:,4);
eq5 = X2(:,5)' * E * X1(:,5);

% -- essential matrix constraint 1 --
eq6 = det(E);

% -- essential matrix constraint 2 --
eq7to15 = [2*(E*(E.'))*E - sum(diag(E*(E.')))*E];
eq7to15 = reshape(eq7to15, 9, 1);

% -- concatenate up --
eqs = [eq1; eq2; eq3; eq4; eq5; eq6; eq7to15];

if nargout == 3
    xx = create_vars(8+5*2*2);
    scaleE = xx(1:8);
    
    % -- construct essential matrix --
    E = [scaleE(1), scaleE(2), scaleE(3); ...
         scaleE(4), scaleE(5), scaleE(6); ...
         scaleE(7), scaleE(8), 1];
    
    % -- image points --
    data = xx(9:end);

    % -- 1st set of points, 5 points * 2 dim each, normalized --
    X1 = reshape(data(1:10),2,5);
    X1 = [X1; ones(1,5)];
    
    % -- 2nd set of points, 5 points * 2 dim each, normalized --
    X2 = reshape(data(11:20),2,5);
    X2 = [X2; ones(1,5)];

    % -- 5 linear equations --
    eq1 = X2(:,1)' * E * X1(:,1);
    eq2 = X2(:,2)' * E * X1(:,2);
    eq3 = X2(:,3)' * E * X1(:,3);
    eq4 = X2(:,4)' * E * X1(:,4);
    eq5 = X2(:,5)' * E * X1(:,5);
    
    % -- essential matrix constraint 1 --
    eq6 = det(E);

    % -- essential matrix constraint 2 --
    eq7to15 = [2*(E*(E.'))*E - sum(diag(E*(E.')))*E];
    eq7to15 = reshape(eq7to15, 9, 1);

    % -- concatenate up --
    eqs_data = [eq1; eq2; eq3; eq4; eq5; eq6; eq7to15];
end