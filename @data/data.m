
function p = data( label, inputSamples, varargin )
% data - data Class Constructor
%
%     p = data( label, inputSamples [, ordered] )
%
% Description: This class is intended to be sub-classed
% for particular data sets.  The set is ordered (=1)
% if it is parametric sequence such as time samples
% in a prediction problem.  Otherwise, each sample 
% is a unique sample without indexed parameterized
% relationship to the other samples.
%
% $Id: data.m,v 1.1 1997/10/28 18:38:37 jak Exp $
%

  p.label = label;

  if isempty( varargin )
      p.ordered = 0; % default not ordered.
  else
      p.ordered = varargin{1};
  end
  
  if 2 ~= ndims( inputSamples )
      fprintf( 1, 'initializer matrix has more than 2 dimensions!');
      exit 1
  end
  [ isamples iinputs ] = size( inputSamples );
  p.samples = isamples;
  p.inputs  = iinputs;
  p.datamatrix = inputSamples;

  p.normalizeWeights = ones( 1, p.inputs );
  p.normailzeBiases = zeros( 1, p.inputs );
  
  p = class( p, 'data');

% endfunction data

%*****************************************************
% History:
% 
% $Log: data.m,v $
% Revision 1.1  1997/10/28 18:38:37  jak
% Initial revision
%
%
