library(MatchIt)

exact_matching <- 
  function(data) { 
    matched <- matchit(D ~ X, method = "exact", data = data) 
    match.data(matched) 
  }


declaration_16.2 <-
  declare_model(
    N = 100, 
    U = rnorm(N), 
    X = rbinom(N, 1, prob = 0.5),
    D = rbinom(N, 1, prob = 0.25 + 0.5 * X),
    Y_D_0 = 0.2 * X + U,
    Y_D_1 = Y_D_0 + 0.5
  ) + 
  declare_inquiry(ATE = mean(Y_D_1 - Y_D_0)) +
  declare_step(handler = exact_matching) +
  declare_measurement(Y = reveal_outcomes(Y ~ D)) +
  declare_estimator(Y ~ D,
                    weights = weights,
                    .method = difference_in_means,
                    label = "Matched difference-in-means") +
  declare_estimator(Y ~ D, 
                    .method = difference_in_means, 
                    label = "Raw difference-in-means")