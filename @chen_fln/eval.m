
function [Yc, Y] = eval(p, I_samples)
% EVAL - CHEN_FLN Class Instance Method
%
%     p = eval(p, I_samples)
%     
%     Eval evalutes the neural network 'p' using 
%     the 'I_samples' data provided.
%
%     p         -> a Perceptron Instance
%     I_samples -> samples x inputs
%
% $Id: eval.m,v 1.4 1997/11/07 05:39:15 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('chen_fln method: eval()');
    end
     
    % ---------------------------------------
    % Calculate Net Output.
    %
%    Y = p.Wo * [tansig( p.Wh * I_samples', p.Bh)' , I_samples]';
    Y = p.Wo * [tansig( p.Wh * I_samples', p.Bh)' ]';


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
    
%endfunction train

% ****************************************
% History:
% $Log: eval.m,v $
% Revision 1.4  1997/11/07 05:39:15  jak
% Major Changes - now works with svd, qr, and standard lu.
% Also uses the SEC to stop iterative training. -jak
%
% Revision 1.3  1997/11/04 16:54:05  jak
% Corrected a misspelled word. -jak
%
% Revision 1.2  1997/10/29 00:10:44  jak
% Fixed some problems with the output from eval - needs cleanup. -jak
%
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
