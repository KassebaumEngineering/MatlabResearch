
function p = save( p )
% save - iodata Class Method
%
%     p = save( p )
%
% Description: Save the data object to a file 
% named after the label of the current instance.
%
% $Id: save.m,v 1.1 1997/10/28 18:38:38 jak Exp $
%

  filename = ['iodata.',getlabel(p),'.mat'];
  save filename p;

% endfunction save

%*****************************************************
% History:
% 
% $Log: save.m,v $
% Revision 1.1  1997/10/28 18:38:38  jak
% Initial revision
%
%
