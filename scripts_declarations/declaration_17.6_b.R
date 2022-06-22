
rho     <- 0.8
n_pairs <- 200
deceive <- FALSE

declaration_17.6 <-
  
  declare_model(N = 2 * n_pairs,
                a = runif(N)) +
  
  declare_inquiries(
    trusting = mean(sapply(a, average_invested)),
    trustworthy = mean(sapply(a, average_returned))) +

  declare_assignment(pair = complete_ra(N = N, num_arms = n_pairs),
                     role = 1 + block_ra(blocks = pair)) + 
  declare_step(
    id_cols = pair,
    names_from = role,
    values_from = c(ID, a),
    handler = pivot_wider) +
  
  declare_measurement(invested = invested(a_1, a_2)) + 
  
  declare_estimator(
    invested ~ 1,
    .method = lm_robust,
    inquiry = "trusting",
    label = "trusting") +

  declare_measurement(invested = deceive*runif(N) + (1-deceive)*invested,
                      returned = returned(invested, a_2)) +
  
  declare_estimator(
    returned ~ 1,
    .method = lm_robust,
    inquiry = "trustworthy",
    label = "trustworthy")
