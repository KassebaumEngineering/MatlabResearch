
function p = addOutput( p, signal )
% addOutput - iodata Class Method
%
%     p = addOutput( p, signal )
%
% Description: Add a new output variable(s)
% to an established data set.  One must 
% either be adding the first signal vector,
% or the number of samples must be identical
% to the other inputs and outputs already in the data set. 
% The signal must have dimensions samples x new outputs
%
% $Id: addOutput.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

  [samples, outputs] = size ( signal );
  if 0 == p.data.samples
      p.data.samples = samples;
      p.data.inputs = 0;
      p.data.datamatrix = zeros( samples, 0 );
      p.outputs = outputs;
      p.outputmatrix = signal;
  elseif p.data.samples == samples
      p.outputs = p.outputs + outputs
      p.outputmatrix = [ p.outputmatrix, signal ];
  else
      fprintf( 1, 'Incompatible number of samples!');
      exit 1 
  end

% endfunction addOutput

%*****************************************************
% History:
% 
% $Log: addOutput.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
