
function entry = getEntry( p, index, quants )
% getEntry - @BitInterleavedSort Class Method
%
%     entry = getEntry( p, index, quants )
%
% Description:  getEntry() returns an entry (row) from the
% sorted form of the BitInterleaved data matrix which was used
% to construct the BitInterleavedSort in the first place.
% The index argument gives the sort index entry to return, and
% the quants argument gives which quantization level to return.
% Note: If you want to use the scaled values of the quantization levels
% seperately you will have to subtract the offset from them. 
% WARNING: Since the bitinterleaved data is quantized, the resulting
% entry (row) may not have the same precision as the original.
%
% $Id: getEntry.m,v 1.1 2000/01/12 04:10:54 jak Exp $
%

    bitstringcell = p.bis_mat( index, quants );
    [ rows quantlevels ] = size( bitstringcell );

    for r = 1:rows
        for c = 1:p.cols
            entry( r, c ) = 0;
            for q = 1:quantlevels
                bitstring = bitstringcell{r,q};
                if ( bitstring( 1, c ) == '0' )
                    bit = 0;
                else
                    bit = 1;
                end
                entry( r, c ) = entry( r, c ) + bitshift( bit, p.quantiles-q );
            end
            % re-scale and de-offset the entry vector entry
            entry( r, c ) = ( entry( r, c ) / p.scale( 1, c ) ) + p.offset( 1, c );
        end
    end
    

% endfunction getEntry

%*****************************************************
% History:
% 
% $Log: getEntry.m,v $
% Revision 1.1  2000/01/12 04:10:54  jak
% New code to support inverse mapping from the Bit interleaved form. -jak
%
%
