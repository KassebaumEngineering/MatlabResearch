
function p = collection( label , varargin )
% collection - collection Class Constructor
%
%     p = collection( label, <Data Objects> )
%
% Description:  A bag of regular data or iodata Objects
% Each data set must be compatible, which means the
% number of samples may vary, but input dimensions
% and output dimensions (if applicable) must be
% the same for each element in the collection. The
% collection may have either 'data', or 'iodata' 
% elements.  Since each data object has a label,
% it may be retrieved individually by that label.
%
% $Id: collection.m,v 1.1.1.1 1997/10/28 18:38:43 jak Exp $
%
  
  p.label = label;
  p.sets  = nargin-1;
  p.inputs = -1;
  p.outputs = -1;
  p.hasIoData = -1;
  
  for i=1:p.sets
  
      if -1 == p.hasIoData 
          if isa( varargin{i}, 'iodata' )
              p.dataArray(i) = varargin{i};
              p.hasIoData = 1;
              p.inputs  = getInputSize ( p.dataArray(i) );
              p.outputs = getOutputSize( p.dataArray(i) );
          elseif isa( varargin{i}, 'data' )
              p.dataArray(i) = varargin{i};
              p.hasIoData = 0;
              p.inputs  = getInputSize ( p.dataArray(i) );
          else
              fprintf( 1, 'collection error! arg %d is not a "data" object!', i+1 );
              exit 1
          end
          
      elseif isa( varargin{i},   'data' ) & (0 == p.hasIoData)
          p.dataArray(i) = varargin{i};
          if getInputSize( p.dataArray(i) ) ~= p.inputs
              fprintf( 1, 'Incompatible data input dimensions!' );
              exit 1
          end
      
      elseif isa( varargin{i}, 'iodata' ) & (1 == p.hasIoData)
          p.dataArray(i) = varargin{i};
          if  getInputSize( p.dataArray(i) ) ~= p.inputs
              fprintf( 1, 'Incompatible data input dimensions!' );
              exit 1
          end
          if getOutputSize( p.dataArray(i) ) ~= p.outputs
              fprintf( 1, 'Incompatible data output dimensions!');
              exit 1
          end
          
      else
          fprintf( 1, 'collection error! Mixed "iodata" and "data" objects!' );
          exit 1
      end
  end
  
  p = class( p, 'collection' );

% endfunction collection

%*****************************************************
% History:
% 
% $Log: collection.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
