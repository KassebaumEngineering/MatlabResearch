
function p = setNextSibling( p, aTreeNode )
% setNextSibling - @TreeNode Class Method
%
%     p = setNextSibling( p, aTreeNode )
%
% Description: Sets the TreeNode's nextSibling reference.
%
% $Id: setNextSibling.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%
    class TreeNode( aTreeNode );
    p.nextSibling = aTreeNode;

% endfunction setNextSibling

%*****************************************************
% History:
% 
% $Log: setNextSibling.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
