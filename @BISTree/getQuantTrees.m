
function tree = getQuantTrees( p, aCount )
% getQuantTrees - @BISTree Class Method
%
%     tree = getQuantTrees( p, aCount )
%
% Description: Return a list of subtrees which have at 
%     least 'aCount' number of leaves.
%
% $Id: getQuantTrees.m,v 1.1 2000/03/15 09:58:13 jak Exp $
%

% Need a Heuristic!  
%  -> ummmm...  If the (count of all children / num of all immediate children) 
%               is less than aCount then stop.  That is, only expand
%               all children if on average the number of children in those
%               subtrees is sufficient to meet the criteria.  This
%               heuristic will, no dobt, need improvement.
%
    if ( countAllChildren(p) / getChildCount(p) >= aCount ) then
		node = getFirstChild( rootNode );
		while ( hasSibling( node ) )
		    sibling = getQuantTrees( node, aCount );
		    node.setNextSibling( sibling );
			node = sibling;
		end
	else
	    tree = TreeNode();
	    tree.setValue( p );
	end
    

% endfunction getQuantTrees

%*****************************************************
% History:
% 
% $Log: getQuantTrees.m,v $
% Revision 1.1  2000/03/15 09:58:13  jak
% More code - to try and extract interesting subtrees. -jak
%
%
