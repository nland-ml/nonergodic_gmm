function [rmse predictions hyp s2] = runGPProductKernel(XTrain,yTrain,XTest,yTest,numIterations)

    if nargin < 5
        numIterations = 20;
    end

    % remove earthquake IDs
    XTrain = XTrain(:,2:end);
    XTest = XTest(:,2:end);
   
    [covfuncFITC covfuncXT likfunc hyp inf] = getCovarianceFunctions(XTrain);
    
    hyp = optimizeHyperparameters(hyp,inf,covfuncFITC, likfunc, XTrain, yTrain, numIterations);
   
    [predictions s2] = gp(hyp, @infFITC, [], covfuncFITC, likfunc, XTrain, yTrain, XTest);
    rmse = rms(predictions - yTest);
end
 
 