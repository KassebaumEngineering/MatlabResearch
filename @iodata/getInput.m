
function Imat = getInput( p, inputno )
% getInput - @iodata Class Method
%
%     Imat = getInput( p, inputno )
%
% Description: This method gets all input samples
% in the data set for a particular input.
%
% $Id: getInput.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

  %Imat = getInput( p.data, inputno );
  Imat = p.datamatrix( :, inputno );

% endfunction getInput

%*****************************************************
% History:
% 
% $Log: getInput.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
