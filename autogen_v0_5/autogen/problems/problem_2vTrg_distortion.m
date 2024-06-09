function [ eqs, data0, eqs_data ] = problem_2vTrg_distortion( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,15,1);
end

xx = create_vars(5);

X_d1 = reshape(data0(1:2),2,1);
X_d1 = [X_d1; 1];
X_d2 = reshape(data0(3:4),2,1);
X_d2 = [X_d2; 1];
F = reshape(data0(5:13),3,3);
F = F.';
k1 = data0(14);
k2 = data0(15);
Xh_d1 = [xx(1); xx(2); 1];
Xh_d2 = [xx(3); xx(4); 1];
S = [1, 0, 0; 0, 1, 0];
D_xd1 = [1, 0, 2*k1*xx(1); 0, 1, 2*k1*xx(2)];
D_xd2 = [1, 0, 2*k2*xx(3); 0, 1, 2*k2*xx(4)];
u_xhd1 = [xx(1); xx(2); 1+k1*(xx(1)^2+xx(2)^2)];
u_xhd2 = [xx(3); xx(4); 1+k2*(xx(3)^2+xx(4)^2)];

% -- construct polynomials --
eqs(1) = u_xhd1.' * F * u_xhd2;
F1 = 2*S*(Xh_d1 - X_d1) + 2*xx(5)*D_xd1*F*u_xhd2;
eqs(2) = F1(1);
eqs(3) = F1(2);
F2 = 2*S*(Xh_d2 - X_d2) + 2*xx(5)*D_xd2*F*u_xhd1;
eqs(4) = F2(1);
eqs(5) = F2(2);

eqs = eqs.';

if nargout == 3
    xx = create_vars(5+15);
    data = xx(6:end);
    
    X_d1 = reshape(data(1:2),2,1);
    X_d1 = [X_d1; 1];
    X_d2 = reshape(data(3:4),2,1);
    X_d2 = [X_d2; 1];
    F = reshape(data(5:13),3,3);
    F = F.';
    k1 = data(14);
    k2 = data(15);
    Xh_d1 = [xx(1); xx(2); 1];
    Xh_d2 = [xx(3); xx(4); 1];
    S = [1, 0, 0; 0, 1, 0];
    D_xd1 = [1, 0, 2*k1*xx(1); 0, 1, 2*k1*xx(2)];
    D_xd2 = [1, 0, 2*k2*xx(3); 0, 1, 2*k2*xx(4)];
    u_xhd1 = [xx(1); xx(2); 1+k1*(xx(1)^2+xx(2)^2)];
    u_xhd2 = [xx(3); xx(4); 1+k2*(xx(3)^2+xx(4)^2)];
    
    eqs_data(1) = u_xhd1.' * F * u_xhd2;
    F1 = 2*S*(Xh_d1 - X_d1) + 2*xx(5)*D_xd1*F*u_xhd2;
    eqs_data(2) = F1(1);
    eqs_data(3) = F1(2);
    F2 = 2*S*(Xh_d2 - X_d2) + 2*xx(5)*D_xd2*F*u_xhd1;
    eqs_data(4) = F2(1);
    eqs_data(5) = F2(2);
    eqs_data = eqs_data.';
end
