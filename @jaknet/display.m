
function S = display( p )
% display - @jaknet Class Method
%
%     p = display( p )
%
% Description:
%
% $Id: display.m,v 1.1 1999/09/29 01:11:26 jak Exp $
%
    S1 = sprintf('inputs: %d \n', p.inputs);
    S2 = sprintf('outputs: %d \n', p.outputs);
    S3 = sprintf('hidden_units: %d\n', p.hidden_units); 
    S4 = sprintf('param_count: %d\n', p.param_count);
    S5 = sprintf('classify: %d\n', p.classify);
    disp([ S1, S2, S3, S4, S5 ]);
    disp( sprintf('Wh:') );
    disp( p.Wh );
    disp( sprintf('\nBh:') );
    disp( p.Bh );
    disp( sprintf('\nWo:') );
    disp( p.Wo );

% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1  1999/09/29 01:11:26  jak
% Added display function. -jak
%
%
