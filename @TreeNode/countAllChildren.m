
function count = countAllChildren( p )
% countAllChildren - @TreeNode Class Method
%
%     count = countAllChildren( p )
%
% Description:
%
% $Id: countAllChildren.m,v 1.1 2000/03/15 09:16:35 jak Exp $
%

     if ( hasChild( p ) ) then
         firstChild = getFirstChild(p);
		 sibling = firstChild;
		 count = countAllChildren( sibling );
		 while hasSibling( sibling ) 
			 sibling = getNextSibling( sibling );
			 count = count + countAllChildren( sibling );
		 end
     else
	     count = 0;
	 end

% endfunction countAllChildren

%*****************************************************
% History:
% 
% $Log: countAllChildren.m,v $
% Revision 1.1  2000/03/15 09:16:35  jak
% Added to count all children recursively. -jak
%
%
