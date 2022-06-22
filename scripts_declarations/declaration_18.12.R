declaration_18.12 <-
  declare_model(
    group = add_level(N = 50, group_shock = rnorm(N)),
    individual = add_level(
      N = 20,
      individual_shock = rnorm(N),
      potential_outcomes(
        Y ~ 0.2 * Z + 0.1 * (S == "low") + 0.5 * (S == "high") +
          group_shock + individual_shock,
        conditions = list(Z = c(0, 1),
                          S = c("low", "high"))
      )
    )
  ) +
  declare_inquiry(
    CATE_S_Z_0 = mean(Y_Z_0_S_high - Y_Z_0_S_low),
    CATE_Z_S_low = mean(Y_Z_1_S_low - Y_Z_0_S_low)
  ) +
  declare_assignment(
    S = cluster_ra(clusters = group, 
                   conditions = c("low", "high")),
    Z = block_ra(blocks = group, 
                 prob_unit = if_else(S == "low", 0.25, 0.75))
  ) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z + S)) +
  declare_estimator(
    Y ~ S,
    .method = difference_in_means,
    subset = Z == 0,
    term = "Shigh",
    clusters = group,
    inquiry = "CATE_S_Z_0",
    label = "Effect of high saturation among untreated"
  ) +
  declare_estimator(
    Y ~ Z,
    .method = difference_in_means,
    subset = S == "low",
    blocks = group,
    inquiry = "CATE_Z_S_low",
    label = "Effect of treatment at low saturation"
  )
