function [ eqs, data0, eqs_data ] = problem_relpose_5p_algebraic( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,5*2*2,1);
end

xx = create_vars(6);

Q = xx(1:4);
t = xx(5:6);

qw = Q(1);
qx = Q(2);
qy = Q(3);
qz = Q(4);
R = [1-2*qy^2-2*qz^2,     2*(qx*qy-qw*qz),     2*(qx*qz+qw*qy); ...
     2*(qx*qy+qw*qz),     1-2*qx^2-2*qz^2,     2*(qy*qz-qw*qx); ...
     2*(qx*qz-qw*qy),     2*(qy*qz+qw*qx),     1-2*qx^2-2*qy^2];

% -- anti-skew symmetric matrix --
T = [0, -1, t(2); ... 
     1, 0, -t(1); ...
     -t(2), t(1), 0];
 
% -- construct essential matrix --
E = T*R;

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

% -- quaternion normalization constraint --
eq6 = qw^2+qx^2+qy^2+qz^2-1;

% -- concatenate up --
eqs = [eq1; eq2; eq3; eq4; eq5; eq6];

if nargout == 3
    xx = create_vars(6+5*2*2);
    Q = xx(1:4);
    t = xx(5:6);
    
    qw = Q(1);
    qx = Q(2);
    qy = Q(3);
    qz = Q(4);
    
    % -- convert from quaternion to rotation matrix --
    R = [1-2*qy^2-2*qz^2,     2*(qx*qy-qw*qz),     2*(qx*qz+qw*qy); ...
         2*(qx*qy+qw*qz),     1-2*qx^2-2*qz^2,     2*(qy*qz-qw*qx); ...
         2*(qx*qz-qw*qy),     2*(qy*qz+qw*qx),     1-2*qx^2-2*qy^2];
    
    % -- normalized T --
    T = [0, -1, t(2); ... 
         1, 0, -t(1); ...
         -t(2), t(1), 0];
    
    % -- construct essential matrix --
    E = T*R;
    
    % -- image points --
    data = xx(7:end);

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
    
    % -- quaternion normalization constraint --
    eq6 = qw^2+qx^2+qy^2+qz^2-1;

    % -- concatenate up --
    eqs_data = [eq1; eq2; eq3; eq4; eq5; eq6];
end