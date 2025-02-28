library(rdss) # for helper functions
Sys.setenv(RGL_USE_NULL = TRUE) # required to use DIDmultiplegt
library(DIDmultiplegt)

N_units <- 20
N_time_periods <- 20

declaration_16.3 <-
  declare_model(
  units = add_level(
    N = N_units,
    U_unit = rnorm(N),
    D_unit = if_else(U_unit > median(U_unit), 1, 0),
    D_time = sample(1:N_time_periods, N, replace = TRUE)
  ),
  periods = add_level(
    N = N_time_periods,
    U_time = rnorm(N),
    nest = FALSE
  ),
  unit_period = cross_levels(
    by = join_using(units, periods),
    U = rnorm(N),
    potential_outcomes(Y ~ U + U_unit + U_time +
                         D * (0.2 - 1 * (D_time - as.numeric(periods))),
                       conditions = list(D = c(0, 1))),
    D = if_else(D_unit == 1 & as.numeric(periods) >= D_time, 1, 0),
    D_lag = lag_by_group(D, groups = units, n = 1, order_by = periods)
  )
) +
  declare_inquiry(
    ATT = mean(Y_D_1 - Y_D_0),
    subset = D == 1
  ) +
  declare_inquiry(
    ATT_switchers = mean(Y_D_1 - Y_D_0),
    subset = D == 1 & D_lag == 0 & !is.na(D_lag)
  ) +
  declare_measurement(Y = reveal_outcomes(Y ~ D)) +
  declare_estimator(
    Y ~ D, fixed_effects = ~ units + periods,
    .method = lm_robust,
    inquiry = c("ATT", "ATT_switchers"),
    label = "twoway-fe"
  ) +
  declare_estimator(
    Y = "Y",
    G = "units",
    T = "periods",
    D = "D",
    mode = "old",
    handler = label_estimator(did_multiplegt_tidy),
    inquiry = c("ATT", "ATT_switchers"),
    label = "chaisemartin"
  )
