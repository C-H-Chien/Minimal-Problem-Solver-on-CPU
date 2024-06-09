function [eqs,data0,eqs_data] = problem_trisonal_stewenius(data0)

    if nargin < 1 || isempty(data0)
        data0 = randi(64,7*4,1);
    end

    xx = create_vars(4);
    Ti = reshape(data0,7,4);
    T = Ti*xx;
    
    eq1 = T(5)*T(7)*(2*T(6)+T(7))+T(5)^2*T(7)-T(1);
    eq2 = -T(6)*(T(5)+2*T(6)+T(7))-T(2);
    eq3 = T(5)*(T(6)+T(7))-T(3);
    eq4 = T(7)*(T(5)+T(6))-T(4);
    
    eqs = [eq1; eq2; eq3; eq4];

    if nargout == 3
        xx = create_vars(4+7*4);
        data = xx(5:end);

        Ti = reshape(data,7,4);
        T = Ti*xx(1:4);

        eq1 = T(5)*T(7)*(2*T(6)+T(7))+T(5)^2*T(7)-T(1);
        eq2 = -T(6)*(T(5)+2*T(6)+T(7))-T(2);
        eq3 = T(5)*(T(6)+T(7))-T(3);
        eq4 = T(7)*(T(5)+T(6))-T(4);

        eqs_data = [eq1; eq2; eq3; eq4];
    end
end

