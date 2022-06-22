# X is a confounder and is measured pretreatment
model_2 <- 
  declare_model(
    N = 100,
    U = rnorm(N),
    X = rnorm(N),
    Z = rbinom(N, 1, prob = plogis(0.5 + X)),
    potential_outcomes(Y ~ 0.1 * Z + 0.25 * X + U),
    Y = reveal_outcomes(Y ~ Z)
  ) 