declaration_9.5 <-
  declare_model(data = resample_data(clingingsmith_etal)) +
  declare_estimator(views ~ success, .method = difference_in_means)
