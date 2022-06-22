library(metafor)

mu <- 0.2 # true PATE
tau <- 0.0 # true SD of site-level ATEs

design <-
  declare_model(
    N = 200,
    site = 1:N,
    std.error = pmax(0.1, abs(rnorm(N, mean = 0.8, sd = 0.5))),
    theta = rnorm(N, mean = mu, sd = tau), # when tau = 0, theta = mu 
    estimate = rnorm(N, mean = theta, sd = std.error)
  ) + 
  declare_inquiry(mu = mu, tau_sq = tau^2) + 
  declare_estimator(
    yi = estimate, sei = std.error, method = "REML",
    .method = rma_helper, .summary = rma_mu_tau,
    term = c("mu", "tau_sq"), inquiry = c("mu", "tau_sq"),
    label = "random-effects") + 
  declare_estimator(
    yi = estimate, sei = std.error, method = "FE",
    .method = rma_helper, .summary = rma_mu_tau,
    term = c("mu", "tau_sq"), inquiry = c("mu", "tau_sq"),
    label = "fixed-effects")

declaration_19.3 <- redesign(design, tau = c(0, 1))
