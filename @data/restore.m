
function p = restore( p, label )
% restore - data Class Method
%
%     p = restore( p, label )
%
% Description: Restore the instance with
% the given label and return it in place
% of p.
%
% $Id: restore.m,v 1.1.1.1 1997/10/28 18:38:38 jak Exp $
%

  filename = ['data', label, '.mat' ];
  if exist( filename, 'file')
    p = load( filename );
  else
    fprintf(1, 'No data file %s!', filename );
  end

% endfunction restore

%*****************************************************
% History:
% 
% $Log: restore.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:38  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
