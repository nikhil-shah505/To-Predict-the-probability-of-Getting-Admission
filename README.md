# To-Predict-the-probability-of-Getting-Admission

Objective: The purpose is to build a model which will help students in shortlisting universities with their profiles. The predicted output would give them a fair idea about their chances for a particular university
We designed a model using multiple linear regression analysis and integrated it with an interface that would help Shyam identify the universities where he has high chances of getting selected with just few clicks!

Our Approach: 
Business Understanding
Data Understanding
Data Preparation
Modelling
Deployment

Data description: As our first step, we took a historical dataset of UCLA which contains several parameters that are considered relevant during the application for Masters Programmes abroad.
The parameters included are :
GRE Scores ( out of 340 )
TOEFL Scores ( out of 120 )
University Rating ( out of 5 )
SOP and LOR Strength ( out of 5 )
Undergraduate GPA ( out of 10 )
Research Experience (Yes or No)
Chance of Admission ( ranging from 0 to 1 )
Source: https://www.kaggle.com/mohansacharya/graduate-admissions

Result: We tried and tested with 8 different models.
The final model was built with Multiple R-squared value= 0.8188 and Adjusted   R-squared value= 0.8156 with no heteroscedasticity
Our final significant variables included- GRE and TOEFL score, University Rating, LOR, UG GPA and Research experience
The comparison between actual and predicted values was fairly accurate.






