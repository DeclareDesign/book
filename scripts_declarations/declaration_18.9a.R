compliance_rate <- 0.2

MI <-
  declare_model(
    N = 400,
    type = sample(x = c("Never-Taker", "Complier"), 
                  size = N,
                  prob = c(1 - compliance_rate, compliance_rate),
                  replace = TRUE),
    U = rnorm(N),
    # potential outcomes of Y with respect to D
    potential_outcomes(
      Y ~ case_when(
        type == "Never-Taker" ~ 0.75 - 0.25 * D + U,
        type == "Complier" ~ 0.25 + 0.50 * D + U
      ),
      conditions = list(D = c(0, 1))
    ),
    # potential outcomes of D with respect to Z
    potential_outcomes(
      D ~ if_else(Z == 1 & type == "Complier", 1, 0),
      conditions = list(Z = c(0, 1))
    )
  ) +
  declare_inquiry(
    CACE = mean(Y_D_1[type == "Complier"] - 
                  Y_D_0[type == "Complier"])
  )