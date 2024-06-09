function [ template ] = remove_extra_columns( template, solv )

fprintf('Removing extra columns ... ');

opt = solv.opt;
CC0 = [];
%CC1 = [];

coeff_eqs = solv.coefficients.coeff_eqs;

for k = 1:length(solv.eqs_zp)
    % TODO: Take coefficients directly from equations instead
    coeffs = zp_evaluate(coeff_eqs,solv.eqs_zp_data0(:,k),opt.prime_field);

    % get rid of complex coefficients
    if opt.transform_C_to_Zp
        coeffs = transform_C_to_Zp(coeffs,opt.prime_field);
    end

    C = zeros(template.C_sz);
    C(template.C_ind) = coeffs(template.C_coeff);
    CC0 = [CC0; C(:,1:template.C_sz(2)-length(template.basis))];
%    CC1 = [CC1; C(:,template.C_sz(2)-length(template.basis)+1:end)];
end

[~,ind,rind] = zp_rref(CC0,opt.prime_field);
rind = rind(1:length(ind));

% add indices for C1
ind = [ind size(CC0,2)+1:size(CC0,2)+length(template.basis)];

% make sure we keep the reducible
red_ind = size(CC0,2)-length(template.reducible)+1 : size(CC0,2);

if ~(all(ismember(red_ind,ind)))
    warning('Something is strange. Maybe try another problem instance.');
    ind = union(ind,red_ind);
end

C = zeros(template.C_sz);
C(template.C_ind) = template.C_coeff;
if opt.remove_extra_rows && length(solv.eqs_zp) == 1 % only works for single instance
    C = C(rind,ind);
else
    C = C(:,ind);
end
template.mm = template.mm(ind);
fprintf('[%d,%d] -> ',template.C_sz);
template.C_sz = size(C);
template.C_ind = find(C);
template.C_coeff = C(template.C_ind);
[i,j] = find(C);
template.C_ind2 = [i j];
fprintf('[%d,%d]\n',template.C_sz);

% Indices for template parts C = [C0 C1]
% TODO: refactor this out
C0 = C(:,1:size(C,2)-length(template.basis));
C1 = C(:,size(C,2)-length(template.basis)+1:end);
template.C0_sz = size(C0);
template.C1_sz = size(C1);
template.C0_ind = find(C0);
template.C1_ind = find(C1);
[ii,jj] = find(C0);
template.C0_ind2 = [ii jj];
[ii,jj] = find(C1);
template.C1_ind2 = [ii jj];
template.C0_coeff = C0(template.C0_ind);
template.C1_coeff = C1(template.C1_ind);

end

