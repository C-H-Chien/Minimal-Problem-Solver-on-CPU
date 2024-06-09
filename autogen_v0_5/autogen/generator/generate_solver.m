function [solv,opt] = generate_solver(solv_name,problem,opt)

if nargin < 2
    opt = [];
end

if isa(problem,'multipol')
    problem = eqs2problem(problem);
end

solv = struct();
solv.name = solv_name;
solv.problem = problem;
solv.opt = opt;

% Set default options and validate them
opt = default_options(opt);

% Create integer instances of the equations
eqs_zp = cell(1,opt.integer_expansions);
eqs_zp_data0 = [];
for k = 1:opt.integer_expansions;
    if ~isempty(opt.custom_data) && size(opt.custom_data,2) >= k
        [eqs_zp{k},eqs_zp_data0(:,k)] = problem(opt.custom_data(:,k));
    else
        [eqs_zp{k},eqs_zp_data0(:,k)] = problem();
    end
    if opt.transform_C_to_Zp
        eqs_zp{k} = transform_C_to_Zp(eqs_zp{k},opt.prime_field);
    end
end
solv.eqs_zp = eqs_zp;
solv.eqs_zp_data0 = eqs_zp_data0;
solv.n_vars = max(nvars(eqs_zp{1}));
solv.n_eqs = length(eqs_zp{1});
[opt,solv] = validate_options(opt,solv);



%%
fprintf('-------------------------------------------------\n');
fprintf('generate_solver (%s, %d equations in %d variables)\n',solv_name,solv.n_eqs,solv.n_vars);


%% Check for symmetries in the problem

if opt.find_sym
    fprintf('Checking for symmetry. max_p = %d\n',opt.sym_max_p);
    
    [opt.sym_cc,opt.sym_pp] = find_symmetries(solv.eqs_zp{1},opt.sym_max_p);
    
    fprintf('Found %d symmetries.\n',length(opt.sym_pp));
    for k = 1:length(opt.sym_pp)
        fprintf('\tc = [ ');
        fprintf('%d ',opt.sym_cc(:,k));
        fprintf('],\tp = %d\n',opt.sym_pp(k));
    end
end

%% Compute monomial basis for quotient space
if isempty(opt.custom_basis)
    solv.basis = find_monomial_basis(eqs_zp{1},opt,solv_name);
else
    solv.basis = opt.custom_basis;
    fprintf('Using custom basis for quotient space.\n');
end
solv.n_sol = length(solv.basis);

fprintf('Problem has (at most) %d solutions.\n',solv.n_sol);
fprintf('Quotient ring basis (degree = %d)\n',length(solv.basis));
fprintf('\tB = [ ');
for k = 1:length(solv.basis)
    fprintf('%s ',char(solv.basis(k),0));
end
fprintf(']\n');

%% Remove zero solution
if opt.remove_zero_sol && ...
        norm(evaluate(solv.eqs_zp{1},zeros(solv.n_vars,1))) == 0
    
    fprintf('Removing zero solution.\n');
    
    % try to remove constant from quotient basis
    % (it must be independent from the rest since zero is in variety)
    i = find(solv.basis == multipol(1));
    if ~isempty(i)
        solv.basis(i) = [];
    end
end



%% Select action monomial

if isempty(opt.actmon)
    solv.actions = select_actions(solv,opt);
else
    solv.actions = opt.actmon;
end
fprintf('Action monomial = [ ');
for k = 1:length(solv.actions)
    fprintf('%s ',char(solv.actions(k),0));
end
fprintf(']\n');


