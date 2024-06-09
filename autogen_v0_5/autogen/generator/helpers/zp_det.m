function d = zp_det(A,p)
d = zp_det2(zp_reduce(A,p),p);

function d = zp_det2(A,p)
n = size(A,2);
if n == 1
    d = A;
    return;
end

d = 0;
for i = 1:n
    if A(i,1) == 0
        continue;
    end

    di = zp_det2(A(setdiff(1:n,i),2:n),p);
    
    di = zp_reduce((-1)^(i+1) * A(i,1) * di, p);
            
    d = zp_reduce(d + di,p);
end

d = zp_reduce(d,p);