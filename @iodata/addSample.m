
function p = addSample( p, aSampleInput, aSampleOutput )
% addSample - iodata Class Method
%
%     p = addSample( p, aSampleInput, aSampleOutput )
%
% Description:  Add sample(s) to the
% data set.  The sample must have the
% same number of inputs and outputs as 
% the already present data, or be the 
% first piece of data presented.
%
% $Id: addSample.m,v 1.2 1997/11/18 16:49:09 jak Exp $
%

  [isamples, inputs ] = size ( aSampleInput  );
  [osamples, outputs] = size ( aSampleOutput );
  
  if isamples ~= osamples
      fprintf( 1, 'Incompatible input and output sample sizes!');
      exit 1
  end
  
  %addSample( p.data, aSampleInput );
  if 0 == p.inputs
      p.samples = isamples;
      p.inputs = inputs;
      p.datamatrix = aSampleInput;
  elseif p.inputs == inputs
      p.samples = p.samples + isamples;
      p.datamatrix = [ p.datamatrix', aSampleInput' ]';
  else
      fprintf( 1, 'Incompatible number of input variables!');
      exit 1 
  end
  
  if 0 == p.outputs
      p.outputs = outputs;
      p.outputmatrix = aSampleOutput;
  elseif p.outputs == outputs
      p.outputmatrix = [ p.outputmatrix', aSampleOutput' ]';
  else
      fprintf( 1, 'Incompatible number of output variables!');
      exit 1 
  end

% endfunction addSample

%*****************************************************
% History:
% 
% $Log: addSample.m,v $
% Revision 1.2  1997/11/18 16:49:09  jak
% Fixing a bug for the pns-hnn stuff. -jak
%
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
