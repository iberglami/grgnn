comparisonLstm = readmatrix("./LSTM/hun/comparisonLSTM_2.xls");
comparisonGRU = readmatrix("GRU/hun/comparisonGRU_2.xls");
comparisonCNNLSTM = readmatrix("CNN_LSTM/hun/comparisonCNN_LSTM_2.xls");
comparisonStem = readmatrix("./sTEM/New_stem_hun/hunpredict2");
comparisonOrigin = readmatrix("Slices/hun/2DaySlice.xlsx");
comparisonARIMA = readmatrix("ARIMA\hun\comparisonARIMA_2");
comparisonPoly = readmatrix("Poly\hun\comparisonPoly_2.xls");
comparisonGauss = readmatrix("Gauss\hun\comparisonGauss_2.xls");
comparisonSMA = readmatrix("SMA\hun\comparisonSMA_2.xls");
result = [];
[m,n] = size(comparisonOrigin);
for i = 1:1:n
    yReal = comparisonOrigin(:,i);
    yPred1 = comparisonStem(:,i);
    yPred2 = comparisonLstm(:,i);
    yPred3 = comparisonCNNLSTM(:,i);
    yPred4 = comparisonGRU(:,i);
    yPred5 = comparisonARIMA(:,i);
    yPred6 = comparisonPoly(:,i);
    yPred7 = comparisonGauss(:,i);
    yPred8 = comparisonSMA(:,i);
    [errorStem_M,errorStem_R] = index_compute(yReal,yPred1);
    [errorLstm_M,errorLstm_R] = index_compute(yReal,yPred2);
    [errorCnnlstm_M,errorCnnlstm_R]= index_compute(yReal,yPred3);
    [errorGru_M,errorGru_R] = index_compute(yReal,yPred4);
    [errorARIMA_M,errorARIMA_R] = index_compute(yReal,yPred5);
    [errorPoly_M,errorPoly_R] = index_compute(yReal,yPred6);
    [errorGauss_M,errorGauss_R] = index_compute(yReal,yPred7);
    [errorSMA_M,errorSMA_R] = index_compute(yReal,yPred8);
%     rmse1 = sqrt(mean((yReal-yPred1).^2));
%     rmse2 = sqrt(mean((yReal-yPred2).^2));
%     rmse3 = sqrt(mean((yReal-yPred3).^2));
%     rmse4 = sqrt(mean((yReal-yPred4).^2));
%     mape1 = mean(abs((yReal - yPred1)./yReal));
%     mape2 = mean(abs((yReal - yPred2)./yReal));
%     mape3 = mean(abs((yReal - yPred3)./yReal));
%     mape4 = mean(abs((yReal - yPred4)./yReal));
    result = [result; ...
              errorStem_M,errorLstm_M,errorCnnlstm_M,errorGru_M,errorARIMA_M,errorPoly_M,errorGauss_M,errorSMA_M,...
              errorStem_R,errorLstm_R,errorCnnlstm_R,errorGru_R,errorARIMA_R,errorPoly_R,errorGauss_R,errorSMA_R];
end
title = ["stem","lstm","cnnlstm","gru","arima","poly","gauss","sma","stem","lstm","cnnlstm","gru","arima","poly","gauss","sma"];
result = [title;result];
writematrix(result,"error/hun/comparison_error_2_allright_new3.xlsx");
clear