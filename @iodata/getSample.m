
function Smat = getSample( p, sampleno )
% getSample - @iodata Class Method
%
%     Smat = getSample( p, sampleno )
%
% Description: Return samples from the 
% input data of the data set.
%
% $Id: getSample.m,v 1.1 1997/10/28 18:38:40 jak Exp $
%

  %Smat = getSample( p.data, sampleno );
  Smat = p.datamatrix( sampleno, : );
  
% endfunction getSample

%*****************************************************
% History:
% 
% $Log: getSample.m,v $
% Revision 1.1  1997/10/28 18:38:40  jak
% Initial revision
%
%
