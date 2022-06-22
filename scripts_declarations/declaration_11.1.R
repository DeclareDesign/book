N <- 100

declaration_11.1 <-
  declare_model(N = N) +
  declare_measurement(Y = rbinom(n = N, size = 1, prob = 0.55)) +
  declare_test(handler =
                 label_estimator(function(data) {
                   test <- prop.test(x = table(data$Y), p = 0.5)
                   tidy(test)
                 }))

