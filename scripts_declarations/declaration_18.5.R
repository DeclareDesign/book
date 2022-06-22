ICC <- 0.9

declaration_18.5 <-
  declare_model(
    cluster =
      add_level(
        N = 10,
        cluster_size = rep(seq(10, 50, 10), 2),
        cluster_shock =
          scale(cluster_size + rnorm(N, sd = 5)) * sqrt(ICC),
        cluster_tau = rnorm(N, sd = sqrt(ICC))
      ),
    individual =
      add_level(
        N = cluster_size,
        individual_shock = rnorm(N, sd = sqrt(1 - ICC)),
        individual_tau = rnorm(N, sd = sqrt(1 - ICC)),
        Y_Z_0 = cluster_shock + individual_shock,
        Y_Z_1 = Y_Z_0 + cluster_tau + individual_tau
      )
  ) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = block_and_cluster_ra(clusters = cluster, blocks = cluster_size)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z,
                    clusters = cluster,
                    inquiry = "ATE")
