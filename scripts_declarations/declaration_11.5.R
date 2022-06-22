library(margins)

tidy_margins <- function(x) {
  tidy(margins(x, data = x$data), conf.int = TRUE)
}

N <- 10

declaration_11.5 <-
  declare_model(N = N,
                U = rnorm(N),
                potential_outcomes(Y ~ rbinom(N, 1, prob = 0.2 * Z + 0.6))) +
  declare_inquiry(ATE = mean(Y_Z_1 - Y_Z_0)) +
  declare_assignment(Z = complete_ra(N, prob = 0.5)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z,
                    inquiry = "ATE",
                    term = "Z",
                    label = "OLS") +
  declare_estimator(
    Y ~ Z,
    .method = glm,
    family = binomial("logit"),
    .summary = tidy_margins,
    inquiry = "ATE",
    term = "Z",
    label = "logit"
  ) +
  declare_estimator(
    Y ~ Z,
    .method = glm,
    family = binomial("probit"),
    .summary = tidy_margins,
    inquiry = "ATE",
    term = "Z",
    label = "probit"
  ) 