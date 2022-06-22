N <- 100
r_sq <- 0

declaration_18.2 <-
  declare_model(N = N,
                draw_multivariate(c(U, X) ~ MASS::mvrnorm(
                  n = N,
                  mu = c(0, 0),
                  Sigma = matrix(c(1, sqrt(r_sq), sqrt(r_sq), 1), 2, 2)
                )), 
                potential_outcomes(Y ~ 0.1 * Z + U)) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(
    Y ~ Z, covariates = ~X, .method = lm_lin, inquiry = "ATE"
  )
