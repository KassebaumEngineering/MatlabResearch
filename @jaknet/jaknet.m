
function p = jaknet( I_samples, O_samples, hiddencnt, varargin )
% jaknet - Constructor for mdlnet Class
%
%     p = jaknet(I_samples, O_samples, hiddencnt [, classify] )
%     
%     Creates a neural network with an  architecture
%     which supports the I_samples and O_Samples which were
%     passed as arguments.  The hidden_units argument is an 
%     initializer for the number of hidden_units to use.  The 
%     'classify' argument defaults to '0', for no
%     classification.  If you want classification, set 'classify'
%     to '1'. The network is initialized using random Nguyen-Widrow 
%     values.  The min and max are used to adjust the Nguyen-Widrow 
%     values.
%
% $Id: jaknet.m,v 1.4 2000/03/27 13:36:23 jak Exp $
%
    if ~isempty( varargin )
        classify = varargin{1};
    else 
        classify = 0;
    end
    
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
       ,'classify'         , classify ...
    );
    
    p = class( p, 'jaknet' ); 
       
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
    
  %
  % Initialize Hidden Weights using the Bit Interleaved Sort on
  % the input Data Set
  % 
    I_Samples_BIS = BitInterleavedSort( I_samples, 3 );
    for h = 1:p.hidden_units
        randomIndex = floor( rand * isamples + 1 );
        p.Wh( h, : ) = I_Samples_BIS{ randomIndex, : };  % reverse the BIS mapping to get an input vector
    end
    p.Bh =  rand( p.hidden_units, 1       );
    
    
    
  %
  % Initialize Hidden Weights deterministically
  % 
%    nodes_per_dimension = p.hidden_units ^ (1/p.inputs)
%    p.Wh = zeros( p.hidden_units, p.inputs);    
%    p.Bh =  rand( p.hidden_units, 1       );
    
%    delta = 1/(2*nodes_per_dimension);
%    pval  = delta:(2 * delta):(nodes_per_dimension * 2 * delta + delta)
    
%    k = ones( p.inputs );
%    for h = 1:p.hidden_units
%        for i = 1:p.inputs
%            p.Wh( h, i ) = pval( k(i) );
%        end
%        k(1) = k(1) + 1;
%        for i = 1: (p.inputs - 1)
%            if ( k(i) > floor( nodes_per_dimension )+1 )
%                k(i+1) = k(i+1) + 1;
%                k(i) = 1;
%            end
%        end
%    end
    
    p.Wh = 2 * p.Wh - 1;
    p.Bh = 2 * p.Bh - 1;
    

  % Initialize Hidden weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  % [p.Wh, p.Bh] = nwtan( p.hidden_units, MaM );
  % ---
    % Uniform Distribution (original Nguyen-Widrow)
%    p.Wh = 2 * rand( p.hidden_units, p.inputs ) - 1;
%    p.Bh = 2 * rand( p.hidden_units, 1        ) - 1;

    % Normal Distribution (variation on Nguyen-Widrow)
    %p.Wh = randn( p.hidden_units, p.inputs ); 
    %p.Bh = randn( p.hidden_units, 1        ); 
    
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
    H = [ ones(isamples, 1), tansig( p.Wh * I_samples' +  p.Bh * ones( 1, isamples ) )' ];
    p.Wo = O_samples' / H';

  %  p.Wo = O_samples' * pinv( H )';
  
%%  % 1 iteration of iterative improvement:
%%    err = p.Wo * H' - O_samples';  err * err' /(isamples*p.outputs)
%%    werr = err / H';
%%    p.Wo = p.Wo + werr;
%%    
%%    err = p.Wo * H' - O_samples'; err * err' /(isamples*p.outputs)
            
% endfunction mdlnet

% ****************************************
% History:
% $Log: jaknet.m,v $
% Revision 1.4  2000/03/27 13:36:23  jak
% Small changes trying to get it through compile. -jak
%
% Revision 1.3  1999/09/30 04:34:54  jak
% Changes to files - added use of deterministic initialization. -jak
%
% Revision 1.3  1999/09/19 23:34:32  jak
% New version of @jaknet - to use for MDL surface topology experiments. -jak
%
%
