N <- 100

declaration_11.3 <-
  declare_model(N = N, U = rnorm(N),
                potential_outcomes(Y ~ 0.2 * Z + U)) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = complete_ra(N = N, prob = prob)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z, inquiry = "ATE")