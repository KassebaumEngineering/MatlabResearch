
function p[Yc, Y] = eval(p, I_samples)
% EVAL - perceptron Class Instance Method
%
%     p = eval(p, I_samples, O_samples)
%     
%     Eval evalutes the neural netowrk 'p' using 
%     the 'I_samples' data provided.
%
%     p         -> a Perceptron Instance
%     I_samples -> samples x inputs
%
% $Id: eval.m,v 1.1 1997/10/28 18:38:44 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('perceptron method: eval()');
    end
     
    % ---------------------------------------
    % Calculate Net Output.
    %
    Y = purelin(W2 * tansig( W1 * I_samples', B1),  B2);


    % ---------------------------------------
    % Assign Outputs to Classes
    %
    Yc = zeros( p.outputs, samples );
    for i=1:samples 
        max = 1;
        for j=2:classes 
            if Y(j,i) > Y(max,i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end

%endfunction train

% ****************************************
% History:
% $Log: eval.m,v $
% Revision 1.1  1997/10/28 18:38:44  jak
% Initial revision
%
%
