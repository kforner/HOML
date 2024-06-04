library(dplyr)     # for data manipulation
library(ggplot2)   # for awesome graphics

# Modeling process packages
library(rsample)   # for resampling procedures
library(caret)     # for resampling and model training
library(h2o)       # for resampling and model training

# h2o set-up 
h2o.no_progress()  # turn off h2o progress bars
h2o.init()         # launch h2o

# Ames housing data
ames <- AmesHousing::make_ames()
ames.h2o <- as.h2o(ames)


## 2.2.1 Simple random sampling
# Using base R
set.seed(123)  # for reproducibility
index_1 <- sample(1:nrow(ames), round(nrow(ames) * 0.7))
train_1 <- ames[index_1, ]
test_1  <- ames[-index_1, ]

# Using caret package
set.seed(123)  # for reproducibility
index_2 <- createDataPartition(ames$Sale_Price, p = 0.7, list = FALSE)
train_2 <- ames[index_2, ]
test_2  <- ames[-index_2, ]

# Using rsample package
set.seed(123)  # for reproducibility
split_1  <- initial_split(ames, prop = 0.7)
train_3  <- training(split_1)
test_3   <- testing(split_1)


df <- ames
df$group <- 'test'
df$group[index_1] <- 'training'
df$group <- as.factor(df$group)
ggplot(data = df, aes(x = Sale_Price, fill = group)) + 
geom_density()

## 2.2.2 Stratified sampling
churn <-  modeldata::attrition %>% 
  mutate_if(is.ordered, .funs = factor, ordered = FALSE)
churn.h2o <- as.h2o(churn)

# original response distribution
table(churn$Attrition) %>% prop.table()

# stratified sampling with the rsample package
set.seed(123)
split_strat  <- initial_split(churn, prop = 0.7, strata = "Attrition")
train_strat  <- training(split_strat)
test_strat   <- testing(split_strat)

table(train_strat$Attrition) %>% prop.table()
table(test_strat$Attrition) %>% prop.table()
