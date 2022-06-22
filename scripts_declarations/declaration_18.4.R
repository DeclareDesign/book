declaration_18.4 <-
  declare_model(
    N = 500,
    X = rep(c(0, 1), each = N / 2),
    U = rnorm(N, sd = 0.25),
    potential_outcomes(Y ~ 0.2 * Z + X + U)
  ) +
  declare_assignment(
    Z = block_ra(blocks = X, block_prob = c(0.2, 0.5)),
    probs =
      obtain_condition_probabilities(assignment = Z, 
                                     blocks = X, 
                                     block_prob = c(0.2, 0.5)),
    ipw = 1 / probs
  ) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(
    Y ~ Z,
    covariates = ~ X,
    .method = lm_lin,
    weights = ipw,
    label = "Lin"
  )
