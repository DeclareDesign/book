declaration_15.5 <- 
  declaration_15.4 +
  declare_estimator(
    handler = label_estimator(function(data) {
      model_fit <- lm_robust(
        formula = policy_support ~ HS + state,
        data = data
      )
      post_stratification_helper(model_fit, data = data, group = state, weights = PS_weight)
    }),
    label = "No pooling",
    inquiry = "mean_policy_support") +
  declare_estimator(
    handler = label_estimator(function(data) {
      model_fit <- lm_robust(
        formula = policy_support ~ HS,
        data = data
      )
      post_stratification_helper(model_fit, data = data, group = state, weights = PS_weight)
    }),
    label = "Full pooling",
    inquiry = "mean_policy_support")
