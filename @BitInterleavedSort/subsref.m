
function mat = subsref( p, S )
% subsref - @BitInterleavedSort Class Method
%
%     mat = subsref( p, S )
%
% Description: Subsref() overloads the subscripting operation
% on the BitInterleavedSort object.
%
% $Id: subsref.m,v 1.2 2000/01/12 04:10:54 jak Exp $
%
   switch S.type
        case '()',
            mat = subsref( p.bis_mat, S );
            
        case '{}',
            mat = getEntry( p, S.subs{1}, S.subs{2} );
            
        case '.',
            switch S.subs
                case 'rows',
                    mat = p.rows;
                case 'cols',
                    mat = p.cols;
                case 'quantiles',
                    mat = p.quantiles;
                case 'scale',
                    mat = p.scale;
                case 'offset',
                    mat = p.offset;
                case 'rangemin',
                    mat = p.rangemin;
                case 'rangemax',
                    mat = p.rangemax;
                case 'bis_mat',
                    mat = p.bis_mat;
                case 'index_mat',
                    mat = p.index_mat;
            end
    end
    
% endfunction subsref

%*****************************************************
% History:
% 
% $Log: subsref.m,v $
% Revision 1.2  2000/01/12 04:10:54  jak
% New code to support inverse mapping from the Bit interleaved form. -jak
%
% Revision 1.1  1999/10/20 23:02:40  jak
% Adding BitInterleaved Sort Class and auxilliary functions. (Everything seems to be working.) -jak
%
%
