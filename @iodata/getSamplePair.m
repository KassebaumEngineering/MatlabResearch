
function [Imat, Omat] = getSamplePair( p, sampleno )
% getSamplePair - iodata Class Method
%
%     p = getSamplePair( p, sampleno )
%
% Description:
%
% $Id: getSamplePair.m,v 1.1 1997/10/28 18:38:39 jak Exp $
%

  Imat = getInputSample( p, sampleno );
  Omat = getOutputSample( p, sampleno );

% endfunction getSamplePair

%*****************************************************
% History:
% 
% $Log: getSamplePair.m,v $
% Revision 1.1  1997/10/28 18:38:39  jak
% Initial revision
%
%
