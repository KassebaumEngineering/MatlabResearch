
function q = getData( p, label )
% getData - collection Class Method
%
%     q = getData( p, label )
%
% Description: Get the data set with the
% label given as argument.
%
% $Id: getData.m,v 1.1 1997/10/28 18:38:44 jak Exp $
%

  q = data( 'empty', [], []);
  for i=1:p.sets
    if getLabel( p.dataArray(i) ) == label
        q = p.dataArray(i);
        break;
    end
  end
    
% endfunction getData

%*****************************************************
% History:
% 
% $Log: getData.m,v $
% Revision 1.1  1997/10/28 18:38:44  jak
% Initial revision
%
%
