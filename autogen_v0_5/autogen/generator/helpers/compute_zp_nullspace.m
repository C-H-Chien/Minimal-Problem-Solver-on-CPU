function [ N ] = compute_zp_nullspace( M, p )

[xp,N]=zp_linsolve(M,zeros(size(M,1),1),p);

end

