
function p = train( p, I_samples, O_samples )
% TRAIN - rfft_fln Class Instance Method
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
% $Id: train.m,v 1.2 1997/11/04 17:36:00 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('rfft_fln method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('rfft_fln method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('rfft_fln method: train()');        
    end
     
    % ---------------------------------------
    % Augment Net Inputs (pad with zeros if necessary).
    %
    % TEST FOR hidden_units A POWER OF 2 !!
    % TEST FOR hidden_units SMALLER THAN p.inputs !!
    if p.inputs ~= p.hidden_units
        augmentation = zeros( isamples, (p.hidden_units - p.inputs) );
        Inputs       = [ I_samples, augmentation ];
    else
        Inputs       = I_samples;
    end
    
    % ---------------------------------------
    % Calculate Enhancement Functions of Inputs.
    %
    H = [ fft( Inputs' )', I_samples];

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

% endfunction train

%*****************************************************
% History:
% 
% $Log: train.m,v $
% Revision 1.2  1997/11/04 17:36:00  jak
% Changed fft so that the fft would be over te input variables. -jak
%
% Revision 1.1  1997/11/04 16:55:12  jak
% First Check in of running fft Network Class. -jak
%
%
