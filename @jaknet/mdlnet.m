
function p = mdlnet(I_samples, O_samples, classify , hiddencnt)
% mdlnet - Constructor for mdlnet Class
%
%     p = mdlnet(I_samples, O_samples, classify )
%     
%     Creates a neural network with an  architecture
%     which supports the I_samples and O_Samples which were
%     passed as arguments.  The hidden_units argument, if
%     supplied is an initializer for the number of hidden_units
%     to use.  The 'classify' argument defaults to '0', for no
%     classification.  If you want classification, set 'classify'
%     to '1'. The network is initialized using random Nguyen-Widrow 
%     values.  The min and max are used to adjust the Nguyen-Widrow 
%     values.
%
% $Id: mdlnet.m,v 1.1 1999/09/19 23:24:57 jak Exp $
%
 
    [ isamples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

    p = struct( ...
        'inputs'           , inputs    ...
       ,'outputs'          , outputs   ...
       ,'hidden_units'     , hiddencnt ...
       ,'param_count'      , outputs * (hiddencnt+1) ...
                             + hiddencnt * (inputs+1) ...
       ,'Wh'               , []        ...
       ,'Bh'               , []        ...
       ,'Wo'               , []        ...
       ,'classify'         , classify  ...
    );
    p = class( p, 'mdlnet' ); 
    
    MaM = zeros( inputs, 2);
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
        if min == max
            MaM(r,1)= -1;
            MaM(r,2)= 1;
        else
            MaM(r,1)=min;
            MaM(r,2)=max;
        end
    end
    
    
  % Initialize Hidden weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  % [p.Wh, p.Bh] = nwtan( p.hidden_units, MaM );
  % ---
    % Uniform Distribution (original Nguyen-Widrow)
    %p.Wh = 2 * rand( p.hidden_units, p.inputs ) - 1;
    %p.Bh = 2 * rand( p.hidden_units, 1        ) - 1;

    % Normal Distribution (variation on Nguyen-Widrow)
    p.Wh = randn( p.hidden_units, p.inputs ); 
    p.Bh = randn( p.hidden_units, 1        ); 
    
    % Normalize Rows to Unit Vectors
    p.Wh = sqrt( ones ./ ( sum(( p.Wh .* p.Wh )') ))' * ones(1,p.inputs) .* p.Wh ;

    % Scale Hidden Units to cover region based on the number of 
    % hidden units and inputs desired.
    magw = 0.1 * p.hidden_units ^ ( 1/p.inputs );
    p.Wh = magw * p.Wh ; % randnr(p.hidden_units, p.inputs);
    p.Bh = magw * p.Bh ; % rands(p.hidden_units, 1 );

    % Scale Hidden Weights to accomodate the input data ranges.
    rngmin = MaM(:,1);
    rngmax = MaM(:,2);
    rng =  rngmax - rngmin;
    mid = (rngmax + rngmin)/2;    
    p.Wh = 2 * p.Wh ./ ( ones(p.hidden_units,1) * rng' );
    p.Bh = p.Bh - p.Wh * mid;
  
  % ---
    
  % Initialize Output weights and biases.
  % Use Least Mean Squares
  %
    H = [ ones(isamples, 1), tansig( p.Wh * I_samples', p.Bh)' ];
  %  p.Wo = O_samples' * pinv( H )';
    p.Wo = O_samples' / H';
            
% endfunction mdlnet

% ****************************************
% History:
% $Log: mdlnet.m,v $
% Revision 1.1  1999/09/19 23:24:57  jak
% Initial revision
%
%
