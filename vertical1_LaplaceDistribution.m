classdef LaplaceDistribution < prob.ToolboxFittableParametricDistribution
% This is a sample implementation of the Laplace distribution. You can use
% this template as a model to implement your own distribution. Create a
% directory called '+prob' somewhere on your path, and save this file in
% that directory using a name that matches your distribution name.
%
%    An object of the LaplaceDistribution class represents a Laplace
%    probability distribution with a specific location parameter MU and
%    scale parameter SIGMA. This distribution object can be created directly
%    using the MAKEDIST function or fit to data using the FITDIST function.
%
%    LaplaceDistribution methods:
%       cdf                   - Cumulative distribution function
%       fit                   - Fit distribution to data
%       icdf                  - Inverse cumulative distribution function
%       iqr                   - Interquartile range
%       mean                  - Mean
%       median                - Median
%       paramci               - Confidence intervals for parameters
%       pdf                   - Probability density function
%       proflik               - Profile likelihood function
%       random                - Random number generation
%       std                   - Standard deviation
%       truncate              - Truncation distribution to an interval
%       var                   - Variance
%
%    LaplaceDistribution properties:    
%       DistributionName      - Name of the distribution
%       mu                    - Value of the mu parameter
%       sigma                 - Value of the sigma parameter
%       NumParameters         - Number of parameters
%       ParameterNames        - Names of parameters
%       ParameterDescription  - Descriptions of parameters
%       ParameterValues       - Vector of values of parameters
%       Truncation            - Two-element vector indicating truncation limits
%       IsTruncated           - Boolean flag indicating if distribution is truncated
%       ParameterCovariance   - Covariance matrix of estimated parameters
%       ParameterIsFixed      - Two-element boolean vector indicating fixed parameters
%       InputData             - Structure containing data used to fit the distribution
%       NegativeLogLikelihood - Value of negative log likelihood function
%
%    See also fitdist, makedist.

    % All ProbabilityDistribution objects must specify a DistributionName
    properties(Constant)
%DistributionName Name of distribution
%    DistributionName is the name of this distribution.
        DistributionName = 'laplace';
    end

    % Optionally add your own properties here. For this distribution it's convenient
    % to be able to refer to the mu and sigma parameters by name, and have them
    % connected to the proper element of the ParameterValues property. These are
    % dependent properties because they depend on ParameterValues.
    properties(Dependent=true)
%MU Location parameter
%    MU is the location parameter for this distribution.
        mu
        
%SIGMA Scale parameter
%    SIGMA is the scale parameter for this distribution.
        sigma
    end
    
    % All ParametricDistribution objects must specify values for the following
    % constant properties (they are the same for all instances of this class).
    properties(Constant)
%NumParameters Number of parameters
%    NumParameters is the number of parameters in this distribution.

        NumParameters = 2;
        
%ParameterName Name of parameter
%    ParameterName is a two-element cell array containing names
%    of the parameters of this distribution.
        ParameterNames = {'mu' 'sigma'};
        
%ParameterDescription Description of parameter
%    ParameterDescription is a two-element cell array containing
%    descriptions of the parameters of this distribution.
        ParameterDescription = {'location' 'scale'};
    end

    % All ParametricDistribution objects must include a ParameterValues property
    % whose value is a vector of the parameter values, in the same order as
    % given in the ParameterNames property above.
    properties(GetAccess='public',SetAccess='protected')
%ParameterValues Values of the distribution parameters
%    ParameterValues is a two-element vector containing the mu and sigma
%    values of this distribution.
        ParameterValues
    end

    methods
        % The constructor for this class can be called with a set of parameter
        % values or it can supply default values. These values should be
        % checked to make sure they are valid. They should be stored in the
        % ParameterValues property.
        function pd = LaplaceDistribution(mu,sigma)
            if nargin==0
                mu = 0;
                sigma = 1;
            end
            checkargs(mu,sigma);
            
            pd.ParameterValues = [mu sigma];
            
            % All FittableParametricDistribution objects must assign values
            % to the following two properties. When an object is created by
            % the constructor, all parameters are fixed and the covariance
            % matrix is entirely zero.
            pd.ParameterIsFixed = [true true];
            pd.ParameterCovariance = zeros(pd.NumParameters);
        end
        
        % Implement methods to compute the mean, variance, and standard
        % deviation.
        function m = mean(this)
            m = this.mu;
        end
        function s = std(this)
            s = sqrt(2)*this.sigma;
        end
        function v = var(this)
            v = 2*this.sigma^2;
        end
    end
    methods
        % If this class defines dependent properties to represent parameter
        % values, their get and set methods must be defined. The set method
        % should mark the distribution as no longer fitted, because any
        % old results such as the covariance matrix are not valid when the
        % parameters are changed from their estimated values.
        function this = set.mu(this,mu)
            checkargs(mu,this.sigma);
            this.ParameterValues(1) = mu;
            this = invalidateFit(this);
        end
        function this = set.sigma(this,sigma)
            checkargs(this.mu,sigma);
            this.ParameterValues(2) = sigma;
            this = invalidateFit(this);
        end
        function mu = get.mu(this)
            mu = this.ParameterValues(1);
        end
        function sigma = get.sigma(this)
            sigma = this.ParameterValues(2);
        end
    end
    methods(Static)
        % All FittableDistribution classes must implement a fit method to fit
        % the distribution from data. This method is called by the FITDIST
        % function, and is not intended to be called directly
        function pd = fit(x,varargin)
