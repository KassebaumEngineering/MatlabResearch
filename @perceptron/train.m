
function p = train(p, I_samples, O_samples, epochs)
% TRAIN - perceptron Class Instance Method
%
%     p = train(p, I_samples, O_samples, epochs)
%     
%     Train uses adaptive backpropagation from the
%     Matlab Neural Networks Toolbox to adjust the
%     perceptron weights to minimize squared error
%     on the training set provided. The 'p' is the 
%     perceptron to be trained, the 'I_samples' and
%     'O_samples' are matrices of training data, and
%     'epochs' is a count of the number of passes
%     through the data set to be made for this
%     training run.
%
%     p         -> a perceptron Instance
%     I_samples -> samples x inputs
%     O_samples -> samples x outputs
%     epochs    -> a positive integer (optional)
%
% $Id: train.m,v 1.1.1.1 1997/10/28 18:38:44 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with perceptron Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('perceptron method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with perceptron Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('perceptron method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('perceptron method: train()');        
    end
     
    if ~isempty( epochs ) && epochs > 0
        p.tp(2) = epochs;
    end
    
    [p.Wh, p.Bh, p.Wo, p.Bo, epoch, TR] = ...
        trainbpa( p.Wh,p.Bh, 'tansig', ...
                    p.Wo, p.Bo, 'purelin', ...
                    I_samples' , ...
                    O_samples' , ...
                    p.TP ...
                );

%endfunction train

% ****************************************
% History:
% $Log: train.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:44  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%




