
function bool = hasValue( p )
% hasValue - @TreeNode Class Method
%
%     bool = hasValue( p )
%
% Description:  Returns true if the value is not empty.
%
% $Id: hasValue.m,v 1.1 2000/03/15 07:59:19 jak Exp $
%
    bool = ~isempty( p.value );

% endfunction hasValue

%*****************************************************
% History:
% 
% $Log: hasValue.m,v $
% Revision 1.1  2000/03/15 07:59:19  jak
% Added a helper class for Tree Structures. -jak
%
%
