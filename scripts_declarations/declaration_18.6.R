set.seed(343)
fixed_pop <-
  fabricate(N = 10000,
            X = rbinom(N, 1, 0.2),
            potential_outcomes(
              Y ~ rbinom(N, 1,
                         prob = 0.7 + 0.1 * Z  - 0.4 * X - 0.2 * Z * X))
  )

total_n <- 1000
n_x1 <- 500
# Note: n_x2 = total_n - n_x1

declaration_18.6 <-
  declare_model(data = fixed_pop) +
  declare_inquiry(
    CATE_X1 = mean(Y_Z_1[X == 1] - Y_Z_0[X == 1]),
    CATE_X0 = mean(Y_Z_1[X == 0] - Y_Z_0[X == 0]),
    diff_in_CATEs = CATE_X1 - CATE_X0
  ) +
  declare_sampling(
    S = strata_rs(strata = X, strata_n = c(total_n - n_x1, n_x1))
  ) +
  declare_assignment(Z = block_ra(blocks = X)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z + X + Z * X, 
                    term = "Z:X", 
                    inquiry = "diff_in_CATEs")
