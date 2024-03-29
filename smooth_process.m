Origin_M = readmatrix(datapath);
a = [];
[m,n] = size(Origin_M);
for n=1:1:n
    slice = Origin_M(:,n);
    yy1 = smooth(slice,7);
%     figure;
%     plot(yy1);
%     hold on;
%     plot(slice,'k','LineStyle','--')
    a = [a,slice];
end
xlswrite(resultpath,a);