effect_size <- 0.35

declaration_18.10 <-
  declare_model(
    units = add_level(
      N = 100, 
      U_unit = rnorm(N)
    ),
    periods = add_level(
      N = 3,
      time = 1:max(periods),
      U_time = rnorm(N),
      nest = FALSE
    ),
    unit_period = cross_levels(
      by = join_using(units, periods),
      U = rnorm(N),
      potential_outcomes(
        Y ~ scale(U_unit + U_time + time + U) + effect_size * Z
      )
    )
  ) +
  declare_assignment(
    wave = cluster_ra(clusters = units, conditions = 1:max(periods)),
    Z = if_else(time >= wave, 1, 0)
  ) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0), subset = time < max(time)) + 
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z, fixed_effects = ~ periods + units, 
                    clusters = units, 
                    subset = time < max(time),
                    inquiry = "ATE", label = "TWFE") 
