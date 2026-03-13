# CCC-GARCH Analysis – W5453 Advanced Time Series Analysis and Forecasting

**University:** Universität Paderborn, Germany  
**Course:** W5453 – Advanced Time Series Analysis and Forecasting  
**Semester:** Winter Semester 2025/2026  
**Examiner:** Prof. Dr. Yuanhua Feng  
**Author:** Ashish Tiwari (Matriculation No. 4038122)  
**Submission Date:** March 13, 2026  

---

## Topic

**Topic 7.1 – CCC-GARCH: GARCH, EGARCH, APARCH and Log-GARCH**  
CCC correlation, conditional volatility estimation, and Value-at-Risk (VaR) forecasting  
applied to a portfolio of five US technology stocks.

---

## Project Overview

This project applies the **Constant Conditional Correlation (CCC) GARCH framework**
of Bollerslev (1990) to model the joint conditional volatility of five major US
technology stocks:

| Stock | Company |
|-------|---------|
| AAPL  | Apple Inc. |
| GOOG  | Alphabet Inc. |
| INTC  | Intel Corporation |
| MSFT  | Microsoft Corporation |
| NVDA  | NVIDIA Corporation |

**Sample period:** January 2010 – December 2023  
**Observations:** 3,521 daily log returns per series  
**Portfolio weights:** w = (0.30, 0.20, 0.10, 0.25, 0.15)

---

## Models Used

| Model | Description |
|-------|-------------|
| GARCH(1,1) | Symmetric baseline model (Bollerslev, 1986) |
| EGARCH(1,1) | Captures leverage effect via log-variance (Nelson, 1991) |
| APARCH(1,1) | Flexible power transformation + asymmetry (Ding et al., 1993) |
| Log-GARCH(1,1) | Log-variance model (Pantula, 1986; Geweke, 1986) |

---

## Key Results

- High volatility persistence confirmed across all five stocks (α + β close to 1)
- Leverage effect confirmed in all stocks via EGARCH and APARCH
- APARCH achieves the best fit (lowest AIC and BIC) across all stocks
- CCC correlations uniformly lower than unconditional correlations (by 0.054–0.094)
- VaR backtest: only **1 exceedance** in 250 days → **Basel Green Zone**
- Kupiec LR statistic = 1.176, p-value = 0.278 (correct coverage not rejected)

---

## R Packages Used

- `rugarch` – GARCH, EGARCH, APARCH estimation
- `lgarch` – Log-GARCH estimation
- `yfR` – Yahoo Finance data download
- `dplyr`, `tidyr` – Data manipulation
- `zoo` – Time series handling
- `ggplot2` – Visualisation

---

## How to Run

1. Open `CCC_GARCH_Final.R` in RStudio
2. Install required packages if needed:
```r
install.packages(c("rugarch", "lgarch", "yfR", "dplyr", "tidyr", "zoo", "ggplot2"))
```
3. Run the script — data is downloaded automatically from Yahoo Finance
4. All plots and results are generated automatically

---

## References

- Bollerslev (1986) – GARCH
- Bollerslev (1990) – CCC-GARCH
- Nelson (1991) – EGARCH
- Ding, Granger and Engle (1993) – APARCH
- Pantula (1986), Geweke (1986) – Log-GARCH
- Bauwens, Laurent and Rombouts (2006) – Multivariate GARCH survey
- Kupiec (1995) – VaR backtesting
- Sucarrat (2013) – lgarch package
```

