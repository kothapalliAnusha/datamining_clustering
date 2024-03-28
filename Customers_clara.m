% Assuming MallCustomers is already defined as a numeric array

% Perform CLARA clustering
kclus = 5; % Number of desired clusters for CLARA
vtype = [4 4]; % Assuming all variables are interval variables
stdize = 0; % No standardization
metric = 'eucli'; % Euclidean distance metric
nsamp = 5; % Number of samples
sampsize = 40 + 2 * kclus; % Sample size

% Call the CLARA function
result_clara = clara(Customers, kclus, vtype, stdize, metric, nsamp, sampsize);

% Plotting the clusters obtained from CLARA
gscatter(Customers(:,1), Customers(:,2), result_clara.ncluv);
title('CLARA Clustering');