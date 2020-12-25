%% load pretrained AlexNet
alex = alexnet;
layers = alex.Layers;

%% customize network for regression
layers = [
    layers(1:22)
    fullyConnectedLayer(1)
    regressionLayer];

%% prepare data 
load('speedcurve.mat');
Y = speedcurve';
Y = [Y;Y];
imds = imageDatastore('images');
numim = numel(imds.Files);
trainingimage = uint8(zeros([layers(1).InputSize,numim]));
for n = 1:numim
    trainingimage(:,:,:,n) = read(imds);
end
% trainingimage = imresize(trainingimage,[227 227]);
%% retrain network
opts = trainingOptions('adam', 'InitialLearnRate', 0.0001, 'MaxEpochs', 1000, 'MiniBatchSize', 64,'Plots','training-progress',...
       'LearnRateSchedule','piecewise', ...
       'LearnRateDropFactor',0.9, ...
       'LearnRateDropPeriod',50);
dotraining = true;
if dotraining
    myNet = trainNetwork(trainingimage, Y,layers, opts);
    save('myNet.mat','myNet')
else
    load myNet
end

%% predict value
predictedvalue = predict(myNet,trainingimage(:,:,:,50));
figure,imshow(trainingimage(:,:,:,50))
title(['Predicted value：　' num2str(predictedvalue) '   ラベル：　' num2str(Y(50))],'FontSize',20)
display(['Predicted value：　' num2str(predictedvalue)])
display(['Actual value：　' num2str(Y(50))])

%%
% Copyright 2019 The MathWorks, Inc.