clear all; close all; clc;
iris_data=dlmread('iris_dataset.dat');
%Shuffle the dataset%
iris_data_shuffle=iris_data(randperm(150),:);
data_len=size(iris_data,1);
NumOfFolds=10;
Accuracy=zeros(NumOfFolds,1);

for k=1:NumOfFolds
    count=0;
    %take test and train data for k fold cross validation%
    if k==1
    training_data=iris_data_shuffle(16: data_len,:);
    else
    training_data=iris_data_shuffle([1:(k*15)-15 (k*15)+1:data_len],:) ;
    end
  testing_data=iris_data_shuffle((k*15)-14:(k*15),:);
 
%Take all training examples with class1%
indi1=training_data(:,5)== 1;
u1=training_data(indi1,1:1);
%Take all training examples with class2%
indi2=training_data(:,5)== 2;
u2=training_data(indi2,1:1);
%Take all training examples with class3%
indi3=training_data(:,5)== 3;
u3=training_data(indi3,1:1);
%Calculate mean of each classes%
MeanOfu1 = mean(u1);
MeanOfu2 = mean(u2);
MeanOfu3 = mean(u3);
%Calculate Covariance of each classes%
Covu1 = cov(u1);
Covu2 = cov(u2);
Covu3 = cov(u3);

for i=1:15
    %Calculate discriminant Functions%
    g1=Discriminant(testing_data(i,1:1),Covu1,MeanOfu1);
    g2=Discriminant(testing_data(i,1:1),Covu2,MeanOfu2);
    g3=Discriminant(testing_data(i,1:1),Covu3,MeanOfu3);
     %check for the maximum value of discriminant function%
    if( g1 > g2 && g1 > g3)
      predicted=1;
    elseif (g2>g1 && g2 > g3)
        predicted=2;
    else
        predicted=3;
    end
    %check if the value predicted is same as the actual value%
    if predicted==testing_data(i,5)
        count=count+1;
     end
   
end
  %Calculate accuracy%
   accuracyRes=(count/15);
   Accuracy(k)= accuracyRes;
   

end

Accuracy
x=mean(Accuracy);
fprintf('Average Accuarcy =%f \n',x)