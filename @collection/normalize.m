
function p = normalize( p, rangeMin, rangeMax )
% normalize - collection Class Method
%
%     p = normalize( p[, rangeMin, rangeMax] )
%
% Description:
%
% $Id: normalize.m,v 1.1.1.1 1997/10/28 18:38:44 jak Exp $
%

  if isempty( rangeMin ) or isempty( rangeMax )
      for i=1:p.sets
          normalize( p.dataArray(i) );
      end
  else
      for i=1:p.sets
          normalize( p.dataArray(i), rangeMin, rangeMax);
      end
  end

% endfunction normalize

%*****************************************************
% History:
% 
% $Log: normalize.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:44  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
