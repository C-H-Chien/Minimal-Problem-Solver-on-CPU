function [ opt, solv ] = validate_options( opt, solv )
% TODO fix this
if ~isempty(opt.saturate_mon)
    if isa(opt.saturate_mon,'double')
        if length(opt.saturate_mon) == 1
            ek = zeros(opt.saturate_mon,1); ek(opt.saturate_mon) = 1;
            opt.saturate_mon = multipol(1,ek);
        else
            opt.saturate_mon = multipol(1,opt.saturate_mon);
        end
    end
end
if ~isempty(opt.custom_basis)
    if isa(opt.custom_basis,'double')
        opt.custom_basis = monvec(multipol(ones(1,size(opt.custom_basis,2)),opt.custom_basis));
    end
end

if ~isempty(opt.actmon)
    if isa(opt.actmon,'double')
        if size(opt.actmon,1) == 1
            k = opt.actmon;
            tmp = zeros(solv.n_vars,1);
            tmp(k) = 1;
            opt.actmon = multipol(1,tmp);
        else
            opt.actmon = multipol(1,opt.actmon);
        end
    end
end

if ~isempty(opt.custom_basis)
    opt.custom_basis = opt.custom_basis(:)';
end

 if ~strcmp(class(opt.extra_reducible),'multipol')
        % TODO fix this
        tmp = [];
        for k = 1:size(opt.extra_reducible,2)
            tmp = [tmp multipol(1,opt.extra_reducible(:,k))];
        end
        opt.extra_reducible = tmp;
    end

end

