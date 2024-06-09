function str = cg_extract_solutions(solv,template,opt)
str = [];

scheme = template.extraction_scheme;
for k = 1:length(scheme)
    str = [str sprintf('sols(%d,:) = %s;\n',scheme{k}.target_idx,cg_parse_scheme(scheme{k}))];
end
if length(scheme) < solv.n_vars
    str = [str sprintf('warning(''TODO: Extract remaining variables.'');\n')];
end

