function [] = autoplot(seq, seq_ada, N, save_as, adational_xrange)
%AUTOPLOT 绘制自适应移动平均方法的预测效果图像
%   自动调整和适配画幅的长款比例尺寸
%   [] = autoplot(seq, seq_ada, N, adational_xrange)
% 
% 输入：
% seq              : 一维行向量，一般是原始的时间序列数据
% N                : 权数， w 的个数
% adational_xrange : 额外的 x 的范围，通常用于 "预测未来 N 期" 的情况
% save_as          : 图片保存的路径
% 
% 输出：无
% 会绘制一张描述数据序列变化的折线图
% 默认保存为当前目录下的 ./fig.png
% 有其他图片保存需求的可以添加 
%
% 例子：autoplot([590, 606, 652, 690, 764], ...
%                [0, 0, 0, 0, 711, 792], 4)
% 注意事项：adational_xrange 和 save_as 可有可无
% 文档日期：2023/06/22
% 标签：预测理论
% 创建日期：2023/06/22
% 最后更新日期：2023/06/29

%% 按照具体使用函数时候的参数输入个数来判断
% 如果没有输入 adational_xrange，则默认为 0
if nargin == 3
    save_as = "./fig.png";
elseif nargin == 4
    adational_xrange = 0;
end

%% 绘图

% 绘图设置
grid on;
hold on;

% 绘图范围
xlim([N, (length(seq)+adational_xrange)])
ylim([(min(seq)-(max(seq)-length(seq))), ...
      (max(seq)+(max(seq)-length(seq)))])

% 绘图
plot( seq )
plot( seq_ada )
saveas(gcf, save_as)
end
