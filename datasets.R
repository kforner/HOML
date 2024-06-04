ames <- AmesHousing::make_ames()
attrition <- modeldata::attrition

mnist <- dslabs::read_mnist()
names(mnist)
dim(mnist$train$images)

## Grocery items and quantities purchased
url <- "https://koalaverse.github.io/homlr/data/my_basket.csv"
my_basket <- readr::read_csv(url)
dim(my_basket)
