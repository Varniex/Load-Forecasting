%% Load Forecasting
% @Author: Dishant Varshney

%% Import Data
filename = 'abc.csv'; % abc = name of data file
data = csv2struct(filename);

%% Variables
load = data.SYSLoad;
hr = data.Hour;
dates = datenum(data.Date, 'mm-dd-yyyy') + (data.Hour-1)/24;

if all(floor(dates)==dates)
    dates = dates + (data.Hour-1)/24;
end

%% days
k = 1;
days = zeros(366,1);
for i = 1:24:length(dates)
    days(k) = dates(i);
    k = k+1;
end
dload = zeros(366,1);
l = 1;
for i = 1:24:length(load)
    dload(l) = sum(load(i:i+23));
    l = l+1;
end

%% Summer, Fall, Spring, and Winter
sload = load(3649:4368); %June
wload= load(1:24*31); %January
fload = load(7321:8040); %November
spload=load(2905:3648); %May

%% Previous data
prev_day_sme_hr = [NaN(24,1); data.SYSLoad(1:end-24)];
prev_wek_sem_hr = [NaN(168,1); data.SYSLoad(1:end-168)];

x = [data.Temp, data.Humidity, data.Pressure, data.Hour, data.GlobalHorizontal prev_day_sme_hr, prev_wek_sem_hr];
labels = {'Temperature', 'Humidity', 'Pressure', 'Hour', 'Global Horizontal', 'Prev day same hour load', 'prev week same hour load'};

y = load;

%% Regression
[b, bint, r] = regress(y,x);
ypred = x*b;

%% Training 80% and Testing 20%
trn = floor(0.8*(length(x)));
trnX = x(1:trn,:);
trnY = y(1:trn,:);
trndates = dates(1:trn,:);

testX = x(trn+1:end,:);
testY = y(trn+1:end,:);

testdates = dates(trn+1:end,:);

%% Neural (Model)
net = newfit(trnX',trnY',30);
[net,tr] = train(net, trnX', trnY');

%% Forecast and error
load_forecast = sim(net,testX')';

err = testY - load_forecast;
errp = (abs(err)./testY)*100;

mae = mean(testY, load_forecast);
mape = mean(errp);


%% Compare forecast load with actual load
h1 = figure;
plotregression(testY',load_forecast)

%% Figures
h2 = figure;
plot(testY,'DisplayName','testY');hold on;plot(load_forecast,'DisplayName','forecast');hold off;
ylabel('Load');
h3 = figure;
plot(testdates, testY - load_forecast);
xlabel('Date'); ylabel('Error');
