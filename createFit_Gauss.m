function [fitresult, gof] = createFit_Gauss(month, dataTrain)
%CREATEFIT(MONTH,DATATRAIN)
%  Create a fit.
%
%  Data for 'untitled fit 1' fit:
%      X Input : month
%      Y Output: dataTrain
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%


[xData, yData] = prepareCurveData( month, dataTrain );

ft = fittype( 'gauss3' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';

[fitresult, gof] = fit( xData, yData, ft, opts );

figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'dataTrain vs. month', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );

xlabel( 'month', 'Interpreter', 'none' );
ylabel( 'dataTrain', 'Interpreter', 'none' );
grid on;


