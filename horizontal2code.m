function horizontal2code(xdata1, ydata1)
%CREATEFIGURE(XDATA1, YDATA1)
%  XDATA1:  histogram2 x data
%  YDATA1:  histogram2 y data

%  Generated by JOHNMATLAB on 10-Dec-2015 12:46:41

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);

% Create histogram2
histogram2(xdata1,ydata1,'Parent',axes1,'BinMethod','auto');

% Create xlabel
xlabel({'Distance in UTM'},'FontName','Times New Roman','Rotation',10);

% Create ylabel
ylabel({'Depths to the magnetic anomaly sources (m)'},...
    'FontName','Times New Roman',...
    'Rotation',-10);

% Create zlabel
zlabel({'Frequency'},'FontName','Times New Roman');

% Create title
title({'Plots of the depths to the magnetic anomaly sources with frequency against distance in UTM'},...
    'FontName','Times New Roman');

view(axes1,[-37.5 30]);
box(axes1,'on');
grid(axes1,'on');
axis(axes1,'tight');
end
end