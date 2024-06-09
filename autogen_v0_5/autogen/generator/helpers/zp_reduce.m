function Ar = zp_reduce(A,p)

sz = size(A);

if isa(A,'multipol')
    [cc,mm] = polynomials2matrix(A(:));
    cc = mod(floor(cc),p);
    Ar = reshape(m2p(cc,mm),sz(1),sz(2));
elseif isa(A,'double')
    Ar = mod(floor(A),p);
elseif isa(A,'sym')
    A = A(:);
    for k = 1:length(A)
        [cc,mm] = coeffs(A(k));
        cc = mod(floor(cc),p);
        Ar(k) = cc * mm.';
    end
    Ar = reshape(Ar,sz(1),sz(2));
end
