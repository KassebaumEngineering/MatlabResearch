
function tree = getQuantTrees( p, aCount )
% getQuantTrees - @BISTree Class Method
%
%     tree = getQuantTrees( p, aCount )
%
% Description: Return a list of subtrees which have at 
%     least 'aCount' number of leaves.
%
% $Id: getQuantTrees.m,v 1.2 2000/03/15 10:18:35 jak Exp $
%
    tree = TreeNode();
% Need a Heuristic!  
%  -> ummmm...  If the (count of all children / num of all immediate children) 
%               is less than aCount then stop.  That is, only expand
%               all children if on average the number of children in those
%               subtrees is sufficient to meet the criteria.  This
%               heuristic will, no dobt, need improvement.
%
    if ( countAllChildren(p) / getChildCount(p) >= aCount ) then
		node = getFirstChild( p );
		while ( ~isempty( node ) )
		    subtree = getQuantTrees( node, aCount );
			
		  %
		  % Flatten Subtree into tree.
		  %
		    tree.addChild( getFirstChild( subtree ));
		  
			node = getNextSibling( node );
		end
	else
	    tree.setValue( p );
	end
    

% endfunction getQuantTrees

%*****************************************************
% History:
% 
% $Log: getQuantTrees.m,v $
% Revision 1.2  2000/03/15 10:18:35  jak
% Hmmm more fixes?  This should flatten the list. -jak
%
% Revision 1.1  2000/03/15 09:58:13  jak
% More code - to try and extract interesting subtrees. -jak
%
%
