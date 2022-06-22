library(rdddr) # for helper functions
library(spdep)
library(interference)

# Here we obtain the adjacency matrix
adj_matrix <-
  fairfax |>
  as("Spatial") |>
  poly2nb(queen = TRUE) |>
  nb2mat(style = "B", zero.policy = TRUE)

# Here we create a permutation matrix of possible random assignments
ra_declaration <- declare_ra(N = 238, prob = 0.1)

permutatation_matrix <- 
  ra_declaration |>
  obtain_permutation_matrix(maximum_permutations = 10000) |>
  t()

declaration_18.13 <-
  declare_model(
    data = select(as_tibble(fairfax), -geometry),
    Y_0_0 = pnorm(scale(SHAPE_LEN), sd = 3),
    Y_1_0 = Y_0_0 + 0.02,
    Y_0_1 = Y_0_0 + 0.01,
    Y_1_1 = Y_0_0 + 0.03
  ) +
  declare_inquiry(
    total_ATE = mean(Y_1_1 - Y_0_0),
    direct_ATE = mean(Y_1_0 - Y_0_0),
    indirect_ATE = mean(Y_0_1 - Y_0_0)
  ) +
  declare_assignment(
    Z = conduct_ra(ra_declaration),
    exposure = get_exposure_AS(make_exposure_map_AS(adj_matrix, Z, hop = 1))
  ) +
  declare_measurement(
    Y = case_when(
      exposure == "dir_ind1" ~ Y_1_1,
      exposure == "isol_dir" ~ Y_1_0,
      exposure == "ind1" ~ Y_0_1,
      exposure == "no" ~ Y_0_0
    )
  ) +
  declare_estimator(handler = estimator_AS_tidy, 
                    permutatation_matrix = permutatation_matrix, 
                    adj_matrix = adj_matrix)
