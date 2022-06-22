declaration_16.6 <-
  declaration_16.5 + 
  declare_estimator(
    Y ~ X * D, 
    subset = X > -1*bandwidth & X < bandwidth,
    .method = lm_robust, 
    inquiry = "LATE",
    label = "linear"
  )