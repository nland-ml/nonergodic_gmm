function setCoefficientInfo(frequency)
    frequency = str2num(frequency);
    beta8fixed = true;
    beta5andbeta8fixed = beta8fixed & (frequency>=1);

    if beta5andbeta8fixed
        coefficientInfo.fixedCoefficients = [NaN NaN NaN NaN 0 NaN NaN -0.1 NaN NaN];
        coefficientInfo.dependsOnStation = [0 0 0 0 1 0 1 0];
        coefficientInfo.dependsOnEq =      [0 0 1 0 0 0 0 1];
        %coefficientInfo.dependsOnStation = [0 0 0 0 1 0 1 0];
        %coefficientInfo.dependsOnEq =      [0 0 1 0 0 0 0 1];
    elseif beta8fixed
        coefficientInfo.fixedCoefficients = [NaN NaN NaN NaN NaN NaN NaN -0.1 NaN NaN];
        coefficientInfo.dependsOnStation = [0 0 0 0 0 1 0 1 0];
        coefficientInfo.dependsOnEq =      [0 0 1 0 1 0 0 0 1];
        %coefficientInfo.dependsOnStation = [0 0 0 0 1 0 0 1 0];
        %coefficientInfo.dependsOnEq =      [0 0 1 0 0 0 0 0 1];
    else
        % version without any fixed parameters
        coefficientInfo.fixedCoefficients = [NaN NaN NaN NaN NaN NaN NaN NaN NaN NaN];
        coefficientInfo.dependsOnStation = [0 0 0 0 0 1 0 0 1 0];
        coefficientInfo.dependsOnEq =      [0 0 1 0 1 0 0 0 0 1];
    end
        
    save('coefficientInfo.mat','coefficientInfo');
end