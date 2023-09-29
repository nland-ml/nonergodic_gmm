function [normalized offsets scales] = normalizeRows(data)
    normalized = zeros(size(data));
    for i = 1:size(data,2)
       [normalized(:,i) offsets(1,i) scales(1,i)] = normalize(data(:,i));
    end
end