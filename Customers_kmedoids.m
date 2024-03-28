Customers = table2array(Customers);
sa = [];
K = [];
for k = 1:20
    [idx, c, sumd] = kmedoids(Customers, k);
    sa = [sa sum(sumd)];
    K = [K k];
end

[idx, c, sumd] = kmedoids(Customers, 5);
gscatter(Customers(:,1), Customers(:,2), idx);