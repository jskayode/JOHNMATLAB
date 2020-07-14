function createfigure(xdata1, ydata1)
%CREATEFIGURE(XDATA1, YDATA1)
%  XDATA1:  histogram2 x data
%  YDATA1:  histogram2 y data

%  Generated by JOHNMATLAB on 28-Nov-2015 23:15:52

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);

% Create histogram2
histogram2(xdata1,ydata1,'Parent',axes1,'BinMethod','auto');

% Create xlabel
xlabel({'Distance in UTM'},'FontName','Times New Roman','Rotation',10);

% Create ylabel
ylabel({'Depths to magnetic anomaly sources (m)'},...
    'FontName','Times New Roman',...
    'Rotation',-10);

% Create zlabel
zlabel({'Frequency'},'FontName','Times New Roman');

% Create title
title({'Plots of Depths to magnetic anomaly Sources with Frequency against Distance in UTM'},...
    'FontName','Times New Roman');

view(axes1,[-37.5 30]);
box(axes1,'on');
grid(axes1,'on');
axis(axes1,'tight');