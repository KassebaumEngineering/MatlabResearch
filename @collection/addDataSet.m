
function p = addDataSet( p, varargin )
% addDataSet - collection Class Method
%
%     p = addDataSet( p, <Data Objects> )
%
% Description: Adds a data Set to the collection.
% The collection must all have the same type of
% data - either 'iodata' or 'data'.  Alos, the
% number of inputs and outputs is fixed for the 
% collection.
%
% $Id: addDataSet.m,v 1.1.1.1 1997/10/28 18:38:43 jak Exp $
%

  
  for i=1:nargin-1
      aDataSet = varargin{i};
      
      if -1 == p.hasIoData  % collection is uninitialized
          p = collection( p.label, varargin{:} );
          break;
          
      elseif isa( aDataSet, 'iodata' ) and (1 == p.hasIoData)
          p.sets = p.sets + 1;
          p.dataArray( p.sets ) = aDataSet;

      elseif isa( aDataSet,   'data' ) and (0 == p.hasIoData)
          p.sets = p.sets + 1;
          p.dataArray( p.sets ) = aDataSet;

      else % given data set is incompatible in type with collection
          fprintf( 1, 'Incompatible Data! Cannot add to Collection!');
          exit 1
      end
  end

% endfunction addDataSet

%*****************************************************
% History:
% 
% $Log: addDataSet.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
