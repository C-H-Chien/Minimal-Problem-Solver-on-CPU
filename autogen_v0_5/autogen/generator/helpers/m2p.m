function eqs = m2p(cc,mm)

if isa(mm,'multipol')
    mm = monvec2matrix(mm);
end

if isa(cc,'cell') && isa(mm,'cell')
    [m,n] = size(cc);
    assert(all(size(mm) == [m n]));    
    n_vars = size(mm{1},1);
    
    eqs = multipol(0,zeros(n_vars,1))*zeros(m,n);
    for i = 1:m
        for j = 1:n
            eqs(i,j) = m2p(cc{i,j},mm{i,j});
        end
    end
    return;
end

eqs = [];
for k = 1:size(cc,1)
    ind = cc(k,:) ~= 0;
    eqs = [eqs; multipol(cc(k,ind),mm(:,ind))];
end
end