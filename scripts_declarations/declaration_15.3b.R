budget_function <- 
  function(cluster_prob){
    budget = 20000
    cluster_cost = 20
    individual_cost = 2
    n_clusters = 1000
    n_individuals_per_cluster = 100
    
    total_cluster_cost <-
      cluster_prob * n_clusters * cluster_cost
    
    remaining_funds <- budget - total_cluster_cost
    
    sampleable_individuals <- 
      cluster_prob * n_clusters * n_individuals_per_cluster
    
    individual_prob = 
      (remaining_funds/individual_cost)/sampleable_individuals
    
    pmin(individual_prob, 1)
  }