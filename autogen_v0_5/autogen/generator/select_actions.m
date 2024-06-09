function [ actions ] = select_actions( solv, opt )

if opt.use_sym && ~isempty(opt.sym_pp)
    % we need to find monomials which are invariant in the symmetry
   
    % create all polys up to some degree
    deg = opt.sym_max_action_deg;
    mon = monvec(create_upto_degree(deg*ones(solv.n_vars,1),deg));
    % remove 1 as action
    mon = mon(1:end-1);
    
    monv = monvec2matrix(mon);
    
    ok = true(1,size(monv,2));
    for k = 1:size(opt.sym_cc,2)
        ok = ok & (mod(opt.sym_cc(:,k)'*monv,opt.sym_pp(k)) == 0);
    end
    
    actions = mon(ok);    
    if isempty(actions)
        error('No invariant monomials found for this degree. Try to increase sym_max_action_deg.');
    end    
else
    if opt.actions_from_basis;
        actions = solv.basis(:);
        
        % Remove 1 from the actions if it was in the basis
        ind = find_mon_indices(actions,multipol(1,zeros(solv.n_vars,1)));
        if ind ~= -1
            actions(ind) = [];
        end
    else
        actions = create_vars(solv.n_vars);
    end
end

end

