n_villages <- 192
citizens_per_village <- 48

data_strategy_12.1 <-
  declare_sampling(
    S_village = cluster_rs(clusters = villages, n = n_villages),
    filter = S_village == 1) +
  declare_sampling(
    S_citizen = strata_rs(strata = villages, n = citizens_per_village),
    filter = S_citizen == 1) +
  declare_assignment(
    Z = cluster_ra(
      clusters = villages, 
      conditions = c("neutral", "personal", "social"),
      prob_each = c(0.250, 0.375, 0.375))) + 
  declare_measurement(
    Y_latent = reveal_outcomes(Y ~ Z),
    Y_observed = rbinom(N, 1, prob = Y_latent)
  )