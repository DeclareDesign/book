invested <- function(a_1, a_2) {
  u_a = (1 - a_1) * log(1 - a_1) + a_1 * log(2 * a_1)  # give a1
  u_b = (1 - a_1) * log(2 * a_2) + a_1 * log(2 * (1 - a_2)) # give 1
  ifelse(u_a > u_b, a_1, 1)
}

average_invested <- function(a_1) 
  mean(sapply(seq(0, 1, .01),  invested, a_1 = a_1))

returned <- function(x1, a_2 = 1/3) 
  ((2 * a_2 * x1 - (1 - a_2) * (1 - x1)) / (2 * x1)) * 
  (x1  > (1 - a_2) / (1 + a_2))

average_returned <- function(a_2) 
  mean(sapply(seq(0.01, 1, .01), returned, a_2 = a_2))
