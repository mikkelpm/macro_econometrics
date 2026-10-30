data {
  int<lower=1> T;              // effective sample size
  int<lower=1> p;              // lag order
  vector[T] y;                 // observed series
  matrix[T, p] X;              // lag matrix
  real<lower=0> lambda;        // prior tightness
  real<lower=0> scale_sigma;   // prior scale for sigma
  real<lower=0> scale_c;       // prior scale for intercept c
}

parameters {
  real c;                      // intercept
  vector[p] a;                 // AR coefficients
  real<lower=0> sigma;         // innovation std. dev.
}

model {
  // Minnesota prior on AR coefficients
  for (l in 1:p) {
    real m_ = (l == 1) ? 1.0 : 0.0;
    real sd_ = lambda / l;
    a[l] ~ normal(m_, sd_);
  }

  // Intercept prior
  c ~ normal(0, scale_c);

  // Innovation std. dev.
  sigma ~ cauchy(0, scale_sigma);

  // Likelihood (vectorized)
  y ~ normal(c + X * a, sigma);
}