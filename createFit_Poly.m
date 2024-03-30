function [fitresult, gof] = createFit_Poly(month, dataTrain)

[xData, yData] = prepareCurveData( month, dataTrain );


ft = fittype( 'poly5' );

[fitresult, gof] = fit( xData, yData, ft );

