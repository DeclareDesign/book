CATE_Z1_Z2_0 <- 0.2
CATE_Z2_Z1_0 <- 0.1
interaction <- 0.1
N <- 1000

declaration_18.7 <-
  declare_model(
    N = N,
    U = rnorm(N),
    potential_outcomes(Y ~ CATE_Z1_Z2_0 * Z1 +
                         CATE_Z2_Z1_0 * Z2 +
                         interaction * Z1 * Z2 + U,
                       conditions = list(Z1 = c(0, 1),
                                         Z2 = c(0, 1)))) +
  declare_inquiry(
    CATE_Z1_Z2_0 = mean(Y_Z1_1_Z2_0 - Y_Z1_0_Z2_0),
    CATE_Z1_Z2_1 = mean(Y_Z1_1_Z2_1 - Y_Z1_0_Z2_1),
    ATE_Z1 = 0.5 * CATE_Z1_Z2_0 + 0.5 * CATE_Z1_Z2_1,
    
    CATE_Z2_Z1_0 = mean(Y_Z1_0_Z2_1 - Y_Z1_0_Z2_0),
    CATE_Z2_Z1_1 = mean(Y_Z1_1_Z2_1 - Y_Z1_1_Z2_0),
    ATE_Z2 = 0.5 * CATE_Z2_Z1_0 + 0.5 * CATE_Z2_Z1_1,
    
    diff_in_CATEs_Z1 = CATE_Z1_Z2_1 - CATE_Z1_Z2_0,
    #equivalently
    diff_in_CATEs_Z2 = CATE_Z2_Z1_1 - CATE_Z2_Z1_0
  ) + 
  declare_assignment(Z1 = complete_ra(N),
                     Z2 = block_ra(Z1)) +
  declare_measurement(Y = reveal_outcomes(Y ~ Z1 + Z2)) +
  declare_estimator(Y ~ Z1, subset = (Z2 == 0), 
                    inquiry = "CATE_Z1_Z2_0", label = "1") +
  declare_estimator(Y ~ Z1, subset = (Z2 == 1), 
                    inquiry = "CATE_Z1_Z2_1", label = '2') +
  declare_estimator(Y ~ Z2, subset = (Z1 == 0), 
                    inquiry = "CATE_Z2_Z1_0", label = "3") +
  declare_estimator(Y ~ Z2, subset = (Z1 == 1),
                    inquiry = "CATE_Z2_Z1_1", label = "4") +
  declare_estimator(Y ~ Z1 + Z2, term = c("Z1", "Z2"), 
                    inquiry = c("ATE_Z1", "ATE_Z2"), label = "5") +
  declare_estimator(Y ~ Z1 + Z2 + Z1*Z2, term = "Z1:Z2", 
                    inquiry = c("diff_in_CATEs_Z1", "diff_in_CATEs_Z2"), 
                    label = "6") 