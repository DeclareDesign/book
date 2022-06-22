declaration_17.3 <-
  declare_model(
    N = 500,
    control_count = rbinom(N, size = 3, prob = 0.5),
    Y_star = rbinom(N, size = 1, prob = 0.3),
    potential_outcomes(Y_list ~ Y_star * Z + control_count) 
  ) +
  declare_inquiry(prevalence_rate = mean(Y_star)) +
  declare_assignment(Z = complete_ra(N)) + 
  declare_measurement(Y_list = reveal_outcomes(Y_list ~ Z)) +
  declare_estimator(Y_list ~ Z, .method = difference_in_means, 
                    inquiry = "prevalence_rate")