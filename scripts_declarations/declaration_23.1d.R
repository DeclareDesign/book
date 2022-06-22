# X is not a confounder and is measured posttreatment
model_3 <- 
  declare_model(
    N = 100,
    U = rnorm(N),
    Z = rbinom(N, 1, prob = plogis(0.5)),
    potential_outcomes(Y ~ 0.1 * Z + U),
    Y = reveal_outcomes(Y ~ Z),
    X = 0.1 * Z + 5 * Y + rnorm(N)
  ) 

I <- declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0))

design_1 <- model_1 + I + A + A_prime
design_2 <- model_2 + I + A + A_prime
design_3 <- model_3 + I + A + A_prime

declaration_23.1 <- list(design_1, design_2, design_3)