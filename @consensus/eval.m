
function [CYc, CY] = eval( p, I_samples )
% eval - consensus Class Method
%
%     [Yc, Y] = eval( p, I_samples )
%
% Description: Evaluate the networks in the
% consensus.
%
% $Id: eval.m,v 1.1 1997/11/18 16:48:47 jak Exp $
%
    [samples,  inputs ] = size( I_samples );
    
    CY = zeros( samples, p.outputs );
    for i = 1:p.networkCnt
        [Yc, Y] = eval( p.member{i}, I_samples );
        CY = CY + Y / p.networkCnt;
%        CY = [ CY, Y ];
    end
    
    % ---------------------------------------
    % Assign Outputs to Classes
    %
    CYc = zeros( samples, p.outputs );
    for i=1:samples 
        max = 1;
        for j=2:p.outputs 
            if CY(i,j) > CY(i,max)
                max = j;
            end
        end
        CYc( i, max ) = 1;
    end


%    [ CYc, CY ] = eval( p.consNet, CY );
    
% endfunction eval

%*****************************************************
% History:
% 
% $Log: eval.m,v $
% Revision 1.1  1997/11/18 16:48:47  jak
% New experiment - consensus nets! -jak
%
%
