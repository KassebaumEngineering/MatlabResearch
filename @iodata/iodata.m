
function p = iodata( label, inputSamples, outputSamples, varargin )
% iodata - iodata Class Constructor Method
%
%     p = iodata( label, inputSamples, outputSamples[, ordered])
%
% Description: The contructor builds an iodata object
% initialized by the inputSamples and outputSamples 
% initial data matrices.  The set is ordered (=1)
% if it is parametric sequence such as time samples
% in a prediction problem.  Otherwise, each sample 
% is a unique sample without indexed parameterized
% relationship to the other samples
%
% $Id: iodata.m,v 1.1.1.1 1997/10/28 18:38:38 jak Exp $
%

  if 2 ~= ndims( outputSamples )
      fprintf( 1, 'Output Data matrix has more than 2 dimensions!');
      exit 1
  end
  if 2 ~= ndims( inputSamples )
      fprintf( 1, 'Input Data matrix has more than 2 dimensions!');
      exit 1
  end

  [ osamples outputs ] = size( outputSamples );
  [ isamples inputs  ] = size( inputSamples );
  
  if osamples ~= isamples
      fprintf( 1, 'Output data has sample count different than input data!');
      exit 1
  end
  p.outputmatrix = outputSamples;
  p.outputs = outputs;
  
  %
  % From data contructor
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

  p.samples = isamples;
  p.inputs  = inputs;
  p.datamatrix = inputSamples;

  p.normalizeWeights = ones( 1, p.inputs );
  p.normailzeBiases = zeros( 1, p.inputs );
  %
  % ---------------------
  %

  % inherits from class 'data'
  %if isempty( varargin )
  %    parent = data( label, inputSamples, 0 );
  %else
  %    parent = data( label, inputSamples, varargin{1} );
  %end
 
  p = class( p, 'iodata' );
  
% endfunction iodata

%*****************************************************
% History:
% 
% $Log: iodata.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:38  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
