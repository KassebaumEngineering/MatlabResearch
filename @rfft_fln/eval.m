
function [Yc, Y] = eval( p, I_samples )
% EVAL - rfft_fln Class Instance Method
%
%     [Yc, Y] = eval(p, I_samples)
%     
%     Eval evalutes the fft neural network 'p' using 
%     the 'I_samples' data provided.
%
%     p         -> an Instance of an rfft_fln
%     I_samples -> samples x inputs
%
%
% $Id: eval.m,v 1.3 1997/11/05 04:40:09 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('rfft_fln method: eval()');
    end
     
    % ---------------------------------------
    % Augment Net Inputs (pad with zeros if necessary).
    %
    % TEST FOR hidden_units A POWER OF 2 !!
    % TEST FOR hidden_units SMALLER THAN p.inputs !!
    if p.inputs ~= p.hidden_units
        augmentation = zeros( samples, (p.hidden_units - p.inputs) );
        Inputs       = [ I_samples, augmentation ];
    else
        Inputs       = I_samples;
    end
    
    % ---------------------------------------
    % Calculate Net Output.
    %
    Y = p.Wo * [ ...
                 tansig( rfft( Inputs' )' ), ...
                 Inputs, ...
                 ones( samples, 1) ...
               ]' ;

    % ---------------------------------------
    % Assign Outputs to Classes
    %
    Yc = zeros( p.outputs, samples );
    for i=1:samples 
        max = 1;
        for j=2:p.outputs 
            if Y(j,i) > Y(max,i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end

    Y = Y';
    Yc = Yc';

% endfunction eval

%*****************************************************
% History:
% 
% $Log: eval.m,v $
% Revision 1.3  1997/11/05 04:40:09  jak
% Added use of the rfft and use of a sigmoidal nonlinearity. -jak
%
% Revision 1.2  1997/11/04 17:35:59  jak
% Changed fft so that the fft would be over te input variables. -jak
%
% Revision 1.1  1997/11/04 16:55:11  jak
% First Check in of running fft Network Class. -jak
%
%
