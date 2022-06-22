inquiry_12.1 <-
  declare_inquiry(
    ATE_personal = mean(Y_Z_personal - Y_Z_neutral),
    ATE_social = mean(Y_Z_social - Y_Z_neutral)
  )