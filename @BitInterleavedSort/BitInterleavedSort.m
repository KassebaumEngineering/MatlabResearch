
function p = BitInterleavedSort( imat, quantiles )
% BitInterleavedSort - Constructor for BitInterleavedSort-ed Object
%
%     p = BitInterleavedSort(imat, quantiles);
%
% Description:  The BitInterleavedSort Object is a  
% bit-interleaved matrix made from the rows of the input matrix 
% and requested quantiles (log2(quantization levels)) which is sorted
% so that neighboring rows are near each other.  It also 
% return an index matrix which is the permutaion returned from sort() 
% which transforms the input matrix to the same row order as the 
% row-sorted bit-interleaved matrix.  The returned matrix will have
% dimensions of Rows x (Quantiles*Cols) - where Rows and Cols is the 
% number of rows and columns in the input matrix).  It will contain
% the character '0', or '1' for each bit of each row of the input matrix. 
% The 'bits' are ordered from msb to lsb, and from left-most column to 
% right-most column, interleaved and sorted by rows.  (e.g. The first
% 'Cols' number of characters is the most significant bit from the elements
% of each column,  The next 'Cols' number of chars is the 2nd msb of each
% column. ... etc. There will be Quantile blocks of these 'Cols' number of 
% characters.)
%
% Note: This works well when each row of a matrix is a 'cols'-dimensional
% vector value.  For hidden nodes of a neural net (where each column is a
% hidden unit, the matrix should be transposed.
%
%
% $Id: BitInterleavedSort.m,v 1.1 1999/10/20 23:02:40 jak Exp $
%
% 
    [ rows, cols ] = size( imat );
    maxval = (2^quantiles) - 1;

    p = struct( ...
        'rows'           , rows                 ...
       ,'cols'           , cols                 ...
       ,'quantiles'      , quantiles            ...
       ,'scale'          , []                   ...
       ,'offset'         , []                   ...
       ,'rangemin'       , []                   ...
       ,'rangemax'       , []                   ...
       ,'bis_mat'        , []                   ...
       ,'index_mat'      , []                   ...
    );
    
    p = class( p, 'BitInterleavedSort' ); 
    
    p.scale     = zeros( 1, cols );
    p.offset    = zeros( 1, cols );
    p.rangemin  = min( imat );
    p.rangemax  = max( imat );
    p.bis_mat   = cell( rows, quantiles );
    p.index_mat = zeros( rows, 1 );

  %
  % Discover Min and Max Values of Columns - data ranges
  %
    for c=1:cols 
         p.scale( 1, c ) = maxval / ( p.rangemax( 1, c ) - p.rangemin( 1, c ) );
        p.offset( 1, c ) = p.rangemin( 1, c );
        %
        %  Note: to use these ... subtract offset first then multiply by scale.
        %
    end
  %
   
  %
  % Scale Matrix Quantities to requested quantiles
  %
    smat = zeros( rows, cols );
    for r=1:rows
        for c=1:cols 
            smat( r, c ) = round( p.scale( 1, c ) * (imat( r, c ) - p.offset( 1, c )) );
        end
    end
    
  %
  % Generate Bit-Interleaved Output Matrix
  %
    omat = char( rows, cols*quantiles );
    for r=1:rows
        for q=1:quantiles
            mask = bitshift( 1, q-1 );
            for c=1:cols 
                if ( bitand( smat( r, c ), mask ) ~= 0 )
                    omat( r, (q-1)*cols + c ) = '1'; 
                else 
                    omat( r, (q-1)*cols + c ) = '0'; 
                end
            end
        end
    end
  %
    
  %
  % Sort Rows of Bit-Interleaved Output Matrix
  %
    [ omat, p.index_mat ] = sortrows( omat );
  %
  % Set Up Cell Array
  %
    for r=1:rows
        for q=1:quantiles
            p.bis_mat(r,q) = { omat( r, (q-1)*cols+1:q*cols ) };
        end
    end
  
%endfunction

% --------------------------------
% History:
% $Log: BitInterleavedSort.m,v $
% Revision 1.1  1999/10/20 23:02:40  jak
% Adding BitInterleaved Sort Class and auxilliary functions. (Everything seems to be working.) -jak
%
%
% ----------
% Revision 1.2  1999/10/20 07:52:46  jak
% Added code to use the builtin min and max functions, and to return formated
% string which may be passed to 'eval'. -jak
%
% Revision 1.1  1999/10/20 06:46:36  jak
% New file for performing a bit-interleaved sort on the rows of a multi-column matrix. -jak
%
%
%
