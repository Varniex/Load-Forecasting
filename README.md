*@Author: Dishant Varshney*

## Abstract
For optimal power system operation, electrical generation must follow electrical
load demand. The generation, transmission, and distribution utilities require some means to forecast the electrical load so they can utilize their electrical infrastructure efficiently, securely, and economically. The load forecast represents the electric load forecast for a time interval of a few hours to a few days.
This project will use the method of Artificial Neural Networks (ANN) to create a
Load forecast algorithm. The ANN is a mathematical tool that mimics the thought processes of the human brain. The ANN can be created and trained to receive historical load and future weather forecasts as input and produce a load forecast as its output. Most ANNs in the literature are used to forecast load profile for a transmission-level system with resulting load forecast error came out to be approximately 5 %. This report will show that an ANN can be used to forecast the smaller, more chaotic load profile of an institutional/industrial-type power system and results in a similar forecast error range. In addition, electric load will be analysed along with the weather profiles for the site. Correlations between load and weather and load and calendar descriptors, such as day of week and month, will be used as predictor inputs to the ANN to optimize its size and accuracy.

## Implementation
I used csv2struct function to import the csv (or any Excel) file. Once the file is imported, I used the method of Artificial Neural Network to make a Load Forecasting model which predicts the load based on the inputs given. Alternatively, there is an in-built app in MATLAB called *ANN* where the model can be created automatically and can be used to predict the target based on the given inputs.
