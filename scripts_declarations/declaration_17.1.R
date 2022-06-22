declaration_17.1 <-
  declare_model(
    N = 500,
    type = sample(
      size = N, 
      replace = TRUE,
      x = c("Always-responder",
            "Anti-Latino discriminator",
            "Never-responder"),
      prob = c(0.30, 0.05, 0.65)
    ),
    # Behavioral assumptions represented here:
    Y_Z_white = if_else(type == "Never-Responder", 0, 1),
    Y_Z_latino = if_else(type == "Always-Responder", 1, 0)
  ) +
  declare_inquiry(
    anti_latino_discrimination = mean(type == "Anti-Latino discriminator")
  ) +
  declare_assignment(Z = complete_ra(N, conditions = c("latino", "white"))) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z, inquiry = "anti_latino_discrimination")