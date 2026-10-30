data {
    int<lower=1> T;             // sample size
    matrix[T, 2] y;             // data
    real mu_mean;               // prior mean for mu
    real<lower=0> mu_std;       // prior std. dev. for mu
    real rho_mean;              // prior mean for rho
    real<lower=0> rho_std;      // prior std. dev. for rho
    real<lower=0> sigma_scale;  // prior scale for sigma_j
}

transformed data {
    vector[2] G = [1.0, 1.0]';
}

parameters {
    real mu;
    real<lower=-1, upper=1> rho;
    vector<lower=0>[2] sigma_v;
    real<lower=0> sigma_G;
}

transformed parameters {
    vector[2] c = [mu, mu]';
    matrix[2, 2] V = diag_matrix(square(sigma_v));
}

model {
    // Prior
    mu ~ normal(mu_mean, mu_std);
    rho ~ normal(rho_mean, rho_std);
    sigma_v ~ cauchy(0, sigma_scale);
    sigma_G ~ cauchy(0, sigma_scale);

    // Likelihood via Kalman filter
    {
        // Initialize
        real s = 0;
        real P = square(sigma_G) / (1 - square(rho));

        for (t in 1:T) {
            // Predict
            real s_pred = rho * s;
            real P_pred = square(rho) * P + square(sigma_G);
            vector[2] y_pred = c + G * s_pred;
            matrix[2, 2] Q_pred = P_pred * G * G' + V;

            // Likelihood contribution
            y[t]' ~ multi_normal(y_pred, Q_pred);

            // Gain (transposed)
            vector[2] Kt = mdivide_left_spd(Q_pred, G * P_pred);

            // Update
            s = s_pred + Kt' * (y[t]' - y_pred);
            P = P_pred - Kt' * Q_pred * Kt;
        }
    }
}