model <-
  declare_model(N = 1000,
                U = rnorm(N),
                X = U + rnorm(N, sd = 0.5),
                potential_outcomes(Y ~  0.2 * Z + U))
inquiry <-
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0))
sampling <-
  declare_sampling(S = simple_rs(N, prob = 0.2), 
                   filter = S == 1)
assignment <-
  declare_assignment(Z = complete_ra(N))
measurement <-
  declare_measurement(Y = reveal_outcomes(Y ~ Z))
answer_strategy <-
  declare_estimator(Y ~ Z, inquiry = "ATE", label = "DIM") +
  declare_estimator(Y ~ Z + X, inquiry = "ATE", label = "OLS")

# as separate elements
declaration_13.2 <-
  model +
  inquiry +
  sampling +
  assignment +
  measurement +
  answer_strategy

# equivalently, and more compactly:
declaration_13.2 <-
  declare_model(N = 1000,
                U = rnorm(N),
                X = U + rnorm(N, sd = 0.5),
                potential_outcomes(Y ~  0.2 * Z + U)) + 
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_sampling(S = simple_rs(N, prob = 0.2),
                   filter = S == 1) +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z, inquiry = "ATE", label = "DIM") +
  declare_estimator(Y ~ Z + X, inquiry = "ATE", label = "OLS")
