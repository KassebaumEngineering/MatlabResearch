
function p = normalize( p, rangeMin, rangeMax )
% normalize - data Class Method
%
%     p = normalize( p [, rangeMin, rangeMax] )
%
% Description:  Normalize the data set to 
% to within the stated rangeMin and rangeMax.
% The default rangeMin and rangeMax are 0 and
% 1 respectively.
%
% $Id: normalize.m,v 1.1.1.1 1997/10/28 18:38:37 jak Exp $
%

  MIN = 1;
  MAX = 2;
  dataRange = zeros( 2, getInputSize(p) );
  dataRange(MIN,:) = min( p.datamatrix );
  dataRange(MAX,:) = max( p.datamatrix );
  
  scale = dataRange( MAX, : ) - dataRange( MIN, : );
  for i=1:getInputSize(p)
      scale( i ) = 1/scale( i );
  end
  shift = - dataRange( MIN, : );
  
  if 3 == nargin()
      scale = scale * (rangeMax - rangeMin);
      shift = shift + rangeMin;
  end
  
  for i = 1:getInputSize(p)
      p.datamatrix(:,i) = p.datamatrix(:,i) * scale(i) + shift(i); 
  end
  
  p.normalizeWeights = scale;
  p.normalizeBiases = shift;

% endfunction normalize

%*****************************************************
% History:
% 
% $Log: normalize.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:37  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
