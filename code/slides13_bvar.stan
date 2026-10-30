data {
  int<lower=1> T;             // effective sample size
  int<lower=1> n;             // # variables
  int<lower=1> p;             // lag order
  matrix[T, n] Y;             // observed series
  matrix[T, n*p] X;           // lag matrix
  real<lower=0> lambda;       // overall prior tightness
  real<lower=0> kappa;        // cross-lag prior tightness
  vector<lower=0>[n] scale_sigma; // prior scale for innovation stdev's
  vector<lower=0>[n] scale_c;     // prior scale for intercepts
}

transformed data {
  // Build mean and stdev of Minnesota prior
  matrix[n, n*p] A_mean;
  matrix[n, n*p] A_std;
  for (l in 1:p) {      // lag
    for (i in 1:n) {    // equation
      for (j in 1:n) {  // regressor
        int col = (l - 1) * n + j;
        A_mean[i, col] = (l == 1 && i == j) ? 1 : 0;
        A_std[i, col] = (i == j)
          ? lambda / l
          : (lambda / l) * (kappa * scale_sigma[i] / scale_sigma[j]);
      }
    }
  }

  // Scale matrix for Sigma prior
  matrix[n, n] Sigma_scale = diag_matrix(square(scale_sigma));
}

parameters {
  vector[n] c;                // intercepts
  matrix[n, n*p] A;           // VAR coefficients [A_1, ..., A_p]
  cov_matrix[n] Sigma;        // innovation var-cov matrix
}

model {
  // Minnesota prior on VAR coefficients
  to_vector(A) ~ normal(to_vector(A_mean), to_vector(A_std));

  // Intercept prior
  c ~ normal(0, scale_c);

  // Prior on innovation var-cov matrix
  Sigma ~ inv_wishart(n + 2, Sigma_scale);

  // Likelihood
  for (t in 1:T)
    Y[t] ~ multi_normal(c + A * X[t]', Sigma);
}
