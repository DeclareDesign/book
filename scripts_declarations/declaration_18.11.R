declaration_18.11 <-
  declare_model(
    N = n_units, 
    U_unit = rnorm(N),
    U = rnorm(N),
    effect_size = effect_size,
    potential_outcomes(Y ~ scale(U_unit + U) + effect_size * Z)
  ) +
  declare_assignment(Z = complete_ra(N, m = n_units / 2)) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) + 
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z, inquiry = "ATE", label = "DIM")