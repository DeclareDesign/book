declaration_7.1 <-
  declare_model(
    N = 20, 
    U = rnorm(N),
    Y = 1 + U
  ) +
  declare_inquiry(
    superpopulation_mean = 1,
    population_mean = mean(Y)
  ) + 
  declare_sampling(
    S = complete_rs(N, n = 10)
  ) +
  declare_inquiry(sample_mean = mean(Y))
