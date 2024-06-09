function [ coefficients ] = compute_coefficients( problem, solv, opt )

generic_coeffs = opt.generic_coefficients;

if ~generic_coeffs
    if ~isempty(opt.custom_data)
        % Handles problems where number of equations depend on input data
        [eqs,~,eqs_data] = problem(opt.custom_data(:,1));
    else
        [eqs,~,eqs_data] = problem();
    end
    if isempty(eqs_data)
        fprintf('Problem file does not provide polynomials in both unknowns and data.\n');
        generic_coeffs = 1;
    end
end

if generic_coeffs
    fprintf('Using generic coefficients.\n');

    eqs = solv.eqs_zp{1};
    [cc,mm] = polynomials2matrix(eqs);
    cc = cc';
    ind = find(cc);
    cc(ind) = 1:length(ind);    
    cc = cc';
    ind_eqs = cc*mm;
    coeff_eqs = create_vars(length(ind));
else
    coeff_eqs = [];
    ind_eqs = [];

    for k = 1:solv.n_eqs
        [~,mm] = polynomials2matrix(eqs(k));
        A = collect_terms(eqs_data(k),mm);
        % TODO: save equation coefficients as well
        ind = length(coeff_eqs)+1:length(coeff_eqs)+length(A);
        ind_eqs = [ind_eqs; ind*mm];
        coeff_eqs = [coeff_eqs A];
    end
    coeff_eqs = remove_vars(coeff_eqs,1:solv.n_vars);
end

coefficients.coeff_eqs = coeff_eqs;
coefficients.ind_eqs = ind_eqs;
coefficients = prune_duplicate(coefficients);
end

function coefficients = prune_duplicate(coefficients)
[c,ia,ic] = unique(coefficients.coeff_eqs);
if length(c) == coefficients.coeff_eqs
    return;
end

% update indices
for k = 1:length(coefficients.ind_eqs)
    [cc,mm] = polynomials2matrix(coefficients.ind_eqs(k));
    coefficients.ind_eqs(k) = m2p(ic(cc),mm);
end
coefficients.coeff_eqs = c;
end
