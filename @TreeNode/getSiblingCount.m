
function count = getSiblingCount( p )
% getSiblingCount - @TreeNode Class Method
%
%     count = getSiblingCount( p )
%
% Description: Get The number of siblings of the referenced Node.
%
% $Id: getSiblingCount.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%

    count = 0;
    sibling = p;
    while ( ~isempty( sibling ) )
	    count = count+1;
	    sibling = getNextSibling( sibling );
	end

% endfunction getSiblingCount

%*****************************************************
% History:
% 
% $Log: getSiblingCount.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
