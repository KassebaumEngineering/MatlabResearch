
function LabelList = getAllLabels( p )
% getAllLabels - collection Class Method
%
%     LabelList = getAllLabels( p )
%
% Description: The getAllLabels() method returns
% a list containing the labels of the data sets
% in the collection.  This is a good way to be
% able to walk through the collection.
%
% $Id: getAllLabels.m,v 1.1 1997/11/04 18:07:39 jak Exp $
%

  LabelList = cell( p.sets, 1 );
  for i=1:p.sets
      LabelList{i, 1} = [ getLabel( p.dataArray(i) ) ];
  end

% endfunction getAllLabels

%*****************************************************
% History:
% 
% $Log: getAllLabels.m,v $
% Revision 1.1  1997/11/04 18:07:39  jak
% Added this method to obtain a list of the contents of a collection. -jak
%
%
