function [normalized] = renormalize(data,offset,scale)
   normalized = (data-offset)/scale;
end