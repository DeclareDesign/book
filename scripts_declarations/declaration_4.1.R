declaration_4.1 <- 
  declare_model(N = 100, U = rnorm(N),
                potential_outcomes(Y ~ 0.25 * Z + U)) +
  declare_inquiry(PATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_sampling(S = complete_rs(N, n = 50)) +
  declare_assignment(Z = complete_ra(N, prob = 0.5)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(
    Y ~ Z, .method = difference_in_means, inquiry = "PATE"
  )