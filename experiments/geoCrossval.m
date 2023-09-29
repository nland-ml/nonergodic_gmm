function geoCrossval()
    
    initialize();


    frequencies = {'0.010000' '0.020000' '0.050000' '0.100000' '0.200000' '0.500000' '1.000000' '4.000000'}; 
    trainFractions = [1];
    numFolds = 10;

    methods = {'runRidgeRegression' 'runGPProductKernel'};
    
    
    rmse = zeros(length(methods),numFolds,length(trainFractions),length(frequencies));
    numTrainEqs = zeros(length(frequencies),length(trainFractions));
    
    for frequencyIndex = 1:length(frequencies)
        fprintf('\nRunning experiment for frequency = %s',frequencies{frequencyIndex});
        setCoefficientInfo(frequencies{frequencyIndex});
        [X y offset scale] = getCoordinateDataset(frequencies{frequencyIndex});
        for fractionIndex = 1:length(trainFractions)
            fprintf('\n\n\tRunning cross validation for training fraction %f\n',trainFractions(fractionIndex));
            for fold = 1:numFolds
                fprintf('\n\t\tRunning fold %i\n',fold);
                [XTrain yTrain XTest yTest] = getFoldTrainTest(X,y,trainFractions(fractionIndex),numFolds,fold);
                numTrainEqs(frequencyIndex,fractionIndex) = length(unique(XTrain(:,1)));

                for m = 1:length(methods)
                    methodHandle = str2func(methods{m});
                    rmseResult = methodHandle(XTrain,yTrain,XTest,yTest).*scale;
                    fprintf('\t\t%s',methods{m});fprintf(': rmse =  %f\n',[rmseResult]);
                    rmse(m,fold,fractionIndex,frequencyIndex) = rmseResult;
                end
            end
            fprintf('\nFrequency = %s',frequencies{frequencyIndex});
            fprintf(', Train fraction = %f: \n',trainFractions(fractionIndex));
            for m = 1:length(methods)
                fprintf('%s: ',methods{m}); fprintf('RMSE = %f \n',mean(rmse(m,:,fractionIndex,frequencyIndex)));
            end
        end
    end
    save('results.mat','rmse','numTrainEqs','trainFractions','methods','frequencies');
end