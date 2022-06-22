set.seed(343) # fix random seed to yield a fixed population of units
portola <-
  fabricate(
    N = 2100,
    Y_star = rnorm(N)
  )

declaration_15.1 <-
  declare_model(data = portola) +
  declare_measurement(Y = as.numeric(cut(Y_star, 7))) +
  declare_inquiry(Y_bar = mean(Y)) +
  declare_sampling(S = complete_rs(N, n = 100)) +
  declare_estimator(Y ~ 1, inquiry = "Y_bar")
