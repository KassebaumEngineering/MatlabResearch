
function p = addInput( p, signal )
% addInput - data Class Method
%
%     p = addInput( p, signal )
%
% Description: Add a new input variable(s)
% to an established data set.  One must 
% either be adding the first signal vector,
% or the number of samples must be identical
% to the other inputs already in the data set. 
% The signal must have dimensions samples x inputs
%
% $Id: addInput.m,v 1.1.1.1 1997/10/28 18:38:37 jak Exp $
%

  [samples, inputs] = size ( signal );
  if 0 == p.samples
      p.samples = samples;
      p.inputs = inputs;
      p.datamatrix = signal;
  elseif p.samples == samples
      p.inputs = p.inputs + inputs
      p.datamatrix = [ p.datamatrix, signal ];
  else
      fprintf( 1, 'Incompatible number of samples!');
      exit 1 
  end

% endfunction addInput

%*****************************************************
% History:
% 
% $Log: addInput.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:37  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
