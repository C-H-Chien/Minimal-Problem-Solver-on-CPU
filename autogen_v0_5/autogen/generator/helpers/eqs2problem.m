function problem = eqs2problem(eqs)

problem = @() problem_handle(eqs)

function [eqs,data0,eqs_data] = problem_handle(eqs)
[cc,mm] = polynomials2matrix(eqs);
cc = cc';
ind = find(cc);
data0 = cc(ind);
eqs_data = [];