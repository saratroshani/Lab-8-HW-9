# Lab 8
# Logit and Probit Models
# Continuing from Lab 7


# Logit Model

model_logit1 <- glm(
  he_older_6 ~ educ_hs + educ_somecoll + educ_college + educ_advdeg + AGE,
  data = trad_data,
  family = binomial
)

summary(model_logit1)

pred_vals <- predict(model_logit1, trad_data, type = "response")

pred_model_logit1 <- (pred_vals > mean(pred_vals))

table(
  pred = pred_model_logit1,
  true = trad_data$he_older_6
)


# OLS Predictions

pred_vals_ols1 <- predict(ols_out1, trad_data)

pred_model_ols1 <- (pred_vals_ols1 > mean(pred_vals_ols1))

table(
  pred = pred_model_ols1,
  true = trad_data$he_older_6
)


# Probit Model

model_probit1 <- glm(
  he_older_6 ~ educ_hs + educ_somecoll + educ_college + educ_advdeg + AGE,
  data = trad_data,
  family = binomial(link = "probit")
)

summary(model_probit1)

pred_vals_probit <- predict(
  model_probit1,
  trad_data,
  type = "response"
)

pred_model_probit1 <- (
  pred_vals_probit > mean(pred_vals_probit)
)

table(
  pred = pred_model_probit1,
  true = trad_data$he_older_6
)


# Model Accuracy

accuracy_ols <- mean(
  pred_model_ols1 == trad_data$he_older_6
)

accuracy_logit <- mean(
  pred_model_logit1 == trad_data$he_older_6
)

accuracy_probit <- mean(
  pred_model_probit1 == trad_data$he_older_6
)

model_comparison <- data.frame(
  Model = c("OLS", "Logit", "Probit"),
  Accuracy = c(
    accuracy_ols,
    accuracy_logit,
    accuracy_probit
  )
)

model_comparison


# False Positives and False Negatives

error_comparison <- data.frame(
  Model = c("OLS", "Logit", "Probit"),
  False_Positive = c(
    146143,
    132767,
    136898
  ),
  False_Negative = c(
    22285,
    24423,
    23711
  )
)

error_comparison


# 0.5 Cutoff

pred_logit_05 <- (pred_vals > 0.5)

pred_probit_05 <- (pred_vals_probit > 0.5)

table(
  pred = pred_logit_05,
  true = trad_data$he_older_6
)

table(
  pred = pred_probit_05,
  true = trad_data$he_older_6
)

mean(pred_vals)
mean(pred_vals_probit)


# Age Groups

trad_data <- trad_data %>%
  mutate(
    age_group = case_when(
      AGE < 30 ~ "Under 30",
      AGE < 40 ~ "30-39",
      AGE < 50 ~ "40-49",
      AGE < 60 ~ "50-59",
      TRUE ~ "60+"
    )
  )

trad_data$pred_logit1 <- pred_model_logit1


# Accuracy by Age Group

age_accuracy <- trad_data %>%
  group_by(age_group) %>%
  summarise(
    n = n(),
    accuracy = mean(pred_logit1 == he_older_6)
  )

age_accuracy


# False Positives and False Negatives by Age

age_errors <- trad_data %>%
  group_by(age_group) %>%
  summarise(
    false_positive = sum(
      pred_logit1 == TRUE &
        he_older_6 == 0
    ),
    false_negative = sum(
      pred_logit1 == FALSE &
        he_older_6 == 1
    )
  )

age_errors


# Logit Model with Age Squared

model_logit2 <- glm(
  he_older_6 ~ educ_hs + educ_somecoll + educ_college + educ_advdeg +
    AGE + I(AGE^2),
  data = trad_data,
  family = binomial
)

summary(model_logit2)

pred_vals2 <- predict(
  model_logit2,
  trad_data,
  type = "response"
)

pred_model_logit2 <- (
  pred_vals2 > mean(pred_vals2)
)

table(
  pred = pred_model_logit2,
  true = trad_data$he_older_6
)

accuracy_logit2 <- mean(
  pred_model_logit2 == trad_data$he_older_6
)

accuracy_logit2


# Error Comparison

error_logit2 <- data.frame(
  Model = c(
    "Original Logit",
    "Logit + Age Squared"
  ),
  False_Positive = c(
    132767,
    sum(
      pred_model_logit2 == TRUE &
        trad_data$he_older_6 == 0
    )
  ),
  False_Negative = c(
    24423,
    sum(
      pred_model_logit2 == FALSE &
        trad_data$he_older_6 == 1
    )
  )
)

error_logit2


# Final Model Comparison

model_comparison2 <- data.frame(
  Model = c(
    "Original Logit",
    "Logit + Age Squared"
  ),
  Accuracy = c(
    accuracy_logit,
    accuracy_logit2
  ),
  False_Positive = c(
    132767,
    160401
  ),
  False_Negative = c(
    24423,
    17653
  )
)

model_comparison2


# Data for Error Graph

error_plot <- data.frame(
  Model = c(
    "Original Logit",
    "Original Logit",
    "Logit + Age Squared",
    "Logit + Age Squared"
  ),
  Error_Type = c(
    "False Positive",
    "False Negative",
    "False Positive",
    "False Negative"
  ),
  Count = c(
    132767,
    24423,
    160401,
    17653
  )
)
