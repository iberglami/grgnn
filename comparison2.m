for steps = 14:7:42
    data_omega = xlsread(datapath);
    result = [];
    [m,n] = size(data_omega);
    start_time = tic;
    for i=1:1:n
        
        data = data_omega(:,i);
        data = data';
        numTimeStepsTrain = floor(numel(data)-(steps+1));

        dataTrain = data(1:numTimeStepsTrain+1);
        dataTest = data(numTimeStepsTrain+1:end);

        mu = mean(dataTrain);
        sig = std(dataTrain);

        dataTrainStandardized = (dataTrain - mu) / sig;
        XTrain = dataTrainStandardized(1:end-1);
        YTrain = dataTrainStandardized(2:end);
        numFeatures = 1;
        numRespceanses = 1;
        numHiddenUnits = 400;

        layers = [ ...
            sequenceInputLayer(numFeatures)
            gruLayer(numHiddenUnits)
            fullyConnectedLayer(numRespceanses)
            regressionLayer];

        options = trainingOptions('adam', ...
            'MaxEpochs',150, ...
            'GradientThreshold',1, ...
            'InitialLearnRate',0.005, ...
            'LearnRateSchedule','piecewise', ...
            'LearnRateDropPeriod',125, ...
            'LearnRateDropFactor',0.2, ...
            'Verbose',0, ...
            'Plots','training-progress');
        net = trainNetwork(XTrain,YTrain,layers,options);

        dataTestStandardized = (dataTest - mu) / sig;
        XTest = dataTestStandardized(1:end-1);

        net = predictAndUpdateState(net,XTrain);
        [net,YPred] = predictAndUpdateState(net,YTrain(end));

        numTimeStepsTest = numel(XTest);
        for i = 2:numTimeStepsTest
            [net,YPred(:,i)] = predictAndUpdateState(net,YPred(:,i-1),'ExecutionEnvironment','cpu');
        end

        YPred = sig*YPred + mu;

        YTest = dataTest(2:end);
        rmse = sqrt(mean((YPred-YTest).^2));
        YPredout=YPred';
        result = [result,YPredout];
    end
end