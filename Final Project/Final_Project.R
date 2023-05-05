#install.packages("tidyverse")
library(tidyverse)

#still have to load this separate from tidyverse
#install.packages("readxl")
library(readxl)

### Set source location to the same as this file   
setwd("C:/Spring 2023/CRP 558/LA-558/Final Project")
#read in excel file
windmills <- read_excel("uswtdb_v4_3_20220114.xlsx")

#Summarize by state
windmills_states <- windmills %>%
  group_by(t_state) %>%
  summarise(total_t_cap = sum(t_cap), count_of_windmills = n())

#Summarize by state and county
windmills_counties <- windmills %>%
  group_by(t_state, t_county) %>%
  summarise(total_t_cap = sum(t_cap), count_of_windmills = n())

#write CSVs for the files
write_csv(windmills_states, "windmills_states.csv")
write_csv(windmills_counties, "windmills_counties.csv")


##########
### For windmills_counties

# Load the library for MLE
library(maxLik)

# Create a function to calculate the log-likelihood of the normal distribution
loglik <- function(par, x){
  mu <- par[1]
  sigma <- par[2]
  sum(log(dnorm(x[!is.na(x)], mean = mu, sd = sigma)))
}

# Subset the data with non-missing values of income
mydata <- windmills_counties$total_t_cap[!is.na(windmills_counties$total_t_cap)]

# Define the log-likelihood function for the normal distribution
loglik_norm <- function(par){
  loglik(par, x = mydata)
}

# Use MLE to estimate the mean and variance of the normal distribution
fit <- maxLik(loglik_norm, start = c(mean(mydata), sd(mydata)))

# Use the estimated mean and variance to impute missing values
windmills_counties$total_t_cap[is.na(windmills_counties$total_t_cap)] <- rnorm(sum(is.na(windmills_counties$total_t_cap)), mean = fit$estimate[1], sd = fit$estimate[2])
windmills_counties_positive <- windmills_counties                       # Duplicate vector
windmills_counties_positive[windmills_counties_positive < 0] <- 0       # Set negative values to 0
windmills_counties_positive                                             # Print updated vector


write_csv(windmills_counties_positive, "windmills_counties_noNA_Positive.csv")


########
##########
### For windmills_states

# Load the library for MLE
library(maxLik)

# Create a function to calculate the log-likelihood of the normal distribution
loglik <- function(par, x){
  mu <- par[1]
  sigma <- par[2]
  sum(log(dnorm(x[!is.na(x)], mean = mu, sd = sigma)))
}

# Subset the data with non-missing values of income
mydata2 <- windmills_states$total_t_cap[!is.na(windmills_states$total_t_cap)]

# Define the log-likelihood function for the normal distribution
loglik_norm <- function(par){
  loglik(par, x = mydata2)
}

# Use MLE to estimate the mean and variance of the normal distribution
fit <- maxLik(loglik_norm, start = c(mean(mydata2), sd(mydata2)))

# Use the estimated mean and variance to impute missing values
windmills_states$total_t_cap[is.na(windmills_states$total_t_cap)] <- rnorm(sum(is.na(windmills_states$total_t_cap)), mean = fit$estimate[1], sd = fit$estimate[2])
windmills_states_positive <- windmills_states                       # Duplicate vector
windmills_states_positive[windmills_states_positive < 0] <- 0       # Set negative values to 0
windmills_states_positive  

write_csv(windmills_states_positive, "windmills_states_noNA_Positive.csv")
