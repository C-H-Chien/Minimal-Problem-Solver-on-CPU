function [ ind ] = find_mon_indices( mons, target )
if isa(mons,'multipol')
    %ind = arrayfun(@(x) find(mons-target(x)==0,1), 1:length(target),'UniformOutput',0);
    ind = find_mon_indices(monvec2matrix(mons),monvec2matrix(target));
    return;
elseif isa(mons,'double')
    ind = arrayfun(@(x) find(sum(abs(mons-target(:,x)*ones(1,size(mons,2))),1)==0,1), 1:size(target,2),'UniformOutput',0);
end
for k = 1:length(ind)
    if isempty(ind{k})
        ind{k} = -1;
    end
end
ind = cell2mat(ind);
end

