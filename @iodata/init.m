
function p = init( p, inputDataMat, outputDataMat )
% init - iodata Class Method
%
%     p = init( p, inputDataMat, outputDataMat )
%
% Description:  The iodata init method initializes the
% iodata set with both an input and output data matrix
% of samples.  Each matrix must contain the same number
% of samples.  The matrices must be stored as size 
% samples x variables.  Also, data matrices must be 2 
% dimensional.
%
% $Id: init.m,v 1.1 1997/10/28 18:38:38 jak Exp $
%

  %init( p.data, inputDataMat );
  if 2 ~= ndims( inputDataMat )
      fprintf( 1, 'Data matrix has more than 2 dimensions!');
      exit 1
  end
  [ p.samples p.inputs ] = size( inputDataMat );
  p.datamatrix = inputDataMat;

  
  if 2 ~= ndims( outputDataMatrix )
      fprintf( 1, 'Output Data matrix has more than 2 dimensions!\n');
      exit 1
  end
  [ osamples p.outputs ] = size( outputDataMatrix );
  
  if osamples ~= p.samples
      fprintf( 1, 'Output data has sample count different than input data!\n');
      exit 1
  end
  p.outputmatrix = outputDataMatrix;

% endfunction init

%*****************************************************
% History:
% 
% $Log: init.m,v $
% Revision 1.1  1997/10/28 18:38:38  jak
% Initial revision
%
%
