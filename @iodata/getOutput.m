
function Omat = getOutput( p, outputno )
% getOutput - iodata Class Method
%
%     Omat = getOutput( p, outputno )
%
% Description: Get all samples in the 
% data set for the given output variable.
%
% $Id: getOutput.m,v 1.1.1.1 1997/10/28 18:38:38 jak Exp $
%

  Omat = p.outputmatrix( :, outputno );
  
% endfunction getOutput

%*****************************************************
% History:
% 
% $Log: getOutput.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:38  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
