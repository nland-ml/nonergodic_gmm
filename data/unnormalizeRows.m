function [data] = unnormalizeRows(normalized,offsets,scales)
    data = zeros(size(normalized));
    for i = 1:size(normalized,2)
       data(:,i) = unnormalize(normalized(:,i),offsets(i),scales(i));
    end
end