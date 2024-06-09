function str = cg_compute_coeff(solv, template, opt)
    str = sprintf('function [coeffs] = compute_coeffs(data)\n');
    
    if opt.generic_coefficients
        str = [str sprintf('coeffs = data;\n')];
    else
        coeffs = solv.coefficients.coeff_eqs;
        if opt.optimize_coefficients
            str = [str cg_optimize_coefficients(coeffs)];
        else
            coeff_str = [];
            for k = 1:length(coeffs)
                c = char(coeffs(k),0);
                coeff_str = [coeff_str sprintf('coeffs(%d) = %s;\n',k,c)];
            end

            for kk = nvars(coeffs(1)):-1:1
                var_name = sprintf('x%d',kk);
                rep_name = sprintf('data(%d)',kk);
                coeff_str = strrep(coeff_str,var_name,rep_name);
            end
            str = [str coeff_str];
        end
    end
end

