function [ eqs ] = transform_C_to_Zp( eqs, p )
if nargin < 1 || isempty(p)
    p = 30097;
    ii = 2334;
else
    % find solution to x^2 + 1 = 0 in Zp
    ii = 1;
    while mod(ii^2+1,p) ~= 0
        ii = ii + 1;
    end
end

if isa(eqs,'multipol')
    [cc,mm] = polynomials2matrix(eqs);
    cc_r = real(cc);
    cc_i = imag(cc);

    cc = mod(cc_r + ii * cc_i,p);
    eqs = m2p(cc,mm);
elseif isa(eqs,'double')
    
    cc_r = real(eqs);
    cc_i = imag(eqs);
    eqs = mod(mod(cc_r,p) + ii * mod(cc_i,p),p);
end

end

