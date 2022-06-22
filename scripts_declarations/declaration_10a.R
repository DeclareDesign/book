heteroskedasticity <- 0
prob_treated = 0.5

design <-
  declare_model(
    N = 100,
    Y_Z_0 = rnorm(N, mean = 0, sd = 1 - heteroskedasticity),
    Y_Z_1 = rnorm(N, mean = 1, sd = 1 + heteroskedasticity)
  ) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = complete_ra(N, prob = prob_treated)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z,
                    .method = lm_robust,
                    se_type = "classical",
                    label = "Classical standard error") +
  declare_estimator(Y ~ Z,
                    .method = lm_robust,
                    se_type = "HC2",
                    label = "HC2 robust standard error")

declaration_10a <-
  redesign(
    design,
    heteroskedasticity = c(-0.4, 0, 0.4),
    prob_treated = seq(0.1, 0.9, length.out = 7)
  )
