function [ eqs, data0, eqs_data ] = problem_6pt1radial( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,54,1);
end

xx = create_vars(4);
e23 = xx(1);
e31 = xx(2);
e32 = xx(3);
l = xx(4);
e33 = 1;

vv = [e23*l e31*l  e32*l  l^2 e23 e31 e32 l 1]';

e11 = data0(1:9)'*vv;
e12 = data0(10:18)'*vv;
e13 = data0(19:27)'*vv;
e21 = data0(28:36)'*vv;
e22 = data0(37:45)'*vv;
g5 = data0(46:54)'*vv;

E = [e11 e12 e13;e21 e22 e23;e31 e32 e33];
eqs = 2*(E*E')*E - sum(diag(E*E'))*E;
eqs = [eqs(:);l*e13+g5;det(E)];



if nargout == 3
    xx = create_vars(4+54);
    data = xx(5:end);
    e23 = xx(1);
e31 = xx(2);
e32 = xx(3);
l = xx(4);
e33 = 1;

vv = [e23*l e31*l  e32*l  l^2 e23 e31 e32 l 1]';

e11 = data(1:9)'*vv;
e12 = data(10:18)'*vv;
e13 = data(19:27)'*vv;
e21 = data(28:36)'*vv;
e22 = data(37:45)'*vv;
g5 = data(46:54)'*vv;

E = [e11 e12 e13;e21 e22 e23;e31 e32 e33];
eqs_data = 2*(E*E')*E - sum(diag(E*E'))*E;
eqs_data = [eqs_data(:);l*e13+g5;det(E)];


end

