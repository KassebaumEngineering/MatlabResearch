
function p = addSibling( p, aTreeNode )
% addSibling - @TreeNode Class Method
%
%     p = addSibling( p, aTreeNode )
%
% Description:
%
% $Id: addSibling.m,v 1.1 2000/03/15 09:07:53 jak Exp $
%
    class TreeNode( aTreeNode );

    if ( hasSibling( p ) ) then
    	sibling = getNextSibling( p );
		last = sibling;
    	while ( hasSibling( sibling ) )
	    	sibling = getNextSibling( sibling );
		    last = sibling;
		end
	    last.setNextSibling( aTreeNode );
	else
	    p.setNextSibling( aTreeNode );
	end

% endfunction addSibling

%*****************************************************
% History:
% 
% $Log: addSibling.m,v $
% Revision 1.1  2000/03/15 09:07:53  jak
% More changes - do I really need these? -jak
%
%
