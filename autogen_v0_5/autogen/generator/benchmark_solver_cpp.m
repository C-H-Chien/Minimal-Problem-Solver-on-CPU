function [ result ] = benchmark_solver_cpp( solv_fun, problem, iters, discard_zero_sol )
% Same as benchmark_solver but we provide solver with multiple instances to
% offset mex-call overhead
if nargin < 3
    iters = 10;
end

if nargin < 4
    discard_zero_sol = 1;
end

result = [];

result.all_res = [];
result.failures = 0;
result.time_taken = [];

% Hack to figure out how large the data is
% TODO make better choices in design (and life)
[~,data,~] = problem();
n_data = numel(data);

data_all = [];

for iter = 1:iters
    data = randn(size(data));
    data_all = [data_all; data(:)];
end

tic;
sols_all = solv_fun(data_all);
tt = toc;
result.time_taken = tt / iters;
n_sols = size(sols_all,2) / iters;
for iter = 1:iters
    sols = sols_all(:,n_sols*(iter-1)+1:n_sols*iter);
    
    data = data_all(n_data*(iter-1)+1:n_data*iter);
    eqs = problem(data);
    
    if discard_zero_sol
        sols = sols(:,max(abs(sols))>1e-10);
    end
    
    % We measure maximum equation residual
    res = [];
    for k = 1:size(sols,2)
        res = [res max(abs(evaluate(eqs,sols(:,k))))];
    end
    
    result.all_res = [result.all_res res];
end
result.res_mean = mean(log10(result.all_res));
result.res_median = median(log10(result.all_res));
[hh,bb]=hist(log10(result.all_res),20);
[~,idde]=max(hh);
result.res_mode = bb(idde);

end

