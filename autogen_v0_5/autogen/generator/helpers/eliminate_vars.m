function [ eqs_elim ] = eliminate_vars( eqs, elim_vars, opt, id )
%ELIMINATE_VARS Computes the elimination ideal containing
%only the first NBR of variables.
%
% Implements the first method of
% http://www2.macaulay2.com/Macaulay2/share/doc/Macaulay2/Macaulay2Doc/html/_elimination_spof_spvariables.html

if isa(elim_vars, 'multipol')
    elim_vars = find(any(monvec2matrix(elim_vars),2));
elseif isnumeric(elim_vars)
else
    error('Unsupported type.')
end

if nargin < 3 || isempty(opt)
    opt = default_options();
end

if nargin < 4 || isempty(id)
    id = num2str(feature('getpid'));
end


fname = ['test_eliminate_vars.'  id '.m2'];

if exist(fname,'file')
    delete(fname);
end

if ~exist('cache','dir')
    mkdir('cache')
end

fname_result = ['cache/eliminate_vars.' id '.txt'];

[C, M] = polynomials2matrix(eqs);
C = round(C);
eqs = C*M;

header = generate_ring_header( max(nvars(eqs)), opt );

fid = fopen(fname,'w');
fprintf(fid,header);    

eqname = '';
for i=1:length(eqs)
    fprintf(fid,'eq%u = %s\n',i,char(eqs(i),0));
    eqname = [eqname sprintf('eq%u,',i)]; %#ok
end

fprintf(fid,'eqs = {%s}\n',eqname(1:end-1));
fprintf(fid,'I = ideal eqs;\n');   
fprintf(fid,'gbTrace = %d;\n',opt.M2_gbTrace);    


if ~isempty(opt.saturate_mon)
    if isa(opt.saturate_mon,'double')
        if length(opt.saturate_mon) == 1
            ek = zeros(max(nvars(eqs)),1);
            ek(opt.saturate_mon) = 1;
            opt.saturate_mon = ek;
        end

        opt.saturate_mon = multipol(1,opt.saturate_mon);
    end
    fprintf(fid,'I = saturate(I,%s);\n',char(opt.saturate_mon,0));
end

if ~isempty(elim_vars)
    varstr = '';
    for i=elim_vars
        varstr = [varstr sprintf('x%u,',i)];
    end
    fprintf(fid,'I = eliminate(I,{%s});\n',varstr(1:end-1));     
end    

fprintf(fid,'%s\n',[' "' fname_result '" << toString gens I << close']);
fprintf(fid,'quit();\n');
fclose(fid);

eval(['! ' opt.M2_path ' ' fname '']);
while ~exist(fname_result,'file')
    pause(1);
end

% read result
if opt.fast_monomial_extraction
    [C,M] = extract_polynomials(fname_result',max(nvars(eqs)));
    eqs_elim = m2p(C,M);
    eqs_elim = sort(eqs_elim);
else
    eqs_elim = readM2matrix(fname_result, max(nvars(eqs)));
end

if exist(fname,'file')
    delete(fname)    
end
if exist(fname_result,'file')
    delete(fname_result)
end

