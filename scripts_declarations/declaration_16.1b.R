declaration_16.1 <-
  declare_model(draw_causal_type(causal_model)) +
  declare_inquiry(
    CoE =  query_distribution(
      causal_model, 
      query = "Y[X=1] - Y[X=0]", 
      parameters = causal_type)) +
  declare_measurement(
    handler = function(data)
      causal_model |>
      make_data(parameters = data$causal_type))  +
  declare_estimator(
    handler = label_estimator(process_tracing_estimator), 
    causal_model = causal_model,
    query = "Y[X=1] - Y[X=0]",
    strategies = strategies)