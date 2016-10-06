library('dplyr')
library('randomForest')
library('caret')
library('Metrics')
library('mice')




hospital_profiling<-read.csv("HospitalProfiling.csv",header = T)
hospital_revenue<-read.csv("HospitalRevenue.csv",header = T)
projected_revenue<-read.csv("ProjectedRevenue.csv",header = T)
solution<-read.csv("Solution.csv",header = T)

hp<-hospital_profiling[!duplicated(hospital_profiling[,c('Hospital_ID','District_ID')]),]
hospital <- left_join(hospital_revenue, hp)

sum(is.na(h))
mice_mod <- mice(h[, ], method='rf')
mice_output <- complete(mice_mod)
h <- mice_output
sum(is.na(h))

h$District_ID<-(as.factor(h$District_ID))
h$Hospital_ID<-as.factor(h$Hospital_ID)
h$Buy_or_not<-ifelse(h$Year.Total>0,1,0)

h_reserved<-h






outcomeName<-c('Buy_or_not')
predictors <- c('Hospital_ID','District_ID','Instrument_ID')



s<-solution

summary(s$Buy_or_not)

#All possible combinations of Hospital_ID, District_ID and Instrubent_ID.
x<-expand.grid(Hospital_ID=levels(hospital_revenue$Hospital_ID),District_ID=levels(hospital_revenue$District_ID),Instrument_ID=levels(hospital_revenue$Instrument_ID))


all<-left_join(x,hospital_revenue)
all$Buy_or_not<-ifelse(is.na(all$Year.Total),0,1)
all.imp<-all[,c(1,2,3,18)]




pre<-c('Instrument_ID','District_ID')
name<-c('Buy_or_not')
model_gbm<-train(all.imp[,pre],all.imp[,name],method='gbm')
pred <- predict(object=model_gbm, solution[,pre])
summary(pred)



#.90 Quaterile (High confidence level based on ratio of 1 and 0 in Training data[12 Lakh+ entries] )
s$Buy_or_not<-ifelse(pred>1.090302,1,0)
s$Revenue<-0


#Hospital_Revenue Table and Projected_Revenue_Table suggest strong connection between yearly revenue and projected revenues of Instrument 2 when looked for average revenues per instrument[Trend Capturing].
s$Buy_or_not[s$Instrument_ID=='Instrument 2']<-1
write.csv(s, file = 'FileName12(1).csv', row.names = F)
#0.1404
