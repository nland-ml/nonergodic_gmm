function Z = featureRepresentation(X)
    
    useMSquare = true;
    usePseudoDepth = true;
    useSplitSOF = true;
    useMagnitudeRJBTerm = true;

    X(:,3) = log(X(:,3));         % logarithmic VS30
    
    if useSplitSOF
         X = [X(:,1:3) X(:,4)==1 X(:,4)==-1 X(:,5:end)];
    end
    if usePseudoDepth
        h = 6;
%        X(:,2) = sqrt(X(:,2).^2+h^2);
        if useMagnitudeRJBTerm
            X = [X(:,1) log(sqrt(X(:,2).^2+h^2)) log(sqrt(X(:,2).^2+h^2)).*X(:,1) X(:,2) X(:,3:end)];
        else
            X = [X(:,1) log(sqrt(X(:,2).^2+h^2)) X(:,2) X(:,3:end)];
        end
    end
    if useMSquare 
        X = [X(:,1) X(:,1).^2 X(:,2:end)];
    end
    
    %X = [X(:,1:end-4) ones(size(X,1),1) X(:,end-3:end)]; %version with one constant attribute 
    X = [X(:,1:end-4) ones(size(X,1),2) X(:,end-3:end)]; %version with two constant attributes 
    
    Z = X;
end
