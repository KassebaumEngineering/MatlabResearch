
function p = addSample( p, aSample )
% addSample - data Class Method
%
%     p = addSample( p, aSample )
%
% Description:  Add sample(s) to the
% data set.  The sample must have the
% same number of inputs as the already
% present data, or be the first piece of
% data present.
%
% $Id: addSample.m,v 1.1.1.1 1997/10/28 18:38:37 jak Exp $
%

  [samples, inputs] = size ( aSample );
  if 0 == p.inputs
      p.samples = samples;
      p.inputs = inputs;
      p.datamatrix = aSample;
  elseif p.inputs == inputs
      p.samples = p.samples + samples;
      p.datamatrix = [ p.datamatrix', aSample' ]';
  else
      fprintf( 1, 'Incompatible number of input variables!');
      exit 1 
  end

% endfunction addSample

%*****************************************************
% History:
% 
% $Log: addSample.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:37  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
