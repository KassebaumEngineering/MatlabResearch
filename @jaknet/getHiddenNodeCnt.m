
function Cnt = getHiddenNodeCnt( p )
% getHiddenNodeCnt - mdlnet Class Method
%
%     Cnt = getHiddenNodeCnt( p )
%
% Description:  Return the number of hidden nodes
% in the mdlnet.
%
% $Id: getHiddenNodeCnt.m,v 1.1.1.1 1999/09/19 23:24:57 jak Exp $
%

    Cnt = p.hidden_units ;

% endfunction getHiddenNodeCnt

%*****************************************************
% History:
% 
% $Log: getHiddenNodeCnt.m,v $
% Revision 1.1.1.1  1999/09/19 23:24:57  jak
% Initial checkin of the single shot NW with LMS training method with 
% output of MDL SEC values. -jak
%
%
