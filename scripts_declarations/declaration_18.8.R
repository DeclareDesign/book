declaration_18.8 <-
  declare_model(
    N = 100,
    type = 
      rep(c("Always-Taker", "Never-Taker", "Complier", "Defier"),
          c(0.2, 0.2, 0.6, 0.0)*N),
    U = rnorm(N),
    # potential outcomes of Y with respect to D
    potential_outcomes(
      Y ~ case_when(
        type == "Always-Taker" ~ -0.25 - 0.50 * D + U,
        type == "Never-Taker" ~ 0.75 - 0.25 * D + U,
        type == "Complier" ~ 0.25 + 0.50 * D + U,
        type == "Defier" ~ -0.25 - 0.50 * D + U
      ),
      conditions = list(D = c(0, 1))
    ),
    # potential outcomes of D with respect to Z
    potential_outcomes(
      D ~ case_when(
        Z == 1 & type %in% c("Always-Taker", "Complier") ~ 1,
        Z == 1 & type %in% c("Never-Taker", "Defier") ~ 0,
        Z == 0 & type %in% c("Never-Taker", "Complier") ~ 0,
        Z == 0 & type %in% c("Always-Taker", "Defier") ~ 1
      ),
      conditions = list(Z = c(0, 1))
    )
  ) +
  declare_inquiry(
    ATE = mean(Y_D_1 - Y_D_0),
    CACE = mean(Y_D_1[type == "Complier"] - Y_D_0[type == "Complier"])) +
  declare_assignment(Z = conduct_ra(N = N)) +
  declare_measurement(D = reveal_outcomes(D ~ Z),
                      Y = reveal_outcomes(Y ~ D)) +
  declare_estimator(
    Y ~ D | Z,
    .method = iv_robust,
    inquiry = c("ATE", "CACE"),
    label = "Two stage least squares"
  ) +
  declare_estimator(
    Y ~ D,
    .method = lm_robust,
    inquiry = c("ATE", "CACE"),
    label = "As treated"
  ) +
  declare_estimator(
    Y ~ D,
    .method = lm_robust,
    inquiry = c("ATE", "CACE"),
    subset = D == Z,
    label = "Per protocol"
  )