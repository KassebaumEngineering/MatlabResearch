
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
% $Id: train.m,v 1.7 1997/12/02 18:22:38 jak Exp $
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
    % Should TEST FOR hidden_units A POWER OF 2 !!
    % Should TEST FOR hidden_units SMALLER THAN p.inputs !!
    if p.inputs ~= p.hidden_units
        augmentation = zeros( isamples, (p.hidden_units - p.inputs) );
        Inputs       = [ I_samples, augmentation ];
    else
        Inputs       = I_samples;
    end
    
    % ---------------------------------------
    % Calculate Enhancement Functions of Inputs.
    %

    H = [ ...
          tansig( irfft( Inputs' )' ) ...
%          ,tansig( irfft( Inputs' )' ) ...
%          ,I_samples ...
%          ,ones( isamples, 1) ...
        ];

    HtH = H' * H;
    HtB = H' * O_samples ;
    
  % ---------------------------------------
  % By Singular-Value Decomposition! (Works)
  %    
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

  % ---------------------------------------
  % QR Method: (Works)
  %
%    [Q,R] = qr( HtH );
%    p.Wo = (HtB' * Q) / R';

 
  % ---------------------------------------
  % Standard Method: (Works) 
  %
%    p.Wo = HtB' / HtH ;

  % ---------------------------------------
  % Calculate Sum Square Error
  %
    Y = (p.Wo * H');
    err =  Y - O_samples';
    sse = 0.0;
    for i=1:outputs
        sse = sse + err(i, :) * err( i, : )';
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
%    ParamCnt = p.outputs * (p.hidden_units + p.inputs + 1); 
    ParamCnt = p.outputs * p.hidden_units; 
    DataCnt  = isamples * p.inputs + osamples * p.outputs; 

  % ---------------------------------------
  % Form Convergence Criterion
  %
    SEC = DataCnt * log( sse ) ...
              + ParamCnt * log( DataCnt );
    
    fprintf( 1, '%d nodes: SEC = %f, sse = %f\n', p.hidden_units, SEC, sse );
    
    if 1 == p.freezeHiddenLayer
        return;
    end
    
    nextPower = log2( p.hidden_units ) + 1;
    quit = 0;
    while ( 1 ~= quit )
        % ---------------------------------------
        % Augment Net Inputs (pad with zeros if necessary).
        %
        % TEST FOR hidden_units A POWER OF 2 !!
        % TEST FOR hidden_units SMALLER THAN p.inputs !!
        hidden_units = 2 ^ nextPower;
        augmentation = zeros( isamples, (hidden_units - p.inputs) );
        Inputs       = [ I_samples, augmentation ];

        % ---------------------------------------
        % Calculate Enhancement Functions of Inputs.
        %

        H = [ ...
                 tansig( rfft( Inputs' )' ) ...
%                ,tansig( irfft( Inputs' )' ) ...
%                ,I_samples ...
%                ,ones( isamples, 1) ...
            ];

        HtH = H' * H;
        HtB = H' * O_samples ;

      % ---------------------------------------
      % Solve for new Output Layer Weights
      % (Standard Method)
      %
%        Wo = HtB' / HtH ;
        
      % ---------------------------------------
      % By Singular-Value Decomposition! (Works)
      %    
        [U, S, V] = svd( HtH );
        [d1,d2] = size( S );
        Sinv = sparse( d1, d1 );
        for i=1: d1
            if (S(i,i) < 10^-20 * S(1,1))
                Sinv(i,i) = 0.0;
            else
                Sinv(i,i) = 1.0 / S(i,i);
            end
        end
        Wo = ((V * Sinv) * (U' * HtB))';

      % ---------------------------------------
      % Calculate Sum Square Error
      %
        Y = (Wo * H');
        err =  Y - O_samples';
        newsse = 0.0;
        for i=1:outputs
            newsse = newsse + err(i, :) * err(i, :)' ;
        end
        
      % ---------------------------------------
      % Calculate Structure and Data Size Penalty Terms
      %
%        ParamCnt = p.outputs * (p.hidden_units + p.inputs + 1); 
        ParamCnt = p.outputs * p.hidden_units; 
        DataCnt  = isamples * p.inputs + osamples * p.outputs; 
        
      % ---------------------------------------
      % Form Convergence Criterion
      %
        newSEC = DataCnt * log( newsse ) ...
                 +  ParamCnt * log( DataCnt );
              
        fprintf( 1, '%d nodes: SEC = %f, sse = %f\n', ...
                 hidden_units, newSEC , newsse);
        
        if ( newSEC < SEC )
            SEC = newSEC;
            sse = newsse;
            p.hidden_units = hidden_units;
            p.Wo = Wo;
            quit = 0;
            nextPower = nextPower + 1;
        else
            fprintf( 1, 'DONE! %d nodes: SEC = %f, sse = %f\n', ...
                p.hidden_units, SEC, sse );
            quit = 1;            
        end
     end

% endfunction train

%*****************************************************
% History:
% 
% $Log: train.m,v $
% Revision 1.7  1997/12/02 18:22:38  jak
% experiments. -jak
%
% Revision 1.6  1997/11/08 07:10:59  jak
% Corrections for truth in SEC calculations! Improved performance. -jak
%
% Revision 1.5  1997/11/07 06:20:09  jak
% Changed calling conventions, cleaned up stuff, ready for iteration. -jak
%
% Revision 1.4  1997/11/07 05:40:59  jak
% Its working, but not very well at least as far as performace goes. -jak
%
% Revision 1.3  1997/11/05 04:40:09  jak
% Added use of the rfft and use of a sigmoidal nonlinearity. -jak
%
% Revision 1.2  1997/11/04 17:36:00  jak
% Changed fft so that the fft would be over te input variables. -jak
%
% Revision 1.1  1997/11/04 16:55:12  jak
% First Check in of running fft Network Class. -jak
%
%
