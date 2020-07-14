function [pd1,pd2,pd3] = createFit(arg_1)
%CREATEFIT    Create plot of datasets and fits
%   [PD1,PD2,PD3] = CREATEFIT(ARG_1)
%   Creates a plot, similar to the plot in the main distribution fitting
%   window, using the data that you provide as input.  You can
%   apply this function to the same data you used with dfittool
%   or with different data.  You may want to edit the function to
%   customize the code and this help message.
%
%   Number of datasets:  1
%   Number of fits:  3
%
%   See also FITDIST.

% This function was automatically generated on 08-Oct-2016 20:43:16

% Output fitted probablility distributions: PD1,PD2,PD3

% Data from dataset "vertical1":
%    Y = arg_1 (originally testdata11(:,1))

% Force all inputs to be column vectors
arg_1 = arg_1(:);

% Prepare figure
clf;
hold on;
LegHandles = []; LegText = {};


% --- Plot data originally in dataset "vertical1"
hLine = probplot('normal',arg_1,[],[],'noref');
set(hLine,'Color',[0.333333 0 0.666667],'Marker','o', 'MarkerSize',6);
xlabel('Data');
ylabel('Probability')
LegHandles(end+1) = hLine;
LegText{end+1} = 'vertical1';


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
hLine = probplot(gca,pd2);
set(hLine,'Color',[0 0 1],'LineStyle','-', 'LineWidth',2);
LegHandles(end+1) = hLine;
LegText{end+1} = 'Normal';

% --- Create fit "fit 5"

% Fit this distribution to get parameter values
% To use parameter estimates from the original fit:
%     pd3 = ProbDistUnivParam('tlocationscale',[ 69399.64504393, 29.57699323418, 1.20581036327])
pd3 = fitdist(arg_1, 'tlocationscale');
% This fit does not appear on the plot

% Adjust figure
box on;
hold off;

% Create legend from accumulated handles and labels
hLegend = legend(LegHandles,LegText,'Orientation', 'vertical', 'FontSize', 9, 'Location', 'northeast');
set(hLegend,'Interpreter','none');
