function mx = zp_evaluate(m,x,zp);
if nargin < 3
    zp = 30097;
end

% TODO: stop using multipol and use something which handles Zp stuff...

sz = size(m);
m = m(:);

m = zp_reduce(m,zp);
x = zp_reduce(x,zp);


[cc,mm] = polynomials2matrix(m);

mmv = monvec2matrix(mm);
degs = max(mmv,[],2);

% compute powers mod p
xp = {};
for k = 1:length(x)
    xp{k} = x(k);
    for i = 2:degs(k);
        xp{k}(end+1) = zp_reduce(xp{k}(end) * x(k),zp);
    end
end

mmx = [];

for k = 1:length(mm)
    mk = 1;
    for i = 1:size(mmv,1)
        if mmv(i,k) > 0
            mk = zp_reduce(mk * xp{i}(mmv(i,k)),zp);
        end
    end
    mmx = [mmx; mk];
end

mx = [];
for i = 1:size(cc,1)
    mx_i = 0;
    for j = 1:size(cc,2);
        mx_i = zp_reduce(mx_i + cc(i,j)*mmx(j),zp);
    end
    mx = [mx; mx_i];
end

mx = reshape(mx,sz);