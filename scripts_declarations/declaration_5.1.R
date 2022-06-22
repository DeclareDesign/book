declaration_5.1 <-
  declare_model(
    N = 1000,
    U = rnorm(N),
    X = rbinom(N, 1, prob = pnorm(U)),
    Y = rbinom(N, 1, prob = pnorm(U + X))
  ) +
  declare_inquiry(Ybar = mean(Y[X == 1])) +
  declare_sampling(S = simple_rs(N, prob = 0.1)) +
  declare_estimator(Y ~ 1,
                    .method = lm_robust,
                    subset = X == 1,
                    inquiry = "Ybar")