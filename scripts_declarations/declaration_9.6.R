MI <-
  declare_model(
    N = 100,
    X = rbinom(N, size = 1, 0.5),
    U = rnorm(N),
    potential_outcomes(Y ~ 0.5 * Z+-0.5 * X + 0.5 * X * Z + U)
  ) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0))

D1 <- 
  declare_assignment(Z = complete_ra(N = N)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z))
D2 <- 
  declare_assignment(Z = block_ra(blocks = X, block_prob = c(0.1, 0.8))) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z))


A1 <- declare_estimator(Y ~ Z, label = "Unweighted")
A2 <-
  declare_step(
    handler = fabricate,
    ipw = 1 / obtain_condition_probabilities(
      assignment = Z,
      blocks = X,
      block_prob = c(0.1, 0.8)
    )
  ) +
  declare_estimator(Y ~ Z, weights = ipw, label = "Weighted")

declaration_9.6 <- list(MI + D1 + A1,
                        MI + D1 + A2,
                        MI + D2 + A1,
                        MI + D2 + A2)