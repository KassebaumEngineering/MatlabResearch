
function p = train(p, I_samples, O_samples, varargin)
% TRAIN - sopnet Class Instance Method
%
%     p = train(p, I_samples, O_samples, [MinsAndMaxes])
%     
%     Train uses Linear Least Mean Squares to set the
%     network weights to minimize squared error
%     on the training set provided. The 'p' is the 
%     perceptron to be trained, the 'I_samples' and
%     'O_samples' are matrices of training data.
%     The MinsAndMaxes argument is optional, and 
%     contains a min and max data value for each input
%     of the I_samples data set.
%
%     p            -> a Perceptron Instance
%     I_samples    -> samples x inputs
%     O_samples    -> samples x outputs
%     MinsAndMaxes -> inputs x 2 array of 
%                     min (:,1) and max (:,2)
%                     input data ranges.
%
% $Id: train.m,v 1.3 1997/11/18 16:50:29 jak Exp $
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
  % Find Mins and maxes for input data
  %
    if isempty( varargin )
        MaM = zeros(inputs,2);
        for r= 1:inputs
            min = I_samples(1, r);
            max = I_samples(1, r);
            for i= 2:isamples
            if  I_samples(i, r) > max
                max = I_samples(i, r);
            end
            if  I_samples(i, r) < min
                min = I_samples(i, r);
            end
            end
            MaM(r,1)=min;
            MaM(r,2)=max;
        end
    else
        MaM = varargin{1};
    end

  % ---------------------------------------
  % Generate Enhancement Functions of Inputs.
  %
    H = [ tansig( p.Wh * I_samples', p.Bh)' ];

    HtH = H' * H;
    HtB = H' * O_samples ;

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
    mse = 0.0;
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
    
    fprintf( 1, '%d nodes: SEC = %f, mse = %f\n', p.hidden_units, SEC, mse );
    
    if 1 == p.freezeHiddenLayer
        return;
    end
    
    AugmentCnt = 10;
    MaxIterations = 5;
    iterate = 1;
    quit = 0;
    while ( 1 ~= quit )
      % ---------------------------------------
      % To augment HtH and HtB we must
      % resize HtH and HtB, and add VtH
      % and VtB respectively where V is
      % the Augmentation Vector (from the
      % new hidden node).

      % Initialize weights and biases for new node.
      % Use Random Nguyen-Widrow Values
      %
        [Wn,Bn] = nwtan( AugmentCnt, inputs, MaM );
        Wh = [ p.Wh; Wn ];
        Bh = [ p.Bh; Bn ];

     %  Augmentation Vector
        V = [ tansig( Wn * I_samples', Bn)' ];
        
     %  Augment H, HtH, and HtB
        augHtH = [ HtH , (H'*V) ; (V'*H) , (V'*V) ];
        augHtB = [ HtB  ; (V' * O_samples) ];
        augH = [ H, V ];
        hidden_units = p.hidden_units+AugmentCnt;

      % TEST  
%        [Wh,Bh] = nwtan( hidden_units, inputs, MaM );
%        augH   = [ tansig( Wh * I_samples', Bh)' ];
%        augHtH = augH' * augH;
%        augHtB = augH' * O_samples;
        
      % ---------------------------------------
      % Solve for new Output Layer Weights
      % (Standard Method)
      %
%        Wo = augHtB' / augHtH ;
        
      % ---------------------------------------
      % By Singular-Value Decomposition! (Works)
      %    
        [U, S, V] = svd( augHtH );
        [d1,d2] = size( S );
        Sinv = sparse( d1, d1 );
        for i=1: d1
            if (S(i,i) < 10^-20 * S(1,1))
                Sinv(i,i) = 0.0;
            else
                Sinv(i,i) = 1.0 / S(i,i);
            end
        end
        Wo = ((V * Sinv) * (U' * augHtB))';

      % ---------------------------------------
      % Calculate Sum Square Error
      %
        Y = (Wo * augH');
        err =  Y - O_samples';
        newmse = 0.0;
        for i=1:outputs
            newmse = newmse + err(i, :) * err(i, :)' / (osamples * outputs) ;
        end
        
      % ---------------------------------------
      % Calculate Structure and Data Size Penalty Terms
      %
        ParamCnt =  p.outputs * hidden_units +  hidden_units * p.inputs;
        DataCnt  = isamples * (p.inputs + p.outputs); 
        
      % ---------------------------------------
      % Form Convergence Criterion
      %
        newSEC = DataCnt * log( newmse ) ...
                 +  ParamCnt * log( DataCnt );
              
        fprintf( 1, '%d nodes: SEC = %f, mse = %f\n', hidden_units, newSEC , newmse);
        
        if ( newSEC < SEC )
            SEC = newSEC;
            mse = newmse;
            HtH = augHtH;
            HtB = augHtB;
            H   = augH;
            p.Wh = Wh;
            p.Bh = Bh;
            p.hidden_units = hidden_units;
            p.Wo = Wo;
            iterate = 1;
            quit = 0;
        elseif (MaxIterations <= iterate) & (AugmentCnt == 1)
            fprintf( 1, 'DONE! %d nodes: SEC = %f, mse = %f\n', ...
                p.hidden_units, SEC, mse );
            quit = 1;            
        elseif (MaxIterations <= iterate)
            iterate = 1;
            quit = 0;
            AugmentCnt = AugmentCnt-1;
        else
            iterate = iterate + 1;
            quit = 0;
        end
     end
     
%endfunction train

% ****************************************
% History:
% $Log: train.m,v $
% Revision 1.3  1997/11/18 16:50:29  jak
% Some experiments to test performance under different SECs. -jak
%
% Revision 1.2  1997/11/08 07:11:24  jak
% Corrections for truth in SEC calculations! Improved performance. -jak
%
% Revision 1.1  1997/11/08 04:37:55  jak
% First Turn in of Self-Organizing Percepton Network! - jak
%
%
