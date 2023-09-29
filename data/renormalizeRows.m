function [normalized] = renormalizeRows(data,offsets,scales)
    normalized = zeros(size(data));
    for i = 1:size(data,2)
       normalized(:,i) = renormalize(data(:,i),offsets(i),scales(i));
    end
end