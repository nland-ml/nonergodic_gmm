function [data] = unnormalize(normalized,offset,scale)
   data = normalized*scale+offset;
end