declaration_13.1 <-
  declare_model(N = 100,
                U = rnorm(N),
                potential_outcomes(Y ~ 0.2 * Z + U)) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(
    Y ~ Z,
    .method = lm_robust,
    .summary = tidy,
    term = "Z",
    inquiry = "ATE",
    label = "OLS"
  )