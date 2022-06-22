declaration_16.4 <-
  declare_model(
    N = 100, 
    U = rnorm(N),
    potential_outcomes(D ~ if_else(Z + U > 0, 1, 0), 
                       conditions = list(Z = c(0, 1))), 
    potential_outcomes(Y ~ 0.1 * D + 0.25 + U, 
                       conditions = list(D = c(0, 1))),
    complier = D_Z_1 == 1 & D_Z_0 == 0
  ) + 
  declare_inquiry(LATE = mean(Y_D_1 - Y_D_0), subset = complier == TRUE) + 
  declare_assignment(Z = complete_ra(N, prob = 0.5)) +
  declare_measurement(D = reveal_outcomes(D ~ Z),
                      Y = reveal_outcomes(Y ~ D)) + 
  declare_estimator(Y ~ D | Z, .method = iv_robust, inquiry = "LATE") 
