
function Imat = getInput( p, inputno )
% getInput - data Class Method
%
%     Imat = getInput( p, inputno )
%
% Description: This method gets all samples
% in the data set for a particular input.
%
% $Id: getInput.m,v 1.1.1.1 1997/10/28 18:38:37 jak Exp $
%

  Imat = p.datamatrix( :, inputno );

% endfunction getInput

%*****************************************************
% History:
% 
% $Log: getInput.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:37  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
