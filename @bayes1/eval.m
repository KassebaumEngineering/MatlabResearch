
function [Yc, Y] = eval(p, I_samples)
% EVAL - bayes1 Class Instance Method
%
%     p = eval(p, I_samples)
%     
%     Eval evalutes the neural network 'p' using 
%     the 'I_samples' data provided.
%
%     p         -> a bayes1 Instance
%     I_samples -> samples x inputs
%
% $Id: eval.m,v 1.2 1998/03/08 07:18:21 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('bayes1 method: eval()');
    end
     
    % ---------------------------------------
    % Calculate Net Output.
    %
    Y = p.Wo * [ ones( samples, 1 ), tansig( p.Wh * I_samples', p.Bh)' ]';

    % ---------------------------------------
    % Calculate Net Output.
    %
%    Y = purelin(p.Wo(:, 1:p.hidden_units) * tansig( p.Wh * I_samples', p.Bh), p.Wo(:, p.hidden_units+1));

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
    
%endfunction eval

% ****************************************
% History:
% $Log: eval.m,v $
% Revision 1.2  1998/03/08 07:18:21  jak
% Well .... it works now ... thanks to God.  -jak
%
% Revision 1.1  1998/03/07 22:57:36  jak
% Added new test class. -jak
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
