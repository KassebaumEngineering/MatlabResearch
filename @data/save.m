
function p = save( p )
% save - data Class Method
%
%     p = save( p )
%
% Description: Save the data object to a file 
% named after the label of the current instance.
%
% $Id: save.m,v 1.1 1997/10/28 18:38:37 jak Exp $
%

  filename = ['data.',p.label,'.mat'];
  save filename p;

% endfunction save

%*****************************************************
% History:
% 
% $Log: save.m,v $
% Revision 1.1  1997/10/28 18:38:37  jak
% Initial revision
%
%
