function [best_medoids, best_cost] = clarans(data, k, num_rep, max_neighbor, max_iter)
% CLARANS clustering algorithm
%
% Input:
%   data: input data matrix (N samples x M features)
%   k: number of clusters
%   num_rep: number of random neighbors examined at each iteration
%   max_neighbor: maximum number of neighbors examined
%   max_iter: maximum number of iterations
%
% Output:
%   best_medoids: best medoids found
%   best_cost: cost of the best solution found
%
% Reference:
%   Ng, R. T., & Han, J. (2002). CLARANS: A Method for Clustering Objects
%   for Spatial Data Mining. IEEE Transactions on Knowledge and Data Engineering, 14(5), 1003–1016. https://doi.org/10.1109/TKDE.2002.1033770

[N, M] = size(data);

% Initialize best cost and medoids
best_cost = Inf;
best_medoids = [];

% Main loop
for r = 1:num_rep
    % Randomly initialize medoids
    medoids = randperm(N, k);
    % Initialize cost
    cost = calculate_cost(data, medoids);
    
    % Initialize iteration counter
    iter = 0;
    
    % CLARANS algorithm
    while iter < max_iter
        % Randomly select a neighbor solution
        neighbor = randperm(max_neighbor, 1);
        neighbor_medoids = [medoids(1:neighbor-1) randperm(N-neighbor+1, k-neighbor+1)];
        
        % Calculate cost of the neighbor solution
        neighbor_cost = calculate_cost(data, neighbor_medoids);
        
        % If neighbor is better, update medoids and cost
        if neighbor_cost < cost
            medoids = neighbor_medoids;
            cost = neighbor_cost;
            iter = 0; % Reset iteration counter
        else
            iter = iter + 1; % Increment iteration counter
        end
        
        % Update best solution if necessary
        if cost < best_cost
            best_medoids = medoids;
            best_cost = cost;
        end
    end
end

end

function cost = calculate_cost(data, medoids)
% Calculate cost of the current solution
[N, ~] = size(data);
k = length(medoids);
distances = zeros(N, k);

% Calculate distances to medoids
for i = 1:k
    distances(:, i) = sqrt(sum((data - data(medoids(i), :)).^2, 2));
end

% Assign each point to the nearest medoid
[min_distances, ~] = min(distances, [], 2);

% Total cost is the sum of the minimum distances
cost = sum(min_distances);

end
% Example usage
data = Customers; % Assuming Customers is your data matrix
k = 5; % Number of clusters
num_rep = 10; % Number of random neighbors examined at each iteration
max_neighbor = 5; % Maximum number of neighbors examined
max_iter = 100; % Maximum number of iterations

[best_medoids, best_cost] = clarans(data, k, num_rep, max_neighbor, max_iter);
disp(['Best medoids: ', num2str(best_medoids)]);
disp(['Best cost: ', num2str(best_cost)]);
