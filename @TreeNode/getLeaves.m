
function tree = getLeaves( p )
% getLeaves - @TreeNode Class Method
%
%     tree = getLeaves( p )
%
% Description:
%
% $Id: getLeaves.m,v 1.1 2000/03/15 10:37:52 jak Exp $
%
    tree = TreeNode();
	
    if hasChild( node ) then
    	node = getFirstChild( p );
		while ( ~isempty( node ) )
			subtree = getLeaves( node );

		  %
		  % Flatten Subtree into tree.
		  %
			tree.addChild( getFirstChild( subtree ));

			node = getNextSibling( node );
		end
	else
	    tree.setValue( p );
	end

	
% endfunction getLeaves

%*****************************************************
% History:
% 
% $Log: getLeaves.m,v $
% Revision 1.1  2000/03/15 10:37:52  jak
% Added a method to get all the leaves of a tree. -jak
%
%
