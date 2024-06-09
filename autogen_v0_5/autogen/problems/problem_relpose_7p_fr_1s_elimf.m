function [ eqs, data0, eqs_data ] = problem_relpose_7p_fr_1s_elimf( data0 )

if nargin < 1 || isempty(data0)
 
    data0 = randi(50,41,1);
 
end

xx = create_vars(3);

f3 = xx(1);
f6 = xx(2);
lam = xx(3);
%w = xx(4);

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
% K = [1 0 0;0 1 0;0 0 w];
% E = K'*F;

f11 = F(1,1);
f21 = F(2,1);
f31 = F(3,1);
f12 = F(1,2);
f22 = F(2,2);
f32 = F(3,2);
f13 = F(1,3);
f23 = F(2,3);
f33 = F(3,3);



% eqs = [f13*f22*f31-f12*f23*f31-f13*f21*f32+f11*f23*f32+f12*f21*f33-f11*f22*f33;...
%      f11*f13*f23*f31+f21*f23^2*f31+f12*f13*f23*f32+f22*f23^2*f32-f11*f13*f21*f33-f12*f13*f22*f33-f21^2*f23*f33-f22^2*f23*f33+f23*f31^2*f33+f23*f32^2*f33-f21*f31*f33^2-f22*f32*f33^2;...
%      f11*f13^2*f31+f13*f21*f23*f31+f12*f13^2*f32+f13*f22*f23*f32-f11^2*f13*f33-f12^2*f13*f33-f11*f21*f23*f33-f12*f22*f23*f33+f13*f31^2*f33+f13*f32^2*f33-f11*f31*f33^2-f12*f32*f33^2;...
%      f11*f13^2*f21+f12*f13^2*f22-f11^2*f13*f23-f12^2*f13*f23+f13*f21^2*f23+f13*f22^2*f23-f11*f21*f23^2-f12*f22*f23^2+f13*f21*f31*f33-f11*f23*f31*f33+f13*f22*f32*f33-f12*f23*f32*f33];
 
eqs =[ f13*f22*f31-f12*f23*f31-f13*f21*f32+f11*f23*f32+f12*f21*f33-f11*f22*f33;...
      f11*f13*f31*f32+f21*f23*f31*f32+f12*f13*f32^2+f22*f23*f32^2-f11*f12*f31*f33-f21*f22*f31*f33-f12^2*f32*f33+f13^2*f32*f33-f22^2*f32*f33+f23^2*f32*f33-f12*f13*f33^2-f22*f23*f33^2;...
      f11*f13*f31^2+f21*f23*f31^2+f12*f13*f31*f32+f22*f23*f31*f32-f11^2*f31*f33+f13^2*f31*f33-f21^2*f31*f33+f23^2*f31*f33-f11*f12*f32*f33-f21*f22*f32*f33-f11*f13*f33^2-f21*f23*f33^2;...
      f11*f12*f31^2+f21*f22*f31^2-f11^2*f31*f32+f12^2*f31*f32-f21^2*f31*f32+f22^2*f31*f32-f11*f12*f32^2-f21*f22*f32^2+f12*f13*f31*f33+f22*f23*f31*f33-f11*f13*f32*f33-f21*f23*f32*f33];
  
 
eqs = [eqs;lam*f6-g1];



if nargout == 3
    xx = create_vars(3+41);
    data = xx(4:end);
    
 

f3 = xx(1);
f6 = xx(2);
lam = xx(3);
%w = xx(4);

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
% K = [1 0 0;0 1 0;0 0 w];
% E = K'*F;

f11 = F(1,1);
f21 = F(2,1);
f31 = F(3,1);
f12 = F(1,2);
f22 = F(2,2);
f32 = F(3,2);
f13 = F(1,3);
f23 = F(2,3);
f33 = F(3,3);


eqs_data =[ f13*f22*f31-f12*f23*f31-f13*f21*f32+f11*f23*f32+f12*f21*f33-f11*f22*f33;...
      f11*f13*f31*f32+f21*f23*f31*f32+f12*f13*f32^2+f22*f23*f32^2-f11*f12*f31*f33-f21*f22*f31*f33-f12^2*f32*f33+f13^2*f32*f33-f22^2*f32*f33+f23^2*f32*f33-f12*f13*f33^2-f22*f23*f33^2;...
      f11*f13*f31^2+f21*f23*f31^2+f12*f13*f31*f32+f22*f23*f31*f32-f11^2*f31*f33+f13^2*f31*f33-f21^2*f31*f33+f23^2*f31*f33-f11*f12*f32*f33-f21*f22*f32*f33-f11*f13*f33^2-f21*f23*f33^2;...
      f11*f12*f31^2+f21*f22*f31^2-f11^2*f31*f32+f12^2*f31*f32-f21^2*f31*f32+f22^2*f31*f32-f11*f12*f32^2-f21*f22*f32^2+f12*f13*f31*f33+f22*f23*f31*f33-f11*f13*f32*f33-f21*f23*f32*f33];


eqs_data = [eqs_data;lam*f6-g1];




end

