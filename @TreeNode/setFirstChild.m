
function p = setFirstChild( p, aTreeNode )
% setFirstChild - @TreeNode Class Method
%
%     p = setFirstChild( p, aTreeNode )
%
% Description: Sets the TreeNode's firstChild reference.
%
% $Id: setFirstChild.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%
    class TreeNode( aTreeNode );
    p.firstChild = aTreeNode;

% endfunction setFirstChild

%*****************************************************
% History:
% 
% $Log: setFirstChild.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
