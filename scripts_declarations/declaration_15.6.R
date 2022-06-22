declaration_15.6 <-
  declare_model(
    N = 500,
    X = rep(0:1, N / 2),
    Y_star = 1 + X + 2 * rnorm(N)
  ) +
  declare_inquiry(Y_bar_X1 = mean(scale(Y_star)[X == 1])) +
  declare_measurement(
    Y_1 = 3 + 0.1 * Y_star + rnorm(N, sd = 5),
    Y_2 = 2 + 1.0 * Y_star + rnorm(N, sd = 2),
    Y_3 = 1 + 0.5 * Y_star + rnorm(N, sd = 1),
    Y_avg = ((scale(Y_1) + scale(Y_2) + scale(Y_3)))/3,
    Y_avg_adjusted = (
      # rescaling according to the X = 0 group
      (Y_1 - mean(Y_1[X == 0])) / sd(Y_1[X == 0]) +
        (Y_2 - mean(Y_2[X == 0])) / sd(Y_2[X == 0]) +
        (Y_3 - mean(Y_3[X == 0])) / sd(Y_3[X == 0])
    ) / 3,
    Y_avg_rescaled = scale((scale(Y_1) + scale(Y_2) + scale(Y_3))),
    Y_first_factor  = princomp( ~ Y_1 + Y_2 + Y_2, cor = TRUE)$scores[, 1]
  ) +
  declare_estimator(
    cbind(Y_avg, Y_avg_adjusted, Y_avg_rescaled, Y_first_factor) ~ 1,
    .method = lm_robust,
    inquiry = "Y_bar_X1",
    subset = X == 1,
    term = TRUE,
    label = "Average"
  )
