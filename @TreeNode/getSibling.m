
function sibling = getSibling( p, index )
% getSibling - @TreeNode Class Method
%
%     sibling = getSibling( p, index )
%
% Description: Returns the index'th sibling of the referenced Node.
%
% $Id: getSibling.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%

    sibling = p;
	for i=1:index
	    if (sibling.hasSibling()) then
		    sibling = sibling.getNextSibling();
		else
		    sibling = [];
			return;
		end
	end

% endfunction getSibling

%*****************************************************
% History:
% 
% $Log: getSibling.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
