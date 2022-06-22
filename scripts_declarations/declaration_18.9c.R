declaration_18.9_placebo <-
  MI +
  declare_sampling(S = complete_rs(N, n = 200)) +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(X = if_else(type == "Complier", 1, 0),
                      D = reveal_outcomes(D ~ Z),
                      Y = reveal_outcomes(Y ~ D)) +
  declare_estimator(
    Y ~ Z,
    subset = X == 1,
    .method = lm_robust,
    inquiry = "CACE",
    label = "OLS among compliers"
  )