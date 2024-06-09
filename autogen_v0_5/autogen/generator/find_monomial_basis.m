function [ basis ] = find_monomial_basis( eqs, opt, id )

if nargin < 3 || isempty(id)
    id = num2str(feature('getpid'));
end


fname = ['testxx.'  id '.m2'];

if exist(fname,'file');
    delete(fname);
end

if ~exist('./cache','dir')
    mkdir('cache')
end

fname_b = ['cache/basis.' id '.txt'];


[C M] = polynomials2matrix(eqs);
C = round(C);
eqs = C*M;

header = generate_ring_header( nvars(eqs(1)), opt );

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

if isempty(opt.saturate_mon)
    fprintf(fid,'Q = R/I;\n');
    fprintf(fid,'b = basis Q;\n');
else
    fprintf(fid,'satmon = %s\n',char(opt.saturate_mon,0));
    fprintf(fid,'J = saturate(I,satmon);\n');
    fprintf(fid,'Q = R/J;\n');
    fprintf(fid,'b = basis Q;\n');
end

fprintf(fid,'%s\n',[' "' fname_b '" << toString b << close']);
fprintf(fid,'quit();\n');
fclose(fid);

eval(['! ' opt.M2_path ' ' fname '']);
while ~exist(fname_b,'file'),
    pause(1);
end


% read result
basis = readM2matrix(fname_b, nvars(eqs(1)));

if exist(fname,'file')
    delete(fname)
end