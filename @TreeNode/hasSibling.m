
function p = hasSibling( p )
% hasSibling - @TreeNode Class Method
%
%     p = hasSibling( p )
%
% Description: Returns true if the next sibling is not empty.
%
% $Id: hasSibling.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%
    bool = ~isempty( getNextSibling( p ) );
	
% endfunction hasSibling

%*****************************************************
% History:
% 
% $Log: hasSibling.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
