
function p = train(p, I_samples, O_samples, epochs )
% TRAIN - bayes1 Class Instance Method
%
%     p = train(p, I_samples, O_samples, epochs )
%     
%     Train uses Linear Least Mean Squares to set the
%     network weights to minimize squared error
%     on the training set provided. The 'p' is the 
%     perceptron to be trained, the 'I_samples' and
%     'O_samples' are matrices of training data.
%
%     p            -> a bayes1 Instance
%     I_samples    -> samples x inputs
%     O_samples    -> samples x outputs
%
% $Id: train.m,v 1.2 1998/03/08 07:18:23 jak Exp $
%

  % ---------------------------------------
  % Network Architecture Validation
  %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('bayes1 method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('bayes1 method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('bayes1 method: train()');        
    end
     
    p.Tp(2) = epochs;

    [p.Wh, p.Bh, p.Wo(:, 2:p.hidden_units+1), p.Wo(:,1), TE, TR] = ...
        trainbpx( p.Wh, p.Bh, 'tansig', ...
                    p.Wo(:, 2:p.hidden_units+1),p.Wo(:,1), 'purelin', ...
                    I_samples' , ...
                    O_samples' , ...
                    p.Tp ...
                );
    
    H = [ ones(isamples,1), tansig( p.Wh * I_samples', p.Bh)' ];
    p.Wo = O_samples' * pinv( H )';
    Y = (p.Wo * H');
    fprintf( 1, 'SSE = %f', sumsqr( (Y - O_samples') ));

%endfunction train

% ****************************************
% History:
% $Log: train.m,v $
% Revision 1.2  1998/03/08 07:18:23  jak
% Well .... it works now ... thanks to God.  -jak
%
% Revision 1.1  1998/03/07 22:57:38  jak
% Added new test class. -jak
%
