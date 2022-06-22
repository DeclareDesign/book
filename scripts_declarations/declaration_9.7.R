# number of streets to treat in each ward
block_m = c(71, 47, 60, 48, 35, 39, 63, 32, 52)

declaration_9.7 <-
  declare_model(data = foos_etal,
                # this is the sharp null hypothesis
                potential_outcomes(Y ~ 0 * Z + marked_register_2014)) +
  declare_assignment(Z = block_and_cluster_ra(blocks = ward, 
                                              clusters = street, 
                                              block_m = block_m),
                     probs = obtain_condition_probabilities(
                       assignment = Z,
                       blocks = ward,
                       clusters = street,
                       block_m = block_m
                     ),
                     ipw = 1 / probs) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) +
  declare_estimator(Y ~ Z + ward, weights = ipw, clusters = street)


