
function count = getChildCount( p )
% getChildCount - @TreeNode Class Method
%
%     count = getChildCount( p )
%
% Description: Get The number of Children of the referenced Node.
%
% $Id: getChildCount.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%

    count = 0;
    child = getFirstChild( p );
    while ( ~isempty( child ) )
	    count = count+1;
	    child = getNextSibling( child );
	end
	
% endfunction getChildCount

%*****************************************************
% History:
% 
% $Log: getChildCount.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
