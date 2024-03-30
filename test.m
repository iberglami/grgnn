comparisonLstm = xlsread(LSTMPATH);
comparisonGRU = xlsread(GRUPATH);
comparisonCNNLSTM = xlsread(CNNLSTMPATH);
comparisongrgnn = csvread(GRGNNPATH);
comparisonOrigin = xlsread(ORIGINPATH);
comparisonARIMA = xlsread(ARIMAPATH);
comparisonSMA = xlsread(SMAPATH);
result = [];
[m,n] = size(comparisonOrigin);
for i = 1:1:n
    yReal = comparisonOrigin(:,i);
    yPred1 = comparisongrgnn(:,i);
    yPred2 = comparisonLstm(:,i);
    yPred3 = comparisonCNNLSTM(:,i);
    yPred4 = comparisonGRU(:,i);
    yPred5 = comparisonARIMA(:,i);
    yPred6 = comparisonSMA(:,i);
    [errorgrgnn_M,errorgrgnn_R] = index_compute(yReal,yPred1);
    [errorLstm_M,errorLstm_R] = index_compute(yReal,yPred2);
    [errorCnnlstm_M,errorCnnlstm_R]= index_compute(yReal,yPred3);
    [errorGru_M,errorGru_R] = index_compute(yReal,yPred4);
    [errorARIMA_M,errorARIMA_R] = index_compute(yReal,yPred5);
    [errorSMA_M,errorSMA_R] = index_compute(yReal,yPred5);

    result = [result; errorgrgnn_M,errorLstm_M,errorCnnlstm_M,errorGru_M,errorSMA_M,errorARIMA_M,[],errorgrgnn_R,errorLstm_R,errorCnnlstm_R,errorGru_R,errorARIMA_R,errorSMA_R];
end
writematrix(result,resultpath);
clear