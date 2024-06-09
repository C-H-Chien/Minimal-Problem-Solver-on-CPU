function [ Ainv ] = zp_matrix_inverse( A, p )
n = size(A,2);

Ainv = [];
for k = 1:size(A,2)
    e = zeros(size(A,1),1);
    e(k) = 1;
    Ainv = [Ainv zp_linsolve(A,e,p)];
end
end

