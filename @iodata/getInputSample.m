
function Smat = getInputSample( p, sampleno )
% getInputSample - iodata Class Method
%
%     Smat = getInputSample( p, sampleno )
%
% Description:
%
% $Id: getInputSample.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

  %Smat = getSample( p.data, sampleno );
  Smat = p.datamatrix( sampleno, : );

% endfunction getInputSample

%*****************************************************
% History:
% 
% $Log: getInputSample.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
