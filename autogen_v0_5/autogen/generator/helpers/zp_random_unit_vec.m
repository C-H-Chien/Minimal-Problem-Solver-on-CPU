function [ v ] = zp_random_unit_vec( p, d )
% this is an ugly hack, dont try this at home kids

if nargin < 1 || isempty(p)
    p = 30097;
end

if nargin < 2
    d = 3;
end

done = 0;

while ~done
    u = randi(p,d-1,1);
    
    c2 = mod(1-u'*u,p);
    
    for c = 1:p
        if mod(c*c,p) == c2
            v = [u;c];
            done = 1;
            break;
        end
    end
end

