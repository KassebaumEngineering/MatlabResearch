
function bool = hasLeafReference( p )
% hasLeafReference - @TreeNode Class Method
%
%     bool = hasLeafReference( p )
%
% Description:
%
% $Id: hasLeafReference.m,v 1.1 2000/03/15 09:55:25 jak Exp $
%
    bool = ~isempty( p.leafReference );
    
% endfunction hasLeafReference

%*****************************************************
% History:
% 
% $Log: hasLeafReference.m,v $
% Revision 1.1  2000/03/15 09:55:25  jak
% New methods to handle leaves. -jak
%
%
