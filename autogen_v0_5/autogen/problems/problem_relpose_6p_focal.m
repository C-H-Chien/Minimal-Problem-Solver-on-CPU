function [ eqs, data0, eqs_data ] = problem_relpose_6p_focal( data0 )

if nargin < 1 || isempty(data0)
    data0 = randi(50,3*9,1);
end

xx = create_vars(3);

F0 = reshape(data0(1:9),3,3);
F1 = reshape(data0(10:18),3,3);
F2 = reshape(data0(19:27),3,3);

F = F0 + xx(1)*F1 + xx(2)*F2;
Q = diag([1 1 xx(3)]);
Ft = F';

eqs = [2*(F*Q*Ft*Q)*F - sum(diag(F*Q*Ft*Q))*F];
eqs = [eqs(:);det(F)];

if nargout == 3
    xx = create_vars(3+9*3);
    data = xx(4:end);

    F0 = reshape(data(1:9),3,3);
    F1 = reshape(data(10:18),3,3);
    F2 = reshape(data(19:27),3,3);

    F = F0 + xx(1)*F1 + xx(2)*F2;
    Q = diag([1 1 xx(3)]);
    Ft = F';

    eqs_data = [2*(F*Q*Ft*Q)*F - sum(diag(F*Q*Ft*Q))*F];
    eqs_data = [eqs_data(:);det(F)];
end

