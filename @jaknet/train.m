
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
% $Id: train.m,v 1.1 1997/11/29 21:10:40 jak Exp $
%

  % ---------------------------------------
  % Network Architecture Validation
  %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('sopnet method: train()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('sopnet method: train()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Training Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('sopnet method: train()');        
    end

  % ---------------------------------------
  % Generate Enhancement Functions of Inputs.
  % 
    if isempty( p.Wh )
        H = [ ones(isamples,1) ];
    else
        H = [ ones(isamples, 1), tanh(p.Wh * [ ones(isamples, 1), I_samples]')' ];
    end


    HtH = H' * H;
    HtB = H' * O_samples ;

    p.Wo = HtB' * pinv( HtH );

%%%  % Y (outputs x samples) = p.Wo (outputs x hiddens) * H' (hiddnes x samples)
%%%   p.Wo = O_samples' * pinv( H' );
    
  % ---------------------------------------
  % Calculate Network Output
  %
    Y = (p.Wo * H');

  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( outputs, osamples );
    for i=1:osamples 
        max = 1;
        for j=2:outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end
  % ---------------------------------------
  % Calculate Mean Square Error
  %
%    err =  Y - O_samples';
    err =  Yc - O_samples';
    mse = 10^-20;
    for i=1:outputs
        mse = mse + (err(i, :) * err( i, : )') / (osamples * outputs);
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = p.outputs * p.hidden_units +  p.hidden_units * p.inputs; 
    DataCnt  = isamples * (p.inputs + p.outputs); 

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

  % ---------------------------------------
  % Train Input Layer -> Map Actual Outputs to Hidden Nodes
  %

    Mowb =  pinv( p.Wo ) * O_samples' ;
    [hiddens, hsamples] = size( Mowb );

    Mo = Mowb( 2:hiddens, : );
    M = atanh( Mo )';

    ItI = [ones( isamples, 1), I_samples]' * [ones( isamples, 1), I_samples];
    MtI = M' * [ones( isamples, 1), I_samples] ;

    p.Wh = MtI * pinv( ItI );

%%%  % M' (hiddens x samples) = p.Wh (hiddens x inputs) * Inputs' (inputs x samples )  
%%%    p.Wh = M' * pinv( [ones( isamples, 1), I_samples]' );

  % ---------------------------------------
  % Re-Train Output Layer
  %
    H = [ ones(isamples, 1), tanh( p.Wh * [ ones(isamples, 1), I_samples]' )' ];

    HtH = H' * H;
    HtB = H' * O_samples ;

    p.Wo = HtB' * pinv( HtH );

  % ---------------------------------------
  % Calculate New Network Output
  %
    Y = (p.Wo * H');

  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( outputs, osamples );
    for i=1:osamples 
        max = 1;
        for j=2:outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end

  % ---------------------------------------
  % Calculate Mean Square Error
  %
%    err =  Y - O_samples';
    err =  Yc - O_samples';
    mse = 10^-20;
    for i=1:outputs
        mse = mse + (err(i, :) * err( i, : )') / (osamples * outputs);
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = p.outputs * p.hidden_units +  p.hidden_units * p.inputs; 
    DataCnt  = isamples * (p.inputs + p.outputs); 

  % ---------------------------------------
  % Form Convergence Criterion
  %
    SEC = DataCnt * log( mse ) ...
              + ParamCnt * log( DataCnt );

    fprintf( 1, '%d nodes: SEC = %e, mse = %e\n', p.hidden_units, SEC, mse );
    
% endfunction train

%*****************************************************
% History:
% 
% $Log: train.m,v $
% Revision 1.1  1997/11/29 21:10:40  jak
% A New network type - uses LMS training to improve first layer. -jak
%
%
