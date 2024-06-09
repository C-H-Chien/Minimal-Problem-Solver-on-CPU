function R = zp_rotation(w,p)
if nargin < 2
    p = 30097;
end

w = w(:);
R = mod(zp_inverse(1+w'*w,p) * mod(quat2rot([1;w]),p),p);


