
function q = getAllData( p )
% getAllData - collection Class Method
%
%     q = getAllData( p )
%
% Description: Returns a single iodata 
% instance containing all the data in the
% collection.
%
% $Id: getAllData.m,v 1.1 1997/10/28 18:38:44 jak Exp $
%

    samples = 0;
    inpmat = [];
    outpmat = [];
    for i = 1:p.sets
        if isa (p.dataArray(i), 'iodata' )
            samples = samples + getSampleSize( p.dataArray(i) );
            inpmat = [inpmat, getInputSample( p.dataArray(i), ':' )' ];
        else
            samples = samples + getSampleSize(  p.dataArray(i) );
            inpmat = [inpmat, getSample( p.dataArray(i), ':' )' ];
        end
        if p.hasIoData == 1
            outpmat = [outpmat, getOutputSample( p.dataArray(i), ':' )' ];
        end
    end
    
    if p.hasIoData == 1
        q = iodata(p.label, inpmat', outpmat');
    else
        q =   data(p.label, inpmat' );
    end


% endfunction getAllData

%*****************************************************
% History:
% 
% $Log: getAllData.m,v $
% Revision 1.1  1997/10/28 18:38:44  jak
% Initial revision
%
%
