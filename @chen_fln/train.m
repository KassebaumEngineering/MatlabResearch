
function p = train(p, I_samples, O_samples)
% TRAIN - Chen_fln Class Instance Method
%
%     p = train(p, I_samples, O_samples)
%     
%     Train uses Linear Least Mean Squares to set the
%     network weights to minimize squared error
%     on the training set provided. The 'p' is the 
%     perceptron to be trained, the 'I_samples' and
%     'O_samples' are matrices of training data.
%
%     p         -> a Perceptron Instance
%     I_samples -> samples x inputs
%     O_samples -> samples x outputs
%
% $Id: train.m,v 1.1.1.1 1997/10/28 18:38:43 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('chen_fln method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('chen_fln method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('chen_fln method: train()');        
    end
     
    % ---------------------------------------
    % Generate Enhancement Functions of Inputs.
    %
    H = [tansig( p.Wh * I_samples', p.Bh)' , I_samples];

    HtH = H' * H;
    HtB = H' * O_samples ;
    [U S V] = svd( HtH );
    [d1,d2] = size( S );
    Sinv = zeros( d1, d1 );
    for i=1: d1
        if S(i,i) == 0.0
            Sinv(i,i) = 0;
        else
            Sinv(i,i) = 1.0 / S(i,i);
        end
    end
    p.Wo = ((V * Sinv) * (U' * HtB))';

%endfunction train

% ****************************************
% History:
% $Log: train.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:43  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
