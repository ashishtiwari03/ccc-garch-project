# Project 1 - Topic 6
# VAR Analysis: GDP and Consumption

# Load libraries
library(MTS)
library(aTSA)
library(xts)
library(zoo)
library(ggplot2)

# 1. Load Data
gdp <- read.csv("GDPC1.csv")
cons <- read.csv("PCEC96.csv")

# 2. Prepare Data
# Need to match quarterly GDP with monthly Consumption

# Fix GDP dates to quarters
dates_gdp <- as.yearqtr(as.Date(gdp$observation_date))
gdp_ts <- xts(gdp$GDPC1, order.by = dates_gdp)

# Fix Consumption dates and aggregate to quarters
dates_cons <- as.yearqtr(as.Date(cons$observation_date))
cons_ts <- xts(cons$PCEC96, order.by = dates_cons)

# Calculate mean consumption per quarter
cons_q <- aggregate(cons_ts, by = index(cons_ts), FUN = mean)

# Merge them (keep only matching dates)
data <- merge(gdp_ts, cons_q, join = "inner")
colnames(data) <- c("GDP", "CONS")

# Log transformation
y <- log(data)

# Growth rates (difference * 100)
dy <- diff(y) * 100
dy <- na.omit(dy)  # remove the first empty row

# Matrices for MTS functions
y_mat <- as.matrix(y)
dy_mat <- as.matrix(dy)


# 3. Plots
# Plot levels
plot.zoo(y, main = "Figure 1: Log Real GDP and Consumption (2007-2024)",
         xlab = "Year", ylab = "Log Value", col = c("blue", "red"),
         screens = 1) # Plot both on one panel to show they move together
legend("topleft", legend = c("Log GDP", "Log CONS"), col = c("blue", "red"), lty = 1)


# Plot growth rates
plot.zoo(dy, main = "Figure 2: Quarterly Growth Rates (2007-2024)",
         xlab = "Year", ylab = "Growth %", col = "black",
         yax.flip = FALSE)



# 4. Unit Root Tests
# H0: Non-stationary
print("ADF Test (GDP)")
adf.test(y_mat[,1])

print("ADF Test (Consumption)")
adf.test(y_mat[,2])

print("ADF Test (GDP Growth)")
adf.test(dy_mat[,1])

print("ADF Test (Consumption Growth)")
adf.test(dy_mat[,2])


# 5. Cointegration
# H0: No cointegration
print("Cointegration Test")
coint.test(y_mat[,1], y_mat[,2])

# 6. VAR Model
# Find best lag using BIC
p_max <- 6
bic <- rep(0, p_max)

for (p in 1:p_max) {
  m <- VAR(dy_mat, p = p, output = FALSE)
  bic[p] <- m$bic
}

# Get best lag
p_opt <- which.min(bic)
p_opt

# Estimate model
model <- VAR(dy_mat, p = p_opt)


# 7. Granger Causality
# Refine model (remove insignificant vars)
# # Using 1.96 as the standard 5% threshold
ref <- refVAR(model, thres = 1.96)

# Check matrix for zeros
ref$Phi


# 8. Forecasting
# 4 quarters ahead
fc <- VARpred(ref, h = 4)
fc$pred