data {
  int<lower=1> T;              // effective sample size
  int<lower=1> p;              // lag order
  vector[T] y;                 // observed series
  matrix[T, p] X;              // lag matrix
  real<lower=0> lambda;        // Minnesota prior tightness
  real<lower=0> scale_c;       // prior scale for AR intercept
  real<lower=0> scale_omega;   // prior scale for ARCH intercept
}

parameters {
  real c;                      // AR intercept
  vector[p] a;                 // AR coefficients
  real<lower=0> omega;         // ARCH intercept
  real<lower=0,upper=1> gamma; // ARCH parameter
}

transformed parameters {
  vector[T] sigma2;            // conditional variances
  {
    vector[T] u = y - (c + X * a);
    sigma2[1] = omega / (1 - gamma); // initialize at unconditional mean
    for (t in 2:T)
      sigma2[t] = omega + gamma * square(u[t-1]);
  }
}

model {
  // Minnesota prior on AR coefficients
  for (l in 1:p) {
    real m_ = (l == 1) ? 1.0 : 0.0;
    real sd_ = lambda / l;
    a[l] ~ normal(m_, sd_);
  }

  // Intercept and ARCH priors
  c ~ normal(0, scale_c);
  omega ~ normal(0, scale_omega);
  gamma ~ beta(1.1, 1.1); // nearly uniform on [0,1]

  // Likelihood (vectorized)
  y ~ normal(c + X * a, sqrt(sigma2));
}
