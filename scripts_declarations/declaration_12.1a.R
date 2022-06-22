model_12.1 <- 
  declare_model(
    villages = add_level(N = 660, U_village = rnorm(N, sd = 0.1)),
    citizens = add_level(
      N = 100,
      U_citizen = rnorm(N),
      potential_outcomes(
        Y ~ pnorm(
          U_citizen + U_village +
            0.10 * (Z == "personal") +
            0.15 * (Z == "social")),
        conditions = list(Z = c("neutral", "personal", "social"))
      )
    )
  )