function createfigure(CData1, ZData1, YData1, XData1)
%CREATEFIGURE(CDATA1, ZDATA1, YDATA1, XDATA1)
%  CDATA1:  surface cdata
%  ZDATA1:  surface zdata
%  YDATA1:  surface ydata
%  XDATA1:  surface xdata

%  Generated by JOHNMATLAB on 04-Oct-2016 21:23:00

% Create figure
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create surface
surface('Parent',axes1,'CData',CData1,'ZData',ZData1,'YData',YData1,...
    'XData',XData1);

view(axes1,[-37.5 30]);
grid(axes1,'on');
