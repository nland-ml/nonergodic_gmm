function [predictions uncertainties] = predictionsAtCoordinates(hyp,covfuncFITC,likfunc,XTrain,xDimension,yTrain,coordinates,uncertaintyMapTargets)

    predictions = zeros(size(coordinates,1),size(uncertaintyMapTargets,1));
    uncertainties = zeros(size(coordinates,1),size(uncertaintyMapTargets,1));
    
    for i = 1:size(uncertaintyMapTargets,1)
        numPoints = size(coordinates,1);
        stationCoordinates = repmat(uncertaintyMapTargets(i,:),numPoints,1);
        R = zeros(numPoints,1);
        for j = 1:numPoints
            [d1km d2km]=lldistkm(stationCoordinates(j,:),coordinates(j,:));
            R(j) = d1km;
        end
        %R = sqrt(sum((stationCoordinates-coordinates).^2,2));
        
        X0 = [6*ones(numPoints,1) R 760*ones(numPoints,1) zeros(numPoints,1) coordinates stationCoordinates];
        X = featureRepresentation(X0);
        
        % Compute contribution of constant features
        load('coefficientInfo.mat');
        isFixedCoefficient = ~isnan(coefficientInfo.fixedCoefficients);
        contributionFixedCoefficients = X(:,[isFixedCoefficient false false false false])*coefficientInfo.fixedCoefficients(isFixedCoefficient)';
        
        [X dummy] = removeFixedCoefficients(X,zeros(size(X,1),1));
        [predictions(:,i) uncertainties(:,i)] = gp(hyp, @infFITC, [], covfuncFITC, likfunc, XTrain, yTrain, X);
        predictions(:,i) = predictions(:,i) + contributionFixedCoefficients;
        uncertainties(:,i) = sqrt(uncertainties(:,i))-exp(hyp.lik); %stddev, substracting data noise
    end


end