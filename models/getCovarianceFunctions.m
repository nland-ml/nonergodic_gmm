function [covfuncFITC covfuncXT likfunc hyp inf] = getCovarianceFunctions(XTrain,kernelType)

    if nargin < 2
        kernelType = 'Matern1';
    end

    xDimension = size(XTrain,2)-4;
        
    [dependsOnStation dependsOnEq] = getDependencies();
    
    covfunc = createCovarianceFunctionForDimension(xDimension,1,dependsOnStation(1),dependsOnEq(1),kernelType);
    for d = 2:xDimension
        covfunc = {@covSum,{covfunc,createCovarianceFunctionForDimension(xDimension,d,dependsOnStation(d),dependsOnEq(d),kernelType)}};
    end
    
    covfuncXT = covfunc;
    
    numHyperparameters = eval(feval(covfunc{:}));
    hyp.cov = zeros(numHyperparameters,1);
    
    likfunc = @likGauss;  
    hyp.lik = 0;
    
    infWithoutPrior = @infFITC;

    inf = infWithoutPrior;
    covfuncFITC = {@covFITC, covfuncXT, getInducingPoints(XTrain,500)}; 
end