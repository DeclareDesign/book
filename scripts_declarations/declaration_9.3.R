library(broom.mixed) # for helper functions
library(rstanarm)

declaration_9.3 <-
  declare_model(N = 100, age = sample(0:80, size = N, replace = TRUE)) +
  declare_inquiry(mean_age = mean(age)) +
  declare_sampling(S = complete_rs(N = N, n = 3)) +
  declare_estimator(
    age ~ 1,
    .method = stan_glm,
    family = gaussian(link = "log"),
    prior_intercept = normal(50, 5),
    refresh = 0, # less verbose output
    .summary = ~tidy(., exponentiate = TRUE),
    inquiry = "mean_age"
  )
