
function Smat = getSample( p, sampleno )
% getSample - data Class Method
%
%     Smat = getSample( p, sampleno )
%
% Description: Return samples from the 
% data set.
%
% $Id: getSample.m,v 1.1.1.1 1997/10/28 18:38:38 jak Exp $
%

  Smat = p.datamatrix( sampleno, : );
  
% endfunction getSample

%*****************************************************
% History:
% 
% $Log: getSample.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:38  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
