
function p = restore( p, label )
% restore - iodata Class Method
%
%     p = restore( p, label )
%
% Description: Restore the instance with
% the given label and return it in place
% of p.
%
% $Id: restore.m,v 1.1.1.1 1997/10/28 18:38:39 jak Exp $
%

  filename = ['iodata', label, '.mat' ];
  if exist( filename, 'file')
    p = load( filename );
  else
    fprintf(1, 'No iodata file %s!\n', filename );
  end

% endfunction restore

%*****************************************************
% History:
% 
% $Log: restore.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:39  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
