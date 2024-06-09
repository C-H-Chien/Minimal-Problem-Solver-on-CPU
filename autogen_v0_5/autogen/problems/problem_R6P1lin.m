function [ eqs, data0, eqs_data ] = problem_R6P1lin( data0 )

skew = @(v) cross(v(:)*[1 1 1],eye(3));

if nargin < 1 || isempty(data0)
    data0 = randi(50,37,1);
end

xx = create_vars(18);

% -- construct the system --
% -- rows --
r0 = data0(1);
r(1) = data0(2);
r(2) = data0(3);
r(3) = data0(4);
r(4) = data0(5);
r(5) = data0(6);
r(6) = data0(7);

% -- rotation matrix --
vx = xx(1);
vy = xx(2);
vz = xx(3);
wx = xx(4);
wy = xx(5);
wz = xx(6);

Cx = xx(7);
Cy = xx(8);
Cz = xx(9);
tx = xx(10);
ty = xx(11);
tz = xx(12);
lambda(1) = xx(13);
lambda(2) = xx(14);
lambda(3) = xx(15);
lambda(4) = xx(16);
lambda(5) = xx(17);
lambda(6) = xx(18);

% -- projected points --
small_gamma = [];
for i = 1:2:12
    proj_pt = [data0(7+i), data0(8+i), 1];
    small_gamma = [small_gamma; proj_pt];
end

% -- 3d points --
big_gamma = [];
for i = 1:3:18
    pt = [data0(19+i), data0(20+i), data0(21+i)];
    big_gamma = [big_gamma; pt];
end

% -- skew symmetric matrix --
%skew_w = []

% -- rotations --
[Rv, Kv] = Cayley_Model_wo_denom(vx, vy, vz);

C = [Cx; Cy; Cz];
% -- construct the polynomials from 6 points --
%skew(w);

f_collect = [];
for i = 1:6
    RS_Cx = (r(i)-r0)*tx;
    RS_Cy = (r(i)-r0)*ty;
    RS_Cz = (r(i)-r0)*tz;
    RS_C = [RS_Cx; RS_Cy; RS_Cz];

    f = (lambda(i)*small_gamma(i,:).')*Kv - ((eye(3)+(r(i)-r0)*skew([wx; wy; wz]))*Rv*(big_gamma(i,:).') + C*Kv + RS_C*Kv);
    f_collect = [f_collect; f];
end

eqs = f_collect;

if nargout == 3
    xx = create_vars(18+37);
    data = xx(19:end);

    % -- rotation matrix --
    vx = xx(1);
    vy = xx(2);
    vz = xx(3);
    wx = xx(4);
    wy = xx(5);
    wz = xx(6);

    Cx = xx(7);
    Cy = xx(8);
    Cz = xx(9);
    tx = xx(10);
    ty = xx(11);
    tz = xx(12);
    lambda(1) = xx(13);
    lambda(2) = xx(14);
    lambda(3) = xx(15);
    lambda(4) = xx(16);
    lambda(5) = xx(17);
    lambda(6) = xx(18);

    % -- projected points --
    small_gamma = [];
    for i = 1:2:12
        proj_pt = [data(7+i), data(8+i), 1];
        small_gamma = [small_gamma; proj_pt];
    end

    % -- 3d points --
    big_gamma = [];
    for i = 1:3:18
        pt = [data(19+i), data(20+i), data(21+i)];
        big_gamma = [big_gamma; pt];
    end

    % -- rotations --
    [Rv, Kv] = Cayley_Model_wo_denom(vx, vy, vz);

    C = [Cx; Cy; Cz];
    % -- construct the polynomials from 6 points --
    %skew(w);

    f_collect = [];
    for i = 1:6
        RS_Cx = (data(i+1)-data(1))*tx;
        RS_Cy = (data(i+1)-data(1))*ty;
        RS_Cz = (data(i+1)-data(1))*tz;
        RS_C = [RS_Cx; RS_Cy; RS_Cz];

        f = (lambda(i)*small_gamma(i,:).')*Kv - ((eye(3)+(data(i+1)-data(1))*skew([wx; wy; wz]))*Rv*(big_gamma(i,:).') + C*Kv + RS_C*Kv);
        f_collect = [f_collect; f];
    end
    
    eqs_data = f_collect;
end
