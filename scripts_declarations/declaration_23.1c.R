A <- declare_estimator(Y ~ Z, .method = lm_robust, label = "A")
A_prime <- declare_estimator(Y ~ Z + X, .method = lm_robust, label = "A_prime")