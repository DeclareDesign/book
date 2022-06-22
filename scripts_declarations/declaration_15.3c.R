declaration_15.3 <-
  declare_model(data = two_nigerian_states) +
  declare_measurement(Y = as.numeric(cut(Y_star, 7))) +
  declare_inquiry(Y_bar = mean(Y)) +
  declare_sampling(
    S_cluster = strata_and_cluster_rs(
      strata = state,
      clusters = locality,
      prob = cluster_prob
    ),
    filter = S_cluster == 1
  ) +
  declare_sampling(
    S_individual = 
      strata_rs(strata = locality, 
                prob = budget_function(cluster_prob)),
    filter = S_individual == 1
  ) +
  declare_estimator(Y ~ 1,
                    clusters = locality,
                    se_type = "stata",
                    inquiry = "Y_bar")