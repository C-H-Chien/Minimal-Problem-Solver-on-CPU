function [ eqs, data0, eqs_data ] = problem_relpose_7p_fr_1s( data0 )

if nargin < 1 || isempty(data0)
 
    data0 = randi(50,41,1);
 
end

xx = create_vars(4);

f3 = xx(1);
f6 = xx(2);
lam = xx(3);
w = xx(4);

h1 = data0(1:6);
h2 = data0(7:12);
h3 = data0(13:18);
h4 = data0(19:24);
h5 = data0(25:30);
h6 = data0(31:36);
h7 = data0(37:41);
vv = [lam*f3 lam*f6 f3 f6 lam 1];

f1 = vv*h1;
f2 = vv*h2;
f4 = vv*h3;
f5 = vv*h4;
f7 = vv*h5;
f8 = vv*h6;
f9 = 1;
vv2 = [lam*f3 f3 f6 lam 1];
g1 = vv2*h7;


F = [f1 f4 f7;f2 f5 f8;f3 f6 f9];
K = [1 0 0;0 1 0;0 0 w];
E = K'*F;

eqs = 2*(E*E')*E - sum(diag(E*E'))*E;
eqs = [eqs(:);det(F)];
eqs = [eqs;lam*f6-g1];

for iii = [1 2 4 5 7 8],
    cc = coeffs(eqs(iii));
    mm = monomials(eqs(iii));
    mm(4,:)=mm(4,:)/2;
    eqs(iii) = multipol(cc,mm);
end
for iii = [3 6 9],
    cc = coeffs(eqs(iii));
    mm = monomials(eqs(iii));
    mm(4,:) = mm(4,:)-1;
    mm(4,:)=mm(4,:)/2;
    eqs(iii) = multipol(cc,mm);
end

if nargout == 3
    xx = create_vars(4+41);
    data = xx(5:end);
    
 
f3 = xx(1);
f6 = xx(2);
lam = xx(3);
w = xx(4);

h1 = data(1:6);
h2 = data(7:12);
h3 = data(13:18);
h4 = data(19:24);
h5 = data(25:30);
h6 = data(31:36);
h7 = data(37:41);
vv = [lam*f3 lam*f6 f3 f6 lam 1];

f1 = vv*h1;
f2 = vv*h2;
f4 = vv*h3;
f5 = vv*h4;
f7 = vv*h5;
f8 = vv*h6;
f9 = 1;
vv2 = [lam*f3 f3 f6 lam 1];
g1 = vv2*h7;


F = [f1 f4 f7;f2 f5 f8;f3 f6 f9];
K = [1 0 0;0 1 0;0 0 w];
E = K'*F;

eqs_data = 2*(E*E')*E - sum(diag(E*E'))*E;
eqs_data = [eqs_data(:);det(F)];
eqs_data = [eqs_data;lam*f6-g1];

for iii = [1 2 4 5 7 8],
    cc = coeffs(eqs_data(iii));
    mm = monomials(eqs_data(iii));
    mm(4,:)=mm(4,:)/2;
    eqs_data(iii) = multipol(cc,mm);
end
for iii = [3 6 9],
    cc = coeffs(eqs_data(iii));
    mm = monomials(eqs_data(iii));
    mm(4,:) = mm(4,:)-1;
    mm(4,:)=mm(4,:)/2;
    eqs_data(iii) = multipol(cc,mm);
end





end

