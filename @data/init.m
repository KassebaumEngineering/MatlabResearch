
function p = init( p, aDataMatrix )
% init - data Class Method
%
%     p = init( p, aDataMatrix )
%
% Description: The init method initializes the
% data set with a matrix of samples, and sets the
% samples and inputs variables of the data set from
% the dimensions of the entered matrix. The argument
% data matrix must be of size samples x inputs.  Also,
% data matrices must be 2 dimensional.
%
% $Id: init.m,v 1.1.1.1 1997/10/28 18:38:38 jak Exp $
%

  if 2 ~= ndims( aDataMatrix )
      fprintf( 1, 'Data matrix has more than 2 dimensions!');
      exit 1
  end
  [ p.samples p.inputs ] = size( aDataMatrix );
  p.datamatrix = aDataMatrix;

% endfunction init

%*****************************************************
% History:
% 
% $Log: init.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:38  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
