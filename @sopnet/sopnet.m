
function p = sopnet(I_samples, O_samples, varargin )
% sopnet - Constructor for sopnet Class
%
%     p = sopnet(I_samples, O_samples [, hidden_units, CvgOff] )
%     
%     Creates a neural network with an  architecture
%     which supports the I_samples and O_Samples which were
%     passed as arguments.  The hidden_units argument, if
%     supplied is an initializer for the number of hidden_units
%     to use.  The CvgOff argument, if supplied, tells the 
%     object to avoid iterative training and to use exactly the
%     number of hidden_nodes specified.  The O_Samples argument
%     may be a single number, instead of a vector of samples.
%     If it is, then it refers to the size of the output layer,
%     and NO training will be done. The network is initialized 
%     using random Nguyen-Widrow values.  The min and max are  
%     used to adjust the Nguyen-Widrow values.
%
% $Id: sopnet.m,v 1.1 1997/11/08 04:37:55 jak Exp $
%
 
    [  samples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

    p = struct( ...
        'inputs'           , inputs  ...
       ,'outputs'          , 1       ...
       ,'hidden_units'     , 10      ...
       ,'Wh'               , []      ...
       ,'Bh'               , []      ...
       ,'Wo'               , []      ...
       ,'freezeHiddenLayer', 0       ...
    );
    p = class( p, 'sopnet' ); 
    
    MaM = zeros( inputs, 2);
    for r= 1:inputs
        min = I_samples(1, r);
        max = I_samples(1, r);
        for i= 2:samples
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

    if ~isempty( varargin ) 
        p.hidden_units = varargin{1};
        if ( nargin > 3 )
            p.freezeHiddenLayer = 1;
        end
    end
    
    if ((1 == osamples) & (1 == outputs))
        p.outputs = O_samples;
        [p.Wh, p.Bh, p.Wo] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
    else    
        p.outputs = outputs;
        [p.Wh, p.Bh, p.Wo] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
        p = train( p, I_samples, O_samples, MaM );
    end 
        
% endfunction sopnet

% --------------------------------
% Subfunction initialize
%
%    initialize uses the Random Nguyen-Widrow formulas to 
%    initialize the weights of the Perceptron
%

function [ W1, B1, W2 ] = initialize( inputs, hidden_units, outputs, MinsAndMaxs )

  % Initialize weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  [W1,B1] = nwtan( hidden_units, inputs, MinsAndMaxs);
  W2 = rands( outputs, hidden_units) * 0.5; 

% endfunction initialize


% ****************************************
% History:
% $Log: sopnet.m,v $
% Revision 1.1  1997/11/08 04:37:55  jak
% First Turn in of Self-Organizing Percepton Network! - jak
%
%