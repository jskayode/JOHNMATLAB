function [pd1,pd2] = vertical4CumulativeProbplotCode(arg_1)
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2] = CREATEFIT(ARG_1)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  2
%   Number of fits:  2
%
%   See also FITDIST.

% This function was generated on 09-Oct-2016 15:29:43 By JOHNMATLAB

% Output fitted probablility distributions: PD1,PD2

% Data from dataset "vertical4(:,2) data":
%    Y = arg_1 (originally vertical4(:,2))

% Data from dataset "vertical4(:,2) data (2 )":
%    Y = arg_1 (originally vertical4(:,2))

% Force all inputs to be column vectors
arg_1 = arg_1(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "vertical4(:,2) data"
% This dataset does not appear on the plot

% --- Plot data originally in dataset "vertical4(:,2) data (2 )"
[CdfY,CdfX] = ecdf(arg_1,'Function','cdf');  % compute empirical function
hLine = stairs(CdfX,CdfY,'Color',[0.333333 0.666667 0],'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Cumulative probability')
LegHandles(end+1) = hLine;
LegText{end+1} = 'vertical4(:,2) data (2 )';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "vertical4"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('normal',[ -85.43043478261, 98.4229802912])
pd1 = fitdist(arg_1, 'normal');
% This fit does not appear on the plot

% --- Create fit "fit 3"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd2 = ProbDistUnivParam('normal',[ -85.43043478261, 98.4229802912])
pd2 = fitdist(arg_1, 'normal');
YPlot = cdf(pd2,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'fit 3';

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
