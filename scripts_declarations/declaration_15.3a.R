ICC <- 0.4

two_nigerian_states <-
  fabricate(
    state = add_level(N = 2, 
                      state_name = c("taraba", "kwara"),
                      state_mean = c(-0.2, 0.2)),
    locality = add_level(
      N = 500,
      locality_shock = rnorm(N, state_mean, sqrt(ICC))
    ),
    individual = add_level(
      N = 100,
      individual_shock = rnorm(N, sd = sqrt(1 - ICC)),
      Y_star = locality_shock + individual_shock
    )
  )