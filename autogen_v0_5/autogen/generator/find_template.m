function [ A, opt ] = find_template( eqs, solv, opt, id )

if nargin < 4 || isempty(id)
    id = num2str(feature('getpid'));
end

basis = solv.basis;
reducible = solv.reducible;

fname = ['testxx.'  id '.m2'];

if exist(fname,'file');
    delete(fname);
end

if ~exist('./cache','dir')
    mkdir('cache')
end

fname_A = ['cache/matrix.' id '.txt'];



fid = fopen(fname,'w');

header = generate_ring_header( nvars(eqs(1)), opt );
fprintf(fid,header);

redstr = '';
for i=1:length(reducible)
    redstr = [redstr sprintf('%s,',char(reducible(i),0))];
end
fprintf(fid,'red = matrix({{%s}});\n',redstr(1:end-1));

basisstr = '';
for i=1:length(basis)
    % _R here is a workaround the case when b = {1}
    basisstr = [basisstr sprintf('%s_R,',char(basis(i),0))];
end
fprintf(fid,'b = matrix({{%s}});\n',basisstr(1:end-1));


eqname = '';
for i=1:length(eqs)
    fprintf(fid,'eq%u = %s\n',i,char(eqs(i),0));
    eqname = [eqname sprintf('eq%u,',i)]; %#ok
end

fprintf(fid,'eqs = matrix({{%s}});\n',eqname(1:end-1));
fprintf(fid,'I = ideal eqs;\n');
fprintf(fid,'gbTrace = %d;\n',opt.M2_gbTrace);    

if ~isempty(opt.saturate_mon)
    fprintf(fid,'I0 = I;\n');
    fprintf(fid,'satmon = %s;\n',char(opt.saturate_mon,0));
    fprintf(fid,'I = saturate(I0,satmon);\n');
end

% Find normal set
fprintf(fid,'Q = R/I;\nb0 = lift(basis Q,R);\nuse R\n');

% Express basis in normal set
fprintf(fid,'S = (coefficients(b%%I,Monomials => b0))_1;\n');

fprintf(fid,'if numcols b0 <= numcols b then (\n');
fprintf(fid,'  Sinv = transpose(S)*inverse(S*transpose(S));\n');
fprintf(fid,') else (\n');
fprintf(fid,'  Sinv = inverse(transpose(S)*S)*transpose(S);\n');
fprintf(fid,')\n');

% Construct action matrix
fprintf(fid,'AM = Sinv*((coefficients(red%%I,Monomials => b0))_1);\n');

% Construct target polynomials
fprintf(fid,'pp = red - b*AM;\n');

if ~isempty(opt.saturate_mon)  
    % Find N which lifts target polynomials into the original ideal    
    fprintf(fid,'degs = matrix({apply((entries pp)_0,p->(N=0;while(satmon^N*p %% I0 != 0) do (N=N+1);N))});\n');
    fprintf(fid,'pp = matrix({toList apply(0..numcols pp-1, i->satmon^(degs_(0,i))*pp_(0,i))});\n');
    fname_sat = [ 'cache/saturate_degree.' id '.txt'];        
    fprintf(fid,'%s\n',[' "' fname_sat '" << toString degs << close;']);
end

% Express target polynomials in the generators
fprintf(fid,'A = pp // eqs;\n');

fprintf(fid,'gbRemove(I);\n');


if opt.syzygy_reduction
    fprintf(fid,'M = kernel eqs;\n');
    fprintf(fid,'A = A %% M;\n');        
end

fprintf(fid,'%s\n',[' "' fname_A '" << toString A << close;']);

fprintf(fid,'quit();\n');
fclose(fid);

eval(['! ' opt.M2_path ' ' fname '']);
while ~exist(fname_A,'file'),
    pause(1);
end


% read result
if opt.fast_monomial_extraction
    A = extract_monomials(fname_A,length(eqs),length(reducible),nvars(eqs(1)));
else
    AA = readM2matrix(fname_A, nvars(eqs(1)));
    A = cell(size(AA));
    for k = 1:numel(A)
        [C,mon] = polynomials2matrix(AA(k));
        if C ~= 0
            A{k} = monvec2matrix(mon);
        else
            A{k} = zeros(nvars(eqs(1)),0);
        end
    end
end

if exist(fname,'file')
    delete(fname)
end


if ~isempty(opt.saturate_mon) && exist(fname_sat,'file')    
    opt.saturate_degree = readM2matrix(fname_sat,0);        
    delete(fname_sat);
end






end
