function [predictions uncertainties] = predictionsAtCoordinatesCloseEvents(hyp,covfuncFITC,likfunc,XTrain,xDimension,yTrain,coordinates)

    predictions = zeros(size(coordinates,1),1);
    uncertainties = zeros(size(coordinates,1),1);
    
    numPoints = size(coordinates,1);
        
    X0 = [6*ones(numPoints,1) 10*ones(numPoints,1) 760*ones(numPoints,1) zeros(numPoints,1) coordinates coordinates];
    X = featureRepresentation(X0);
    
    % Compute contribution of constant features
    load('coefficientInfo.mat');
    isFixedCoefficient = ~isnan(coefficientInfo.fixedCoefficients);
    contributionFixedCoefficients = X(:,[isFixedCoefficient false false false false])*coefficientInfo.fixedCoefficients(isFixedCoefficient)';
    
    [X dummy] = removeFixedCoefficients(X,zeros(size(X,1),1));
    [predictions(:,1) uncertainties(:,1)] = gp(hyp, @infFITC, [], covfuncFITC, likfunc, XTrain, yTrain, X);
    predictions(:,1) = predictions(:,1) + contributionFixedCoefficients;
    uncertainties(:,1) = sqrt(uncertainties(:,1))-exp(hyp.lik); %stddev, substracting data noise
    
end