
function Y = eval(p, I_samples)
% EVAL - mdlnet Class Instance Method
%
%     p = eval(p, I_samples)
%     
%     Eval evalutes the neural network 'p' using 
%     the 'I_samples' data provided.
%
%     p         -> a mdlnet Instance
%     I_samples -> samples x inputs
%
% $Id: eval.m,v 1.3 1999/09/30 04:34:54 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('mdlnet method: eval()');
    end
     
    % ---------------------------------------
    % Calculate Net Output.
    %
    Y = p.Wo * [ ones( samples, 1 ), tansig( p.Wh * I_samples' + p.Bh * ones( 1, samples ))' ]';

    if ( 1 == p.classify )
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
        
        Y = Yc';
        
    else
        Y = Y';
    end
    
%endfunction eval

% ****************************************
% History:
% $Log: eval.m,v $
% Revision 1.3  1999/09/30 04:34:54  jak
% Changes to files - added use of deterministic initialization. -jak
%
% Revision 1.3  1999/09/19 23:34:31  jak
% New version of @jaknet - to use for MDL surface topology experiments. -jak
%
% Revision 1.3  1997/11/29 21:11:06  jak
% Fixed some mis-references in the comments. -jak
%
% Revision 1.2  1997/11/25 18:26:14  jak
% Added some useful features to improve classification performance. -jak
%
% Revision 1.1  1997/11/08 04:37:54  jak
% First Turn in of Self-Organizing Percepton Network! - jak
%
%
