# First Project in R - Descriptive Statistics and Simple Linear Regression
# ------------------------------------------------------------
# Note: every line that starts with # is a comment. R skips it and does not run it.
#
# How to run a single section:
#   Select all the lines of the section (from its ===== header to the next one)
#   and press ▶ (Run Code) or Ctrl+Option+N.
#   Each section loads the data by itself, so it works on its own.
#   Loading the data (data <- ...) prints nothing, so the output shows only the section's results.
#   Plots are saved as PNG files in the "plots" folder next to this script and opened automatically.
#
# Paths are relative: the data file (Exc1.csv) and the "plots" folder sit next to this script,
# so R's working directory must be this script's folder.
#   VS Code + Code Runner: enable the setting "code-runner.fileDirectoryAsCwd".
#   RStudio / R console:   setwd("path/to/this/folder") before running.

# ===== Getting to know the data =====
# read.csv reads a CSV file and turns it into a table (in R this is called a data frame).
# The arrow <- means "store into". Here we store the table in a variable named data.
data <- read.csv("Exc1.csv")
head(data)   # shows the first 6 rows
str(data)    # shows the structure: number of rows, the columns and the type of each one

# ===== Section 1: the median of column X2 =====
data <- read.csv("Exc1.csv")
# To refer to a specific column of a table, write: table_name$column_name
# The median function computes the median.
median(data$X2)

# ===== Section 2: the correlation coefficient between X3 and Y =====
data <- read.csv("Exc1.csv")
# The cor function takes two columns and returns Pearson's correlation coefficient.
cor(data$X3, data$Y)

# ===== Section 3: add a column X5 = X1 + X3 =====
data <- read.csv("Exc1.csv")
# Assigning to a column that does not exist yet makes R create it.
# The addition is done row by row: in each row, X5 = that row's X1 + that row's X3.
data$X5 <- data$X1 + data$X3
head(data)   # check: a new column X5 should now appear

# ===== Section 4: BoxPlot of X5, including outliers =====
data <- read.csv("Exc1.csv")
data$X5 <- data$X1 + data$X3   # X5 must be created again, because every section starts from scratch
# Run Code does not open a plot window, so we save the plot as an image and then open it:
png("plots/boxplot_X5.png")   # 1. start drawing into an image file
boxplot(data$X5, main = "Boxplot of X5", ylab = "X5", col = "lightblue")   # 2. the plot itself
invisible(dev.off())                                                    # 3. close and save the image
system("open plots/boxplot_X5.png")   # 4. open the image
summary(data$X5)   # the numbers the plot is built from: min, Q1, median, mean, Q3, max

# ===== Section 5: the density function of X4, including the density line =====
data <- read.csv("Exc1.csv")
d <- density(data$X4)   # computes the density line (a smooth curve) and stores it in the variable d
png("plots/density_X4.png")
# hist = histogram. freq = FALSE: bar height is density, not a count,
# so the bars and the line are on the same scale.
# ylim: the range of the vertical axis, from 0 to the peak of the line, so the line is not cut off.
hist(data$X4, freq = FALSE, ylim = c(0, max(d$y)),
     main = "Density of X4", xlab = "X4", col = "lightblue")
lines(d, col = "red", lwd = 2)   # adds the density line on top of the histogram. lwd = line width
invisible(dev.off())
system("open plots/density_X4.png")

# ===== Section 6: simple regression, Y is the response and X1 is the predictor =====
data <- read.csv("Exc1.csv")
# lm = linear model. The formula Y ~ X1 means "Y explained by X1".
model <- lm(Y ~ X1, data = data)
summary(model)   # all the results: the coefficients (Estimate) and their t statistics (t value)

# Show it in a plot with the regression line:
png("plots/regression_Y_X1.png")
plot(data$X1, data$Y, main = "Y vs X1", xlab = "X1", ylab = "Y",
     pch = 19, col = "steelblue")          # scatter plot. pch = 19: filled dots
abline(model, col = "red", lwd = 2)        # adds the regression line from the model
invisible(dev.off())
system("open plots/regression_Y_X1.png")
