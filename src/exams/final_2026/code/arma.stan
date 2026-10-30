data {
  int<lower=1> T;
  vector[T] y;
}

parameters {
  real<lower=-1, upper=1> rho;
  real theta;
  real<lower=0> sigma;
}

transformed parameters {
  matrix[2, 2] F = [[rho, 0.0], [1.0, 0.0]];
  matrix[2, 2] U = [[square(sigma), 0.0], [0.0, 0.0]];
  row_vector[2] G = [1.0, theta];
}

model {
  rho ~ normal(0, 1);
  theta ~ normal(0, 1);
  sigma ~ cauchy(0, 1);

  {
    vector[2] s = rep_vector(0, 2);
    matrix[2, 2] P;
    P = square(sigma) / (1 - square(rho)) * [[1, rho], [rho, 1]];

    for (t in 1:T) {
      vector[2] s_pred = F * s;
      matrix[2, 2] P_pred = F * P * F' + U;
      real y_pred = G * s_pred;
      real Q_pred = G * P_pred * G';
      y[t] ~ normal(y_pred, sqrt(Q_pred));
      vector[2] K = P_pred * G' / Q_pred;
      s = s_pred + K * (y[t] - y_pred);
      P = P_pred - (K * K') * Q_pred;
    }
  }
}