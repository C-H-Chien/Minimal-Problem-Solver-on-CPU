function [ result ] = benchmark_solver( solv_fun, problem, iters, discard_zero_sol )

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

for iters = 1:iters
    data = randn(size(data));
    
    try
        eqs = problem(data);
        tic
        sols = solv_fun(data);
        tt = toc;
    catch
        result.failures = result.failures + 1;
        continue;
    end

    result.time_taken(end+1) = tt;    

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

