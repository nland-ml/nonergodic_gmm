function hyp = optimizeHyperparameters(hyp,inf,covfuncFITC, likfunc, XTrain, yTrain, numIterations)
    
    if nargin < 7
        numIterations = 20;
    end

    fprintf('\n\t\tGPProductKernel: Optimizing hyperparameters... ');
    fprintf([datestr(clock()) '\n']);

    marginal = -1;
    [hyp marginal] = minimize(hyp, @gp, numIterations, inf, [], covfuncFITC, likfunc, XTrain, yTrain);    
 
    fprintf('done. LL = %f, parameter = ',marginal(end));fprintf('%f ',hyp.cov);fprintf('\n');
    fprintf('\n exp(hyp.lik) = %f\n',exp(hyp.lik));
    fprintf([datestr(clock()) '\n']);

end