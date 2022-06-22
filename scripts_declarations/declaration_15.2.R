effort <- 0 # baseline of no extra effort

declaration_15.2 <- 
  declare_model(data = portola) + 
  declare_measurement(Y = as.numeric(cut(Y_star, 7))) + 
  declare_inquiry(Y_bar = mean(Y)) + 
  declare_sampling(S = complete_rs(N, n = 100)) + 
  declare_measurement(
    R = rbinom(n = N, size = 1, prob = pnorm(Y_star + effort)),
    Y = if_else(R == 1, Y, NA_real_)
  ) +
  declare_estimator(Y ~ 1, inquiry = "Y_bar") +
  declare_estimator(R ~ 1, label = "Response Rate")
