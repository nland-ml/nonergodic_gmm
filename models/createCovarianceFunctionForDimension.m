function [covfunc covfuncT] = createCovarianceFunctionForDimension(xDimension,dimension,dependsOnStation,dependsOnEq,kernelType)
    if nargin < 5
        kernelType = 'Matern1';
    end

    assert(ismember(kernelType,{'Matern1','Matern3','Matern5','RBF'}));
    if dependsOnStation || dependsOnEq
        maskT = [zeros(1,xDimension) dependsOnStation*ones(1,2) dependsOnEq*ones(1,2)];
        % Choose kernel type
        if strcmp(kernelType,'Matern1')
            covGeo = {@covMask,{maskT,{@covMaterniso,1}}};
        end
        if strcmp(kernelType,'Matern3')
            covGeo = {@covMask,{maskT,{@covMaterniso,3}}};
        end
        if strcmp(kernelType,'Matern5')
            covGeo = {@covMask,{maskT,{@covMaterniso,5}}};
        end
        if strcmp(kernelType,'RBF')
            covGeo = {@covMask,{maskT,{@covSEiso}}};
        end
    else
        % Attribute should not vary geographically. 
        % For simplicity, replacing Matern kernel on coordinates with something that has the same number of hyperparameters.
        covGeo = {@covScale,{@covConst}};
    end
     
     
    covfuncT0 = {@covScale,covGeo};
    covfuncT = {@covSum,{covfuncT0,@covConst}};  
   
    % Masking of X
    maskDimension = [zeros(1,dimension-1) 1 zeros(1,xDimension-dimension) zeros(1,4)];
    covfuncX = {@covMask,{maskDimension,@covLIN}};

    % Combining X and T kernels
    covfunc = {@covProd,{covfuncX,covfuncT}};
        
end