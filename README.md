This is a pan India Data Science Competition by ZS Associates hosted on Hacker Rank. 

I got a rank in top 40 based on a GBM model.
( https://drive.google.com/file/d/0ByPBn4rtMQ5HZl9IN1N3MHhHZEU/view?usp= sharing)
( https://cloud.githubusercontent.com/assets/10769039/17398289/a8e123b6-5a59-11e6-895e-9e91b5242aa8.png)

The problem statement was to predict which hospitals will be purchasing the instruments given the historical records and also the revenue each of those hospitals. 

The CODE file contains the final trimmed code in R. The steps followed are:

1. Loading the following libraries :

library('dplyr')
library('randomForest')
library('caret')
library('Metrics')
library('mice')
 
2. Inputation with MICE.

3. Creation of all possible combinations of Hospital_ID, District_ID and Instrument_ID through expand.grid command.

4. Creation of training data by performing left join between the table created in step 3 and Hospital_Revenue table which contains all combinations of Hospital_ID, District_ID and Instrument_ID that resulted in a buy, rest of rows were considered as not bought.

5. A GBM model was created with Instrument_ID and District_ID as predictors and Buy_or_not as outcome.

6. Regression was performed through Gradient Boosted Model and appropriate Confidence level was chosen using 30 fold Cross Validation with the training data.

7. Trends were captured in the Hospital Revenue and Projected_Reevenue files and were captured.

8. The Final Solution was saved and submitted in the correct format.   
