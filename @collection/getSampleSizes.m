
function q = getSampleSizes( p )
% getSampleSizes - collection Class Method
%
%     q = getSampleSizes( p )
%
% Description: Returns a row vector of sample
% sizes for the members of the collection.
%
% $Id: getSampleSizes.m,v 1.1.1.1 1997/10/28 18:38:43 jak Exp $
%

    q= [];
    for i=1:p.sets
        q = [ q, getSampleSize( p.dataArray(i) ) ];
    end

% endfunction getSampleSizes

%*****************************************************
% History:
% 
% $Log: getSampleSizes.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
