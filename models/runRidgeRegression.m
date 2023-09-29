function rmse = runRidgeRegression(XTrain,yTrain,XTest,yTest)

    % remove earthquake IDs
    XTrain = XTrain(:,2:end);
    XTest = XTest(:,2:end);
    
    % remove coordinates
    XTrain = XTrain(:,1:end-4);
    XTest = XTest(:,1:end-4);
    
    epsilon = 0.0000001;
    w = (XTrain'*XTrain+epsilon*eye(size(XTrain,2)))\XTrain'*yTrain;
    
    predictions = XTest*w;
     
    rmse = rms(predictions - yTest);

end
 
 