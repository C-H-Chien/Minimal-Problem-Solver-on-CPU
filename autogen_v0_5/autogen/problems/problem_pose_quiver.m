function [ eqs, data0, eqs_data ] = problem_pose_quiver( data0 )

if nargin < 1 || isempty(data0)
    
    data0 = randi(50,4*9,1);
 
end

M = reshape(data0,4,9);
xx = create_vars(4);
a = 1;
b = xx(1);
c = xx(2);
d = xx(3);
w = xx(4);

R = [a^2+b^2-c^2-d^2 2*(b*c-a*d) 2*(b*d+a*c);...
    2*(b*c+a*d) a^2-b^2+c^2-d^2 2*(c*d-a*b);...
    2*(b*d-a*c) 2*(c*d+a*b) a^2-b^2-c^2+d^2];
K = [1 0 0;0 1 0;0 0 w];
KR = K*R;
v = KR(:);
eqs = M*v;

if nargout == 3
    xx = create_vars(4+36);
    data = xx(5:end);
M = reshape(data,4,9);
a = 1;
b = xx(1);
c = xx(2);
d = xx(3);
w = xx(4);

R = [a^2+b^2-c^2-d^2 2*(b*c-a*d) 2*(b*d+a*c);...
    2*(b*c+a*d) a^2-b^2+c^2-d^2 2*(c*d-a*b);...
    2*(b*d-a*c) 2*(c*d+a*b) a^2-b^2-c^2+d^2];
K = [1 0 0;0 1 0;0 0 w];
KR = K*R;
v = KR(:);
eqs_data = M*v;


end

