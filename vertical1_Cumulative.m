function [pd1,pd2,pd3,pd4] = createFit(arg_1)
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2,PD3,PD4] = CREATEFIT(ARG_1)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  4
%
%   See also FITDIST.

% This function was automatically generated on 08-Oct-2016 20:50:45

% Output fitted probablility distributions: PD1,PD2,PD3,PD4

% Data from dataset "vertical1":
%    Y = arg_1 (originally testdata11(:,1))

% Force all inputs to be column vectors
arg_1 = arg_1(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "vertical1"
[CdfY,CdfX] = ecdf(arg_1,'Function','cdf');  % compute empirical function
hLine = stairs(CdfX,CdfY,'Color',[0.333333 0 0.666667],'LineStyle','-', 'LineWidth',1);
xlabel('Data');
ylabel('Cumulative probability')
LegHandles(end+1) = hLine;
LegText{end+1} = 'vertical1';

% Create grid where function will be computed
XLim = get(gca,'XLim');
XLim = XLim + [-1 1] * 0.01 * diff(XLim);
XGrid = linspace(XLim(1),XLim(2),100);


% --- Create fit "vertical1"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd1 = ProbDistUnivParam('rayleigh',[ 49072.35549584])
pd1 = fitdist(arg_1, 'rayleigh');
% This fit does not appear on the plot

% --- Create fit "Normal"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd2 = ProbDistUnivParam('normal',[ 69398.24640523, 275.1520332485])
pd2 = fitdist(arg_1, 'normal');
YPlot = cdf(pd2,XGrid);
hLine = plot(XGrid,YPlot,'Color',[0 0 1],...
    'LineStyle','-', 'LineWidth',2,...
    'Marker','none', 'MarkerSize',6);
LegHandles(end+1) = hLine;
LegText{end+1} = 'Normal';

% --- Create fit "fit 5"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd3 = ProbDistUnivParam('tlocationscale',[ 69399.64504393, 29.57699323418, 1.20581036327])
pd3 = fitdist(arg_1, 'tlocationscale');
% This fit does not appear on the plot

% --- Create fit "fit 7"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd4 = ProbDistUnivParam('rayleigh',[ 49072.35549584])
pd4 = fitdist(arg_1, 'rayleigh');
% This fit does not appear on the plot

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
