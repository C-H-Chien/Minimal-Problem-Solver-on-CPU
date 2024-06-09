function [ eqs, data0, eqs_data ] = problem_relpose_5p_geometric( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,5*2*2,1);
end

xx = create_vars(6);

Q = xx(1:4);
t = xx(5:6);

q0 = Q(1);
q1 = Q(2);
q2 = Q(3);
q3 = Q(4);
%R = [q0^2+q1^2-q2^2-q3^2, 2*(q1*q2-q0*q3),     2*(q1*q3+q0*q2); ...
%     2*(q1*q2+q0*q3),     q0^2+q1^2-q2^2-q3^2, 2*(q2*q3-q0*q1); ...
%     2*(q1*q3-q0*q2),     2*(q2*q3+q0*q1),     q0^2-q1^2-q2^2+q3^2];

R = [1-2*q2^2-2*q3^2,     2*(q1*q2-q0*q3),     2*(q1*q3+q0*q2); ...
     2*(q1*q2+q0*q3),     1-2*q1^2-2*q3^2,     2*(q2*q3-q0*q1); ...
     2*(q1*q3-q0*q2),     2*(q2*q3+q0*q1),     1-2*q1^2-2*q2^2];

% -- normalized T --
T = [t(1); t(2); 1];

% -- 1st set of points, 5 points * 2 dim each, normalized --
X1 = reshape(data0(1:10),2,5);
X1 = [X1; ones(1,5)];

% -- 2nd set of points, 5 points * 2 dim each, normalized --
X2 = reshape(data0(11:20),2,5);
X2 = [X2; ones(1,5)];

res = T'*(cross(X2, R*X1));
eqs = res';
eqs = [eqs; q0^2+q1^2+q2^2+q3^2-1];

if nargout == 3
    xx = create_vars(6+5*2*2);
    Q = xx(1:4);
    t = xx(5:6);
    
    q0 = Q(1);
    q1 = Q(2);
    q2 = Q(3);
    q3 = Q(4);
    
    % -- convert from quaternion to rotation matrix --
    R = [1-2*q2^2-2*q3^2,     2*(q1*q2-q0*q3),     2*(q1*q3+q0*q2); ...
         2*(q1*q2+q0*q3),     1-2*q1^2-2*q3^2,     2*(q2*q3-q0*q1); ...
         2*(q1*q3-q0*q2),     2*(q2*q3+q0*q1),     1-2*q1^2-2*q2^2];
    
    % -- normalized T --
    T = [t(1); t(2); 1];
    
    % -- image points --
    data = xx(7:end);

    % -- 1st set of points, 5 points * 2 dim each, normalized --
    X1 = reshape(data(1:10),2,5);
    X1 = [X1; ones(1,5)];
    
    % -- 2nd set of points, 5 points * 2 dim each, normalized --
    X2 = reshape(data(11:20),2,5);
    X2 = [X2; ones(1,5)];

    % -- 5 linear equations --
    res = T'*(cross(X2, R*X1));
    eqs_data = res';
    eqs_data = [eqs_data; q0^2+q1^2+q2^2+q3^2-1];
end