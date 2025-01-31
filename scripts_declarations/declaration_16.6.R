declaration_16.6 <-
  declaration_16.5 +
  declare_measurement(X_c = X - cutoff) +
  declare_estimator(
    Y ~ X_c * D,
    subset = X_c > -1*bandwidth & X_c < bandwidth,
    .method = lm_robust,
    inquiry = "LATE",
    label = "linear"
  )
