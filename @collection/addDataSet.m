
function p = addDataSet( p, varargin )
% addDataSet - collection Class Method
%
%     p = addDataSet( p, <Data Objects> )
%
% Description: Adds a data Set to the collection.
% The collection must all have the same type of
% data - either 'iodata' or 'data'.  Also, the
% number of inputs and outputs is fixed for the 
% collection.
%
% $Id: addDataSet.m,v 1.3 1997/11/18 16:48:26 jak Exp $
%

  for i=1:nargin-1
      aDataSet = varargin{i};
      
      if -1 == p.hasIoData  % collection is uninitialized
          p = collection( p.label, varargin{:} );
          break;
          
      elseif isa( aDataSet, 'iodata' ) & (1 == p.hasIoData)
          p.sets = p.sets + 1;
          p.dataArray( p.sets ) = aDataSet;

      elseif isa( aDataSet,   'data' ) & (0 == p.hasIoData)
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
% Revision 1.3  1997/11/18 16:48:26  jak
% Fixing some problems in dealing with collections. -jak
%
% Revision 1.2  1997/11/07 05:39:56  jak
% Small inconsequential fix. -jak
%
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
