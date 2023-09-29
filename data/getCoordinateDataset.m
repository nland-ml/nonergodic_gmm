function [X y offsety scaley offsetX scaleX] = getCoordinateDataset(yHeader,normalize)
    
    if nargin < 1
        yHeader = '0.010000';   % T=0.01s =~ PGA
    end
    if nargin < 2
        normalize = false;
    end
    
    
    load('nga-ask14.mat');
    
    coordinatesStations = data(:,find(ismember(headers,'stationLatitude')):find(ismember(headers,'stationLongitude')));     
    coordinatesEqs = data(:,find(ismember(headers,'eqLatitude')):find(ismember(headers,'eqLongitude')));   
    
    eqIds = data(:,find(ismember(headers,'eqid'))); 
    regions = data(:,find(ismember(headers,'region')));
    
    subsetCalifornia = (regions == 1);
    data = data(subsetCalifornia,:);
    coordinatesStations = coordinatesStations(subsetCalifornia,:);
    coordinatesEqs = coordinatesEqs(subsetCalifornia,:);
    eqIds = eqIds(subsetCalifornia,:);

    tableCoordinatesEqCenter = csvread('coordinates_eq.csv',1,0);
    tableCoordinatesStations = csvread('coordinates_stat.csv',1,0);
    for i = 1:size(coordinatesStations,1)
        % find stat coords by lat/lon
        epsilon = 0.0001;
        statCoordinatesRecord = unique(tableCoordinatesStations(abs(tableCoordinatesStations(:,5)-coordinatesStations(i,1))<epsilon & abs(tableCoordinatesStations(:,4)-coordinatesStations(i,2))<epsilon,[2 3]),'rows'); 
        assert(size(statCoordinatesRecord,1)==1 && size(statCoordinatesRecord,2)==2);
        coordinatesStationsUTM(i,:) = statCoordinatesRecord./1000;
        % find eq coords by eq id
        eqCoordinatesRecord = tableCoordinatesEqCenter(tableCoordinatesEqCenter(:,1)==eqIds(i),[3 4]);
        assert(size(eqCoordinatesRecord,1)==1 && size(eqCoordinatesRecord,2)==2);
        coordinatesEqsUTM(i,:) = eqCoordinatesRecord;
    end
    %coordinatesStations = coordinatesStationsUTM(:,[2 1])./1000;  % better for Matern kernel if this is roughly normalized?
    %coordinatesEqs = coordinatesEqsUTM(:,[2 1])./1000;
    %coordinatesStations = coordinatesStationsUTM(:,[2 1]);  % better for Matern kernel if this is roughly normalized?
    %coordinatesEqs = coordinatesEqsUTM(:,[2 1]);
    
    attributes = [find(ismember(headers,'mag')) find(ismember(headers,'RJB')) find(ismember(headers,'VS30')) find(ismember(headers,'SOF'))]; 
    X = [data(:,attributes) coordinatesStations coordinatesEqs];
    y = data(:,find(ismember(headers,yHeader)));
  
    X = featureRepresentation(X);
  
    infIndices = isinf(y);
    X = X(~infIndices,:);
    y = y(~infIndices,:);
    eqIds = eqIds(~infIndices,:);
    
    if normalize
        [X offsetX scaleX] = normalizeRows(X); 
        [y offsety scaley] = normalizeRows(y);
    else
        offsety = 0;
        scaley = 1;
        offsetX = zeros(1,size(X,2));
        scaleX = ones(1,size(X,2));
    end
 
    [X y] = removeFixedCoefficients(X,y);
    
    X = [eqIds X];
    
end
