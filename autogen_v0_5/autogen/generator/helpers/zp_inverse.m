function [ ainv ] = zp_inverse( a, p )

t = 0; new_t = 1;
r = p; new_r = a;
while new_r ~= 0
    q = floor(r/new_r);
    [t, new_t] = deal(new_t, t - q * new_t);
    [r, new_r] = deal(new_r, r - q * new_r);
end
if t < 0
    t = t + p;
end

ainv = t;
