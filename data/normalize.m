function [normalized offset scale] = normalize(data)
    offset = mean(data);
%    scale = max(data)-min(data)+0.001;
    scale = std(data)+ 0.00001;
    normalized = (data-offset)/scale;
end