
function p = train( p, I_samples, O_samples)
% train - jaknet Class Method
%
%     p = train( p, arg )
%
% Description:
%     Train uses Linear Least Mean Squares to set the
%     network weights to minimize squared error
%     on the training set provided. The 'p' is the 
%     perceptron to be trained, the 'I_samples' and
%     'O_samples' are matrices of training data.
%
%     p            -> a jaknet Instance
%     I_samples    -> samples x inputs
%     O_samples    -> samples x outputs
%
% $Id: train.m,v 1.1 1999/09/19 23:29:43 jak Exp $
%

  % ---------------------------------------
  % Network Architecture Validation
  %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('jaknet method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('jaknet method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('jaknet method: train()');        
    end

    H_samples = (p.hadamat * [ O_samples, zeros(osamples, p.hadaputs-p.outputs ) ]')';

  % ---------------------------------------
  % Generate Enhancement Functions of Inputs.
  % 
    if isempty( p.Wh )
        H = [ ones(isamples,1) ];
    else
        H = [ ones(isamples, 1), tanh(p.Wh * [ ones(isamples, 1), I_samples]')' ];
    end

    p.Wo = H_samples' * pinv( H )';

    %%% -----------------------------------------------------------
    %%%  % Y (outputs x samples) = p.Wo (outputs x hiddens) * H' (hiddens x samples)
    %%%   p.Wo = O_samples' * pinv( H' );
    %%% -----------------------------------------------------------
    
  % ---------------------------------------
  % Calculate Network Output
  %
    Yh =  p.invhadamat * real( (p.Wo * H') );
    Y = Yh( 1:p.outputs, : );

  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( p.outputs, osamples );
    for i=1:osamples 
        max = 1;
        for j=2:p.outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end
  % ---------------------------------------
  % Calculate Mean Square Error
  %
  % err =  Y - O_samples';  %%% For Prediction Problems
    err =  Yc - O_samples'; %%% For Classification Problems
    mse = 10^-20;
    for i=1:p.outputs
        mse = mse + (err(i, :) * err( i, : )') / (osamples * outputs);
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = outputs * p.hidden_units +  p.hidden_units * inputs; 
    DataCnt  = isamples * (inputs + outputs); 

  % ---------------------------------------
  % Form Convergence Criterion
  %
    SEC = DataCnt * log( mse ) ...
              + ParamCnt * log( DataCnt );
    
    fprintf( 1, '%d nodes: SEC = %e, mse = %e\n', p.hidden_units, SEC, mse );

    [cmat, pc, tpc] = conf( O_samples, Yc' );
    pc
    tpc
    cmat
    
%for k=1:10
  % ---------------------------------------
  % Train Input Layer -> Map Actual Outputs to Hidden Nodes
  %

    Mowb =  pinv( p.Wo ) * H_samples' ;
    [hiddens, hsamples] = size( Mowb );

    Mo = Mowb( 2:hiddens, : );
    M = atanh( Mo )';

    p.Wh = M' * pinv( [ones( isamples, 1), I_samples] )';

    %%% -----------------------------------------------------------
    %%%  % M' (hiddens x samples) = p.Wh (hiddens x inputs) * Inputs' (inputs x samples )  
    %%%    p.Wh = M' * pinv( [ones( isamples, 1), I_samples]' );
    %%% -----------------------------------------------------------

  % ---------------------------------------
  % Re-Train Output Layer
  %
    H = [ ones(isamples, 1), tanh( p.Wh * [ ones(isamples, 1), I_samples]' )' ];
    p.Wo = H_samples' * pinv( H )' ;

  % ---------------------------------------
  % Calculate New Network Output
  %
    Yh = p.invhadamat * real( (p.Wo * H') );
    Y = Yh( 1:p.outputs, : );

  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( p.outputs, osamples );
    for i=1:osamples 
        max = 1;
        for j=2:p.outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end

  % ---------------------------------------
  % Calculate Mean Square Error
  %
  % err =  Y - O_samples';  %%% For Prediction Problems
    err =  Yc - O_samples'; %%% For Classification Problems
    mse = 10^-20;
    for i=1:p.outputs
        mse = mse + (err(i, :) * err( i, : )') / (osamples * outputs);
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = outputs * p.hidden_units +  p.hidden_units * inputs; 
    DataCnt  = isamples * (inputs + outputs); 

  % ---------------------------------------
  % Form Convergence Criterion
  %
    SEC = DataCnt * log( mse ) ...
              + ParamCnt * log( DataCnt );

    fprintf( 1, '%d nodes: SEC = %e, mse = %e\n', p.hidden_units, SEC, mse );
%end
% endfunction train

%*****************************************************
% History:
% 
% $Log: train.m,v $
% Revision 1.1  1999/09/19 23:29:43  jak
% Initial revision
%
% Revision 1.2  1998/03/07 22:58:16  jak
% I don't know .... hmmm. -jak
%
% Revision 1.1  1997/11/29 21:10:40  jak
% A New network type - uses LMS training to improve first layer. -jak
%
%