%FIT Fit from data
%   P = prob.LaplaceDistribution.fit(x)
%   P = prob.LaplaceDistribution.fit(x, NAME1,VAL1, NAME2,VAL2, ...)
%   with the following optional parameter name/value pairs:
%
%          'censoring'    Boolean vector indicating censored x values
%          'frequency'    Vector indicating frequencies of corresponding
%                         x values
%          'options'      Options structure for fitting, as create by
%                         the STATSET function

            % Get the optional arguments. The fourth output would be the
            % options structure, but this function doesn't use that.
            [x,cens,freq] = prob.ToolboxFittableParametricDistribution.processFitArgs(x,varargin{:});

            % This distribution was not written to support censoring or to process
            % a frequency vector. The following utility expands x by the frequency
            % vector, and displays an error message if there is censoring.
            x = prob.ToolboxFittableParametricDistribution.removeCensoring(x,cens,freq,'laplace');
            freq = ones(size(x));

            % Estimate the parameters from the data. If this is an iterative procedure,
            % use the values in the opt argument.
            m = median(x);
            s = mean(abs(x-m));

            % Create the distribution by calling the constructor.
            pd = prob.LaplaceDistribution(m,s);
            
            % Fill in remaining properties defined above
            pd.ParameterIsFixed = [false false];
            [nll,acov] = prob.LaplaceDistribution.likefunc([m s],x);
            pd.ParameterCovariance = acov;

            % Assign properties required for the FittableDistribution class
            pd.NegativeLogLikelihood = nll;
            pd.InputData = struct('data',x,'cens',[],'freq',freq);
        end

        % The following static methods are required for the
        % ToolboxParametricDistribution class and are used by various
        % Statistics and Machine Learning Toolbox functions. These functions operate on
        % parameter values supplied as input arguments, not on the
        % parameter values stored in a LaplaceDistribution object. For
        % example, the cdf method implemented in a parent class invokes the
        % cdffunc static method and provides it with the parameter values.
        function [nll,acov] = likefunc(params,x) % likelihood function
            n = length(x);
            mu = params(1);
            sigma = params(2);
            
            nll = -sum(log(prob.LaplaceDistribution.pdffunc(x,mu,sigma)));
            acov = (sigma^2/n) * eye(2);
        end
        function y = cdffunc(x,mu,sigma)          % cumulative distribution function
            if sigma==0
                y = double(x>=mu);
            else
                z = (x-mu) ./ sigma;
                y = 0.5 + sign(z).*(1-exp(-abs(z)))/2;
            end
            y(isnan(x)) = NaN;
        end
        function y = pdffunc(x,mu,sigma)         % probability density function
            y = exp(-abs(x - mu)/sigma) / (2*sigma);
        end
        function y = invfunc(p,mu,sigma)         % inverse cdf
            if nargin<2, mu = 0; end
            if nargin<2, sigma = 1; end
            if sigma==0
                y = mu + zeros(size(p));
            else
                u = p-0.5;
                y = mu - sigma.*sign(u).*log(1-2*abs(u));
            end
            y(p < 0 | 1 < p) = NaN;
        end
        function y = randfunc(mu,sigma,varargin) % random number generator
            y = prob.LaplaceDistribution.invfunc(rand(varargin{:}),mu,sigma);
        end
    end
    methods(Static,Hidden)
        % All ToolboxDistributions must implement a getInfo static method
        % so that Statistics and Machine Learning Toolbox functions can get information about
        % the distribution.
        function info = getInfo
            
            % First get default info from parent class
            info = getInfo@prob.ToolboxFittableParametricDistribution('prob.LaplaceDistribution');
            
            % Then override fields as necessary
            info.name = 'Laplace';
            info.code = 'laplace';
            % info.pnames is obtained from the ParameterNames property
            % info.pdescription is obtained from the ParameterDescription property
            % info.prequired = [false false] % Change if any parameter must
                                             % be specified before fitting.
                                             % An example would be the N
                                             % parameter of the binomial
                                             % distribution.
            % info.hasconfbounds = false     % Set to true if the cdf and
                                             % icdf methods can return
                                             % lower and upper bounds as
                                             % their 2nd and 3rd outputs.
            % censoring = false              % Set to true if the fit
                                             % method supports censoring.
            % info.support = [-Inf, Inf]     % Set to other lower and upper
                                             % bounds if the distribution
                                             % doesn't cover the whole real
                                             % line. For example, for a
                                             % distribution on positive
                                             % values use [0, Inf].
            % info.closedbound = [false false] % Set the Jth value to
                                             % true if the distribution
                                             % allows x to be equal to the
                                             % Jth element of the support
                                             % vector.
            % info.iscontinuous = true       % Set to false if x can take
                                             % only integer values.
            info.islocscale = true;          % Set to true if this is a
                                             % location/scale distribution
                                             % (no other parameters).
            % info.uselogpp = false          % Set to true if a probability
                                             % plot should be drawn on the
                                             % log scale.
            % info.optimopts = false         % Set to true if the fit
                                             % method can be called with an
                                             % options structure.
            info.logci = [false true];       % Set to true for a parameter
                                             % that should have its Wald
                                             % confidence interval computed
                                             % using a normal approximation
                                             % on the log scale.
        end
    end
end % classdef

% The following utilities check for valid parameter values
function checkargs(mu,sigma)
if ~(isscalar(mu) && isnumeric(mu) && isreal(mu) && isfinite(mu))
    error('MU must be a real finite numeric scalar.')
end
if ~(isscalar(sigma) && isnumeric(sigma) && isreal(sigma) && sigma>=0 && isfinite(sigma))
    error('SIGMA must be a positive finite numeric scalar.')
end
end
