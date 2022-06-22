data_strategy_2 <-
  declare_sampling(S = complete_rs(N = N, n = 100), 
                   filter = S == 1) +
  declare_assignment(Z = block_ra(blocks = history)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z)) 

answer_strategy_2 <-
  declare_estimator(Y ~ Z, .method = difference_in_means, 
                    blocks = history, inquiry = "ATE")

declaration_2.2 <- 
  model + inquiry + data_strategy_2 + answer_strategy_2
