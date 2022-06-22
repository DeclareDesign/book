declaration_18.9_encouragement <-
  MI +
  declare_assignment(Z = complete_ra(N)) +
  declare_measurement(D = reveal_outcomes(D ~ Z),
                      Y = reveal_outcomes(Y ~ D)) +
  declare_estimator(
    Y ~ D | Z,
    .method = iv_robust,
    inquiry = "CACE",
    label = "2SLS among all units"
  )