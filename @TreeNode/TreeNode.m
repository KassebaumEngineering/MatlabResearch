
function p = TreeNode()
% TreeNode - @TreeNode Class Method
%
%     p = TreeNode()
%
% Description: Makes a TreeNode.
%
% $Id: TreeNode.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%

    p = struct( ...
	    'value',			[]		...
	   ,'nextSibling',		[]		...
	   ,'firstChild',		[]		...
	);
	
    p = class( p, '@TreeNode');

% endfunction TreeNode

%*****************************************************
% History:
% 
% $Log: TreeNode.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
