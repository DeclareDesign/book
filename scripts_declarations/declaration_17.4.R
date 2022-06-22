declaration_17.4 <- 
  declare_model(
    N = N,
    U = rnorm(N),
    control_count = rbinom(N, size = 3, prob = 0.5),
    Y_star = rbinom(N, size = 1, prob = 0.3),
    W = case_when(Y_star == 0 ~ 0L,
                  Y_star == 1 ~ rbinom(N, size = 1, prob = proportion_hiding)),
    potential_outcomes(Y_list ~ Y_star * Z + control_count)
  ) +
  declare_inquiry(prevalence_rate = mean(Y_star)) +
  declare_assignment(Z = complete_ra(N)) + 
  declare_measurement(Y_list = reveal_outcomes(Y_list ~ Z),
                      Y_direct = Y_star - W) +
  declare_estimator(Y_list ~ Z, inquiry = "prevalence_rate", label = "list") + 
  declare_estimator(Y_direct ~ 1, inquiry = "prevalence_rate", label = "direct")