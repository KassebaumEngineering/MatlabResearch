
function child = getChild( p, index )
% getChild - @TreeNode Class Method
%
%     child = getChild( p, index )
%
% Description: Returns the index'th child of the referenced Node.
%
% $Id: getChild.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%

    child = p.getFirstChild();
	for i=1:index
	    if (child.hasSibling()) then
		    child = child.nextSibling();
		else
		    child = [];
			return;
		end
	end
	
% endfunction getChild

%*****************************************************
% History:
% 
% $Log: getChild.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
