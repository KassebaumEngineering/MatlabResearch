
function [ omat, I ] = bitinterleavesort( imat, quantiles )
% BITINTERLEAVESORT - Returns a matrix with entries which are the
%                   bit-interleaved rows of the input matrix.
%
%     [ omat, I ] = bitinterleavesort(imat, quantiles);
%
% Description:  The BITINTERLEAVESORT function creates a  
% bit-interleaved matrix from the rows of the input matrix 
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
% $Id: bitinterleavesort.m,v 1.1 1999/10/20 06:46:36 jak Exp $
%
% 
    [ rows, cols ] = size( imat );
    maxval = (2^quantiles) - 1;
  %
  % Discover Min and Max Values - data ranges
  %
    minvalue = zeros( 1, cols );
    maxvalue = zeros( 1, cols );
    scale  = zeros( 1, cols );
    offset = zeros( 1, cols );
    for c=1:cols 
        minvalue( 1, c ) = imat( 1, c ); 
        maxvalue( 1, c ) = imat( 1, c ); 
    end
    for r=2:rows
        for c=1:cols 
            if ( minvalue( 1, c ) > imat( r, c ) )
                minvalue( 1, c ) = imat( r, c );
            end
            if ( maxvalue( 1, c ) < imat( r, c ) )
                maxvalue( 1, c ) = imat( r, c );
            end
        end
    end
    for c=1:cols 
         scale( 1, c ) = maxval / ( maxvalue( 1, c ) - minvalue( 1, c ) );
        offset( 1, c ) = minvalue( 1, c );
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
            smat( r, c ) = round( scale( 1, c ) * (imat( r, c ) - offset( 1, c )) );
        end
    end
    
  %
  % Generate Bit-Interleaved Output Matrix
  %
    omat = char(rows,cols*quantiles); %omat = zeros( rows, cols*quantiles );
    for r=1:rows
        for q=1:quantiles
           mask = bitshift( 1, q-1 );
           for c=1:cols 
                if ( bitand( smat( r, c ), mask ) ~= 0 )
                    omat(r,(q-1)*cols + c) = '1'; 
                else 
                    omat(r,(q-1)*cols + c) = '0'; 
                end
            end
        end
    end
  %
    
  %
  % Sort Rows of Bit-Interleaved Output Matrix
  %
    [ omat, I ] = sortrows( omat );
  
%endfunction

% --------------------------------
% History:
% $Log: bitinterleavesort.m,v $
% Revision 1.1  1999/10/20 06:46:36  jak
% New file for performing a bit-interleaved sort on the rows of a multi-column matrix. -jak
%
%
%
