
function p = display( p, arg )
% display - @BitInterleavedSort Class Method
%
%     p = display( p, arg )
%
% Description:
%
% $Id: display.m,v 1.1 1999/10/20 23:02:40 jak Exp $
%
    S0 = sprintf('BitInterleavedSort Object: \n');
    S1 = sprintf('\trows: %d \n', p.rows);
    S2 = sprintf('\tcols: %d \n', p.cols);
    S3 = sprintf('\tquantiles: %d\n', p.quantiles);
    
    disp([ S0, S1, S2, S3 ]);
    
%    size( p.scale )
%    size( p.offset )
%    size( p.rangemin )
%    size( p.rangemax )
%    size( p.bis_mat )
%    size( p.index_mat )
 
% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1  1999/10/20 23:02:40  jak
% Adding BitInterleaved Sort Class and auxilliary functions. (Everything seems to be working.) -jak
%
%
