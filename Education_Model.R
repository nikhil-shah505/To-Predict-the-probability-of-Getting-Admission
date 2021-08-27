setwd("C:/Users/Souvik/Downloads/PPA FINAL PROJECT")

library(car)
library(corrplot)
library(caret)
library(caTools)
library(psych)
library(shiny)
library(shinythemes)
library(data.table)
library(RCurl)

Admission <- read.csv("Admission_Predict_Ver1.1.csv", row.names = 1)
View(Admission)
summary(Admission)

cr <- cor(Admission[c("Chance.of.Admit", "GRE.Score","TOEFL.Score",
                      "University.Rating","SOP","LOR","CGPA","Research")])
cr
corrplot(cr, type = "full")
corrplot(cr,method = "number")
corrplot.mixed(cr)
pairs.panels(Admission[c("Chance.of.Admit", "GRE.Score","TOEFL.Score",
                         "University.Rating","SOP","LOR","CGPA","Research")])
summary(Admission$Chance.of.Admit)
Admission_C <- subset(Admission, select = -c(SOP))
View(Admission_C)
#Splitting of the dataset into training and testing

split <- sample.split(Admission_C$Chance.of.Admit, SplitRatio = 0.7)
Admission_TR <- subset(Admission_C, split == "TRUE")
Admission_TS <- subset(Admission_C, split == "FALSE")


write.csv(Admission_TR, "training.csv")
write.csv(Admission_TS, "testing.csv")

TrainSet <- read.csv("training.csv", header = TRUE)
TrainSet <- TrainSet[,-1]
View(TrainSet)

#Linear Regression
model8 <- lm(Chance.of.Admit  ~ ., data = TrainSet)
summary (model8)

#prediction 
prediction <- predict(model8, Admission_TS) 
head(prediction)
head(Admission_TS$Chance.of.Admit)
plot(Admission_TS$Chance.of.Admit,type="l",col="green")
lines(prediction,type="l",col="blue")

prediction
#Heteroscedasticity check 
plot(model8$fitted.values,model8$residuals)

# Save model to RDS file
saveRDS(model8, "model.rds")

