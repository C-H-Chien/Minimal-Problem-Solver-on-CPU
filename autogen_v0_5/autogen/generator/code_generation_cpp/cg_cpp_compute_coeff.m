function str = cg_cpp_compute_coeff(solv, template, opt)
    str = [];
    if opt.generic_coefficients
        str = [str sprintf('VectorXd coeffs = data;\n')];
    else
        coeffs = solv.coefficients.coeff_eqs;
        if opt.optimize_coefficients
            str = [str sprintf('%sconst double* d = data.data();\n',opt.cg_indentation)];
            str = [str sprintf('%sVectorXd coeffs(%d);\n',opt.cg_indentation,length(coeffs))];
            str = [str cg_cpp_optimize_coefficients(coeffs)];
        else
            % Accessing the underlying data directly will significantly
            % improve the compilation time, rather than accessing the
            % elements of the VectorXd data.
            str = [str sprintf('%sconst double* d = data.data();\n',opt.cg_indentation)];
            str = [str sprintf('%sVectorXd coeffs(%d);\n',opt.cg_indentation,length(coeffs))];
            coeff_str = [];
            for k = 1:length(coeffs)
                c = char(coeffs(k),0);
                coeff_str = [coeff_str sprintf('%scoeffs[%d] = %s;\n',opt.cg_indentation,k-1,c)];
            end

            for kk = nvars(coeffs(1)):-1:1
                var_name = sprintf('x%d',kk);
                rep_name = sprintf('d[%d]',kk-1);
                coeff_str = strrep(coeff_str,var_name,rep_name);
            end
            
            % The compiler will optimize away the std::pow calls for low
            % exponents, eg. std::pow(x,2) -> x*x.
            coeff_str = regexprep(coeff_str,'(d\[\d+\])\^(\d+)','std::pow($1,$2)');
            
            str = [str coeff_str sprintf('\n')];
        end
    end
end

