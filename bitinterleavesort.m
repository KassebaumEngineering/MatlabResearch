
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
% Also Note:  For ease of use, the character string outputs have been 
% formated so that any one row may be 'eval'-ed to obtain an array of
% bit strings - each string is one block of equal significance bits in
% column order.  This make postprocessing a little easier.
%
% Finally -> I should probably turn this into a class.  Then I could
% have reasonable questions of it in the form of instance methods. Rather
% than handing back a hideous encoded structure.  TODO ;-)
%
% $Id: bitinterleavesort.m,v 1.2 1999/10/20 07:52:46 jak Exp $
%
% 
    [ rows, cols ] = size( imat );
    maxval = (2^quantiles) - 1;
  %
  % Discover Min and Max Values of Columns - data ranges
  %
    minvalue = min(imat);
    maxvalue = max(imat);
    scale  = zeros( 1, cols );
    offset = zeros( 1, cols );
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
    omat = char(rows,2*2 + cols*quantiles + (cols-1)*3);
    for r=1:rows
        omat(r,1:2) = '[''';
        for q=1:quantiles
            mask = bitshift( 1, q-1 );
            for c=1:cols 
                if ( bitand( smat( r, c ), mask ) ~= 0 )
                    omat(r,2 + (q-1)*(cols+3) + c) = '1'; 
                else 
                    omat(r,2 + (q-1)*(cols+3) + c) = '0'; 
                end
            end
            if (q ~= quantiles )
                omat(r,2 + (q-1)*(cols+3) + cols + 1:2 + (q-1)*(cols+3) + cols + 3) = ''';''';
            else
                omat(r,2 + (q-1)*(cols+3) + cols + 1:2 + (q-1)*(cols+3) + cols + 2) = ''']';
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
% Revision 1.2  1999/10/20 07:52:46  jak
% Added code to use the builtin min and max functions, and to return formated
% string which may be passed to 'eval'. -jak
%
% Revision 1.1  1999/10/20 06:46:36  jak
% New file for performing a bit-interleaved sort on the rows of a multi-column matrix. -jak
%
%
%
