
function bool = hasChild( p )
% hasChild - @TreeNode Class Method
%
%     bool = hasChild( p )
%
% Description: Returns true if the first child is not empty.
%
% $Id: hasChild.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%
    bool = ~isempty( getFirstChild( p ) );
	
% endfunction hasChild

%*****************************************************
% History:
% 
% $Log: hasChild.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