if opt.use_sym
    % make sure action monomial is invariant
    for i = 1:length(solv.actions)
        for k = 1:length(opt.sym_pp)
            if mod(opt.sym_cc(:,k)'*monomials(solv.actions(i)),opt.sym_pp(k))~=0
                error('Action monomial must be invariant under the symmetry!');
            end
        end
    end
end


%% Select monomials to reduce

solv.reducible = [];
for k = 1:length(solv.actions)
    solv.reducible = [solv.reducible solv.actions(k)*solv.basis];
end
if opt.force_vars_in_reducibles
    solv.reducible = unique([solv.reducible create_vars(solv.n_vars)']);
end
if ~isempty(opt.extra_reducible)
    solv.reducible = unique([solv.reducible opt.extra_reducible]);
end

% remove basis elements
solv.reducible(ismember(monvec2matrix(solv.reducible)',monvec2matrix(solv.basis)','rows')) = [];

fprintf('Monomials to reduce: (%d monomials)\n',length(solv.reducible));
fprintf('\tR = [ ');
for k = 1:length(solv.reducible)
    fprintf('%s ',char(solv.reducible(k),0));
end
fprintf(']\n');

%%




%% Generate monomial expansion

solv.templates = initialize_templates(solv,opt);

fprintf('Finding elimination templates ... ');
As = cell(1,length(eqs_zp));
for k = 1:length(eqs_zp)
    id = [solv_name '.' num2str(k)];
    [As{k},opt] = find_template(eqs_zp{k},solv,opt,id);
end
fprintf('OK\n');

% merge expansions
A = cell(size(As{1}));
for k = 1:numel(A)
    tmp = cellfun(@(x) x{k},As,'UniformOutput',0);
    A{k} = cat(2,tmp{:});
    A{k} = -unique(-A{k}','rows')';
end


solv = build_templates(A,solv,opt);


%%


% Select which templates to construct solvers from
if opt.build_all_templates
    solv.target_template = true(length(solv.templates),1);
else
    % only build best template
    [~,template_ind] = sortrows([cellfun(@(x) x.sz, solv.templates);cellfun(@(x) length(x.reducible), solv.templates)]');    
    solv.target_template = false(length(solv.templates),1);
    solv.target_template(template_ind(1)) = 1;
end

% Print results
fprintf('Found %d elimination templates.\n',length(solv.templates));
desc_len = max(cellfun(@(x) length(x.desc),solv.templates));
fmt = ['%s %-' num2str(desc_len+1) 's - %- 4d rows, %- 2d basis, %- 2d reducible, %s\n'];
extra = '';
for k = 1:length(solv.templates)
    if solv.target_template(k), build_mark = '*'; else build_mark = ' '; end
    if ~isempty(opt.saturate_mon), extra = sprintf('N = %d',solv.templates{k}.saturate_degree);end

    fprintf(fmt,build_mark,solv.templates{k}.desc,solv.templates{k}.sz,...
        length(solv.templates{k}.basis),length(solv.templates{k}.reducible),extra);
end

if opt.stop_after_template
    return;
end


%% Compute coefficients
fprintf('Extracting template coefficients... ');
solv.coefficients = compute_coefficients(problem,solv,opt);
fprintf('OK (%d found)\n',length(solv.coefficients.coeff_eqs));



for tk = find(solv.target_template)'
    fprintf('Building solver (%s_%s)\n',solv_name,solv.templates{tk}.desc);   
       
    tic
    solv.templates{tk} = finalize_template(solv,solv.templates{tk}, opt);
    tt = toc;

    fprintf('Elimination template size = [%d,%d], nnz = %d\n',solv.templates{tk}.C_sz,length(solv.templates{tk}.C_ind));

    if opt.remove_extra_columns
        solv.templates{tk} = remove_extra_columns(solv.templates{tk}, solv);
    end


    if opt.build_all_templates
        name = [solv_name '_' solv.templates{tk}.desc];
    else
        name = solv_name;
    end
    
    if strcmp(opt.cg_language,'matlab')
        solv.templates{tk} = generate_code(name,solv,solv.templates{tk},opt);
    elseif strcmp(opt.cg_language,'cpp_eigen') || strcmp(opt.cg_language,'cpp')
        solv.templates{tk} = generate_code_cpp(name,solv,solv.templates{tk},opt);
    else
        error('Unknown output language');
    end
end

return




