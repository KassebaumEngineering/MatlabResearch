
function p = addChild( p, aTreeNode )
% addChild - @TreeNode Class Method
%
%     p = addChild( p, aTreeNode )
%
% Description:
%
% $Id: addChild.m,v 1.2 2000/03/15 09:07:53 jak Exp $
%
    class TreeNode( aTreeNode );

    if ( hasChild( p ) ) then
    	sibling = getFirstChild( p );
		last = sibling;
    	while ( hasSibling( sibling ) )
	    	sibling = getNextSibling( sibling );
		    last = sibling;
		end
	    last.setNextSibling( aTreeNode );
	else
	    p.setFirstChild( aTreeNode );
	end
	
% endfunction addChild

%*****************************************************
% History:
% 
% $Log: addChild.m,v $
% Revision 1.2  2000/03/15 09:07:53  jak
% More changes - do I really need these? -jak
%
% Revision 1.1  2000/03/15 08:46:32  jak
% New function needed. -jak
%
%
