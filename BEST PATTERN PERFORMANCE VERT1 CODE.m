function createfigure(X1, YMatrix1, X2, Y1, X3, Y2, X4, Y3)
%CREATEFIGURE(X1, YMATRIX1, X2, Y1, X3, Y2, X4, Y3)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data
%  X2:  vector of x data
%  Y1:  vector of y data
%  X3:  vector of x data
%  Y2:  vector of y data
%  X4:  vector of x data
%  Y3:  vector of y data

% By JOHNMATLAB on 26-Oct-2016 06:23:40

% Create figure
figure1 = figure('Tag','TRAINING_PLOTPERFORM','NumberTitle','off',...
    'Name','Neural Network Training Performance (plotperform), Epoch 30, Minimum gradient reached.');

% Create axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% Create multiple lines using matrix input to semilogy
semilogy1 = semilogy(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(semilogy1(1),'DisplayName','Train','Color',[0 0 1]);
set(semilogy1(2),'DisplayName','Validation','Color',[0 0.8 0]);
set(semilogy1(3),'DisplayName','Test','Color',[1 0 0]);

% Create semilogy
semilogy(X2,Y1,'DisplayName','Best','LineStyle',':','Color',[0 0.48 0]);

% Create semilogy
semilogy(X3,Y2,'MarkerSize',16,'Marker','o','LineWidth',1.5,...
    'LineStyle','none',...
    'Color',[0 0.48 0]);

% Create semilogy
semilogy(X4,Y3,'LineStyle',':','Color',[0 0 0]);

% Create xlabel
xlabel('30 Epochs','FontWeight','bold','FontSize',12);

% Create title
title('Best Validation Performance is 2.4131e-07 at epoch 30',...
    'FontWeight','bold',...
    'FontSize',12);

% Create ylabel
ylabel('Cross-Entropy  (crossentropy)','FontWeight','bold','FontSize',12);

% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[0 30]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[9e-08 1.1]);
% Set the remaining axes properties
set(axes1,'YMinorTick','on','YScale','log');
% Create legend
legend(axes1,'show');

% uicontrol currently does not support code generation, enter 'doc uicontrol' for correct input syntax
% In order to generate code for uicontrol, you may use GUIDE. Enter 'doc guide' for more information
% uicontrol(...);

