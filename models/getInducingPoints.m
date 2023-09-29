function inducingPoints = getInducingPoints(X, numInducingPoints)
    numInducingPoints = min(numInducingPoints,size(X,1));
    currentSeed = rng;
    rng(1);
    points = X(randperm(size(X,1)),:);
    rng(currentSeed);
    inducingPoints = points(1:numInducingPoints,:);
end