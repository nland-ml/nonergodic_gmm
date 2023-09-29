function W = linearModelAtCoordinates(hyp,covfuncFITC,likfunc,XTrain,xDimension,yTrain,coordinates,whichCoordinates,numPoints)

    if nargin < 9
        numPoints = 100;
    end

    assert(ismember(whichCoordinates,{'eqCoordinates','statCoordinates'}));
	epsilon = 0.0000001;

    W = zeros(size(coordinates,1),xDimension);
    stepsize = 1;
    numSamples = min(numPoints,size(XTrain,1));
    XTrainSubset = XTrain(randsample(size(XTrain,1),numSamples),:);
    X = zeros(0,size(XTrainSubset,2));
    for i = 1:stepsize:size(coordinates,1)
        fixedOtherCoordinates = coordinates(1,:); %need to put any value for other coordinates 
        if strcmp(whichCoordinates,'eqCoordinates')
            X = [X; XTrainSubset(:,1:xDimension) repmat(fixedOtherCoordinates,size(XTrainSubset,1),1) repmat(coordinates(i,:),size(XTrainSubset,1),1)]; 
        else
            X = [X; XTrainSubset(:,1:xDimension) repmat(coordinates(i,:),size(XTrainSubset,1),1) repmat(fixedOtherCoordinates,size(XTrainSubset,1),1)]; 
        end
    end
    y = gp(hyp, @infFITC, [], covfuncFITC, likfunc, XTrain, yTrain, X);
    X = X(:,1:xDimension);
    for i = 1:stepsize:size(coordinates,1)
        X_i = X((i-1)*numSamples+1:i*numSamples,:);
        y_i = y((i-1)*numSamples+1:i*numSamples,:);
        W(i,:) = (X_i'*X_i+epsilon*eye(size(X_i,2)))\X_i'*y_i;
        
        % check that model indeed linear at this point
        yCheck = X_i*W(i,:)';
        diff = abs(yCheck-y_i);
        if max(diff)>0.001
            fprintf('ERROR: linearity check failed in plotParameters\n');
        end
        assert(max(diff)<0.001);
    end
end