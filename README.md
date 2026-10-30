# Econometric Methods for Macroeconomics

Lecture materials for an advanced undergraduate and Master's course on modern econometric methods for macroeconomic research with time series and panel data. Taught at the University of Chicago as ECMA 31150 by [Mikkel Plagborg-Møller](https://www.mikkelpm.com/).

Topics covered include forecasting, estimation of dynamic causal effects using vector autoregressions and local projections, state space models, and Bayesian estimation. The methods are illustrated with applications to current debates in economic policy. The course emphasizes concepts and coding, rather than mathematical proofs. Interactive Jupyter notebooks written in Python accompany the slide decks.

If you spot any errors or confusing parts, I would be grateful if you could create a GitHub Issue or [email me](mailto:mikkelpm@uchicago.edu).

## Contents

| # | Lecture | Slides | Code | Source |
|---|---|---|---|---|
| 1 | Forecasting with stationary models I | [PDF](slides/slides_01statio1.pdf) | [notebook](code/slides01_examples.ipynb) | [tex](src/slides/01statio1) |
| 2 | Forecasting with stationary models II | [PDF](slides/slides_02statio2.pdf) | [notebook](code/slides02_examples.ipynb) | [tex](src/slides/02statio2) |
| 3 | Forecasting with stationary models III | [PDF](slides/slides_03statio3.pdf) | [notebook](code/slides03_examples.ipynb) | [tex](src/slides/03statio3) |
| 4 | Forecasting with stationary models IV | [PDF](slides/slides_04statio4.pdf) | [notebook](code/slides04_examples.ipynb) | [tex](src/slides/04statio4) |
| 5 | Vector autoregression I | [PDF](slides/slides_05var1.pdf) | [notebook](code/slides05_examples.ipynb) | [tex](src/slides/05var1) |
| 6 | Vector autoregression II | [PDF](slides/slides_06var2.pdf) | [notebook](code/slides06_examples.ipynb) | [tex](src/slides/06var2) |
| 7 | Inference with weakly dependent data I | [PDF](slides/slides_07infer1.pdf) | [notebook](code/slides07_examples.ipynb) | [tex](src/slides/07infer1) |
| 8 | Inference with weakly dependent data II | [PDF](slides/slides_08infer2.pdf) | [notebook](code/slides08_examples.ipynb) | [tex](src/slides/08infer2) |
| 9 | Dynamic causal effects I | [PDF](slides/slides_09causal1.pdf) | [notebook](code/slides09_examples.ipynb) | [tex](src/slides/09causal1) |
| 10 | Dynamic causal effects II | [PDF](slides/slides_10causal2.pdf) | [notebook](code/slides10_examples.ipynb) | [tex](src/slides/10causal2) |
| 11 | Dynamic causal effects III | [PDF](slides/slides_11causal3.pdf) | [notebook](code/slides11_examples.ipynb) | [tex](src/slides/11causal3) |
| 12 | Bayesian estimation I | [PDF](slides/slides_12bayes1.pdf) | [notebook](code/slides12_examples.ipynb) | [tex](src/slides/12bayes1) |
| 13 | Bayesian estimation II | [PDF](slides/slides_13bayes2.pdf) | [notebook](code/slides13_examples.ipynb) | [tex](src/slides/13bayes2) |
| 14 | State space models I | [PDF](slides/slides_14ss1.pdf) | [notebook](code/slides14_examples.ipynb) | [tex](src/slides/14ss1) |
| 15 | State space models II | [PDF](slides/slides_15ss2.pdf) | [notebook](code/slides15_examples.ipynb) | [tex](src/slides/15ss2) |
| 16 | Non-stationary models I | [PDF](slides/slides_16nonstat1.pdf) | [notebook](code/slides16_examples.ipynb) | [tex](src/slides/16nonstat1) |
| 17 | Non-stationary models II | [PDF](slides/slides_17nonstat2.pdf) | [notebook](code/slides17_examples.ipynb) | [tex](src/slides/17nonstat2) |

Additional files:
- [Syllabus](syllabus.pdf), including an optional reading list
- [Problem sets](psets/)
- [Past exams](exams/)
- LaTeX source for all documents in [`src/`](src/)

Code and data that the problem sets refer to as being "on the course website" are in [`code/`](code/).

## Setup

The Jupyter notebooks require a recent Python installation. The specific conda environment I used is specified in [`environment.yml`](environment.yml) and can be installed as follows:
```
conda env create -f environment.yml
conda activate ecma31150
```
The Bayesian examples use [Stan](https://mc-stan.org/) via `cmdstanpy`. Install CmdStan once with:
```
python -c "import cmdstanpy; cmdstanpy.install_cmdstan()"
```
Run the notebooks from within the `code/` folder. Figures are saved to `code/output/`.

## Data sources

- Most series are from [FRED](https://fred.stlouisfed.org/), Federal Reserve Bank of St. Louis.
- Monetary policy surprises: Bauer, M. D., and Swanson, E. T. (2023). "[A Reassessment of Monetary Policy Surprises and High-Frequency Identification](https://doi.org/10.1086/723574)." *NBER Macroeconomics Annual* 37.
- Global temperature and GDP data: Bilal, A., and Känzig, D. R. (2026). "[The Macroeconomic Impact of Climate Change: Global Versus Local Temperature](https://doi.org/10.1093/qje/qjag011)." *Quarterly Journal of Economics* 141(2). [Replication files](https://github.com/dkaenzig/micc_replication).
- Oil supply news shocks: Känzig, D. R. (2021). "[The Macroeconomic Effects of Oil Supply News: Evidence from OPEC Announcements](https://doi.org/10.1257/aer.20190964)." *American Economic Review* 111(4). [Updated series](https://github.com/dkaenzig/oilsupplynews).

## License

My original materials are licensed under the [MIT license](LICENSE). Figures, screenshots, and data from third parties belong to their respective owners and are subject to their own terms.

## Acknowledgements

This material is based upon work supported by the NSF under [Grant #2238049](https://www.nsf.gov/awardsearch/show-award?AWD_ID=2238049) and by the Alfred P. Sloan Foundation.
