#model building for predicting gas prices for the next month based on this months economic data
# Loading in packages
library(ggplot2)
library(caret)
library(dplyr)

# Loading in the data
final_data <- read.csv("final_data.csv")
final_data <- subset(final_data, select = -X)
final_data <- final_data %>%
  mutate(Gas = lead(Gas.Price, n=1, default = last(Gas.Price)))
final_data<- subset(final_data, select = -Gas.Price)
# Splitting the data into a train and test set
set.seed(123) # For reproducibility
inTrain <- createDataPartition(
  y = final_data$Gas,
  p = 0.8,
  list = FALSE
)
training <- final_data[inTrain,]
testing <- final_data[-inTrain,]

# Remove the "date" column from the training and test datasets
training <- subset(training, select = -c(date))
testing <- subset(testing, select = -c(date))

# Define a list of models you want to try
models <- c("lm", "gbm") # Add more models as needed

# Initialize a vector to store RMSE values
rmse_values <- numeric(length(models))

# Initialize a list to store model objects
model_list <- list()

# Initialize a list to store predictions for each model
predictions_list <- list()

# Loop through each model
for (i in seq_along(models)) {
  # Define the formula for gas price prediction
  formula <- Gas ~ .  # Use all predictors
  
  # Set up control parameters for training
  ctrl <- trainControl(
    method = "repeatedcv",    # Using repeated cross-validation
    number = 10,              # Number of folds
    repeats = 5,              # Number of repetitions
    summaryFunction = defaultSummary # Use default summary function
  )
  
  # Train the model using train() function
  model <- train(
    formula,            # Formula for gas price prediction
    data = training,    # Data frame containing financial data
    method = models[i], # Use the current model
    trControl = ctrl    # Control parameters for training
  )
  
  # Store model object
  model_list[[i]] <- model
  
  # Predict on test data
  predictions <- predict(model, newdata = testing)
  
  # Store predictions
  predictions_list[[i]] <- predictions
  
  # Calculate RMSE
  rmse <- RMSE(predictions, testing$Gas)
  
  # Store RMSE value
  rmse_values[i] <- rmse
  
  # Print RMSE for current model
  cat("Model:", models[i], "RMSE:", rmse, "\n")
}

# Print RMSE values for all models
print("RMSE values for all models:")
print(rmse_values)

# Graphs for LM and GBM models

# Plot actual vs. predicted gas prices for LM
lm_predictions <- predictions_list[[which(models == "lm")]]
actual_vs_predicted_lm <- data.frame(Actual = testing$Gas, Predicted = lm_predictions)
ggplot(actual_vs_predicted_lm, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(x = "Actual Gas Price", y = "Predicted Gas Price") +
  ggtitle("Actual vs. Predicted Gas Prices (LM)")
ggsave("lm_accuracy.jpg")

# Plot actual vs. predicted gas prices for GBM
gbm_predictions <- predictions_list[[which(models == "gbm")]]
actual_vs_predicted_gbm <- data.frame(Actual = testing$Gas, Predicted = gbm_predictions)
ggplot(actual_vs_predicted_gbm, aes(x = Actual, y = Predicted)) +
  geom_point() +
  geom_abline(intercept = 0, slope = 1, color = "red") +
  labs(x = "Actual Gas Price", y = "Predicted Gas Price") +
  ggtitle("Actual vs. Predicted Gas Prices (GBM)")
ggsave("gbm_accuracy.jpg")

# Plot residuals vs. fitted values for LM model
if ("lm" %in% models) {
  lm_model <- model_list[[which(models == "lm")]]
  lm_resid <- residuals(lm_model)
  lm_fitted <- predict(lm_model)
  
  lm_resid_vs_fitted <- data.frame(Residuals = lm_resid, Fitted = lm_fitted)
  ggplot(lm_resid_vs_fitted, aes(x = Fitted, y = Residuals)) +
    geom_point() +
    geom_hline(yintercept = 0, color = "red") +
    labs(x = "Fitted Values", y = "Residuals") +
    ggtitle("Residuals vs. Fitted Values (LM)")
  ggsave("lm_residuals.jpg")
  c <- summary(lm_model$finalModel)$coefficients
  print(c)
}

# Plot feature importance for GBM model
if ("gbm" %in% models) {
  gbm_model <- model_list[[which(models == "gbm")]]
  gbm_feature_importance <- summary(gbm_model)
  
  # Plot variable importance
  ggplot(gbm_feature_importance, aes(x = reorder(var, -rel.inf), y = rel.inf)) +
    geom_bar(stat = "identity", fill = "skyblue") +
    coord_flip() +
    labs(x = "Features", y = "Importance") +
    ggtitle("Feature Importance (GBM)")
  ggsave("gbm_importance.jpg")
}

# Print summary statistics for each model
for (i in seq_along(models)) {
  cat("Summary for", models[i], "model:\n")
  print(model_list[[i]])
}
