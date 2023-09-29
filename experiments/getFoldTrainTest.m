function [XTrain yTrain XTest yTest] = getFoldTrainTest(X,y,trainFraction,numFolds,fold)

    eqIds = unique(X(:,1));

    seed = rng;
    rng(1);
    eqIds = eqIds(randperm(length(eqIds)));
    rng(seed);
    
    testIds = eqIds(find(mod(1:length(eqIds),numFolds)==fold-1));
    trainIds = setdiff(eqIds,testIds);
    trainIds = trainIds(1:round(trainFraction*length(trainIds)));
    
    XTrain = X(ismember(X(:,1),trainIds),:);
    yTrain = y(ismember(X(:,1),trainIds),:);
    
    XTest = X(ismember(X(:,1),testIds),:);
    yTest = y(ismember(X(:,1),testIds),:);

end