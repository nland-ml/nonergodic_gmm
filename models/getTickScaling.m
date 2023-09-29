function tickDistance = getTickScaling(values)
    range = max(max(max(values))) - min(min(min(values)));
    tickDistance = 1;
    if range < 3
        tickDistance = 0.5;
    end
    if range < 1.5
        tickDistance = 0.2;
    end
    if range < 0.6
        tickDistance = 0.1;
    end
    if range < 0.3
        tickDistance = 0.05;
    end
    if range < 0.15
        tickDistance = 0.02;
    end
    if range < 0.06
        tickDistance = 0.01;
    end
    if range < 0.03
        tickDistance = 0.005;
    end
    if range < 0.015
        tickDistance = 0.002;
    end
    if range < 0.006
        tickDistance = 0.001;
    end
    
end