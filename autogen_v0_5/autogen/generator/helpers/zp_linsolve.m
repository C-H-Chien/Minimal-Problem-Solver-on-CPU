function [xp,xh]=zp_linsolve(A,b,zp,ik)
% Solves the linear equation system Ax=b
% with entries in Z_p = Z/(pZ)
% assumes prime p, so that Zp is a field
%
if nargin < 3
    zp = 30097;
end
if nargin < 4,
    if zp == 30097
        % load precomputed inverses
        load([fileparts(mfilename('fullpath')) filesep 'zp_linsolve_ik30097.mat']);
    else
        % calculate inverses
        ik = zeros(1,zp-1);
        for k = 1:(zp-1);
            mm = mod(k*(1:(zp-1)),zp);
            ik(k)=find(mm==1);
        end
    end
end;

% Perform Gaussian elimination
A = mod(A,zp);
b = mod(b,zp);
[m,n]=size(A);
AA = zeros(0,n);
bb = zeros(0,1);
ki = 0;
pivpos = [];
pivcol = zeros(1,n);
for col = 1:n;
    ii = find(A(:,col));
    if ~isempty(ii),
        pivot = A(ii(1),col);
        pivrow = A(ii(1),:);
        pivrow = mod(pivrow*ik(pivot),zp);
        pivb = mod(b(ii(1))*ik(pivot),zp);
        ki = ki+1;
        pivpos(ki)=col;
        pivcol(col)=ki;
        AA(ki,:)=pivrow;
        bb(ki,1)=pivb;
        A(ii(1),:)=[];
        b(ii(1))=[];
        if size(A,1)>0,
            b = mod(b-A(:,col)*pivb,zp);
            A = mod(A-A(:,col)*pivrow,zp);
        end
    end
end
if size(A,1)>0,
    AA = [AA;A];
    bb = [bb;b];
end;

% Kolla att det inte finns n�gra mots�gelser.
%sum(sum(A))
%sum(sum(b))
if sum(b)>0,
    xp = NaN;
    xh = NaN;
    sols = zeros(size(A,2),0);
else
    % Perform backsubstitution
    AAA = AA;
    bbb = bb;
    xh = zeros(n,n-length(pivpos));
    xp = zeros(n,1);
    ni = 0;
    for kk = n:(-1):1;
        if pivcol(kk)>0,
            % OK to determine this element
            xp(kk) = mod(bbb(pivcol(kk))*ik(AAA(pivcol(kk),kk)),zp);
            if ni>0,
                if kk<n,
                    xh(kk,1:ni) = mod( -AAA(pivcol(kk),(kk+1):n)*xh((kk+1):n,1:ni) ,zp);
                end;
            end
            if pivcol(kk)>1,
                bbb = mod(bbb(1:(pivcol(kk)-1)) - xp(kk)*AAA(1:(pivcol(kk)-1),kk),zp);
            end
        else
            % Introduce a new parameter
            ni = ni+1;
            xh(kk,ni)=1;
        end
    end
    
%     if size(xh,2)>0,
%         sols = xh*genall(zp,size(xh,2));
%         sols = sols + repmat(xp,1,size(sols,2));
%         sols = mod(sols,zp);
%     else
%         sols = xp;
%     end
end;


% function sols = genall(n,ndim);
% 
% if ndim>0,
%     sols = 1:n;
%     if ndim>1,
%         for k = 2:ndim;
%             sols = [repmat(1:n,1,size(sols,2)); kron(sols,ones(1,n))];
%         end
%     end
% else
%     sols = [];
% end
% 
