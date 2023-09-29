function [newX newy] = removeFixedCoefficients(X,y)
    % Remove fixed coefficients from X, and add/substract its contribution to y
     load('coefficientInfo.mat');
     
     isFixedCoefficient = ~isnan(coefficientInfo.fixedCoefficients);
     newX = X(:,[~isFixedCoefficient true true true true]);
     contributionFixedCoefficients = X(:,[isFixedCoefficient false false false false])*coefficientInfo.fixedCoefficients(isFixedCoefficient)';
     newy = y - contributionFixedCoefficients;
     save('contributionFixedCoefficients.mat','contributionFixedCoefficients');
end