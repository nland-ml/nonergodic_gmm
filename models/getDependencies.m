function  [dependsOnStation dependsOnEq] = getDependencies()
    % Version without MRJB term
    %dependsOnStation = [0 0 0 0 1 0 0 1];   % without mixed M,RJB Term
    
    % Version with MRJB term, all coefficients vary
    %dependsOnStation = [0 0 0 0 0 1 0 0 1]; % with mixed M,RJB Term
    %dependsOnEq = 1 - dependsOnStation;
    
    % Version with MRJB term, some coefficients fixed (Nicos mail 11.07.)
    %dependsOnStation = [0 0 0 0 0 1 0 0 1]; % with mixed M,RJB Term
    %dependsOnEq =      [0 0 1 0 1 0 0 0 0];

    
    % CURRENT: Version with MRJB term, some coefficients fixed, two constant attributes to have random effect for both coordinates
    %dependsOnStation = [0 0 0 0 0 1 0 0 1 0]; 
    %dependsOnEq =      [0 0 1 0 1 0 0 0 0 1];
    
    load('coefficientInfo.mat');
    dependsOnStation = coefficientInfo.dependsOnStation;
    dependsOnEq = coefficientInfo.dependsOnEq;
    
end