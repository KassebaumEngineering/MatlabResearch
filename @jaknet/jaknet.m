
function p = jaknet( I_samples, O_samples, varargin )
% jaknet - jaknet Class Constructor Method
%
%     p = jaknet( I_samples, O_samples )
%
% Description: Jaknet creates a single layer perceptron
% structured network with tanh nonlinearities at the
% outputs of the hidden layer.
%
% $Id: jaknet.m,v 1.1 1997/11/29 21:10:39 jak Exp $
%
    
    [  samples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

    p = struct( ...
        'inputs'           , inputs  ...
       ,'outputs'          , outputs ...
       ,'hidden_units'     , 0       ...
       ,'Wh'               , []      ...
       ,'Wo'               , []      ...
       ,'freezeHiddenLayer', 0       ...
    );
    p = class( p, 'jaknet');
    
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
        if min == max
            MaM(r,1)= -1;
            MaM(r,2)= 1;
        else
            MaM(r,1)=min;
            MaM(r,2)=max;
        end
    end

    if ~isempty( varargin ) 
        p.hidden_units = varargin{1};
        if ( nargin > 3 )
            p.freezeHiddenLayer = 1;
        end
    end
    
    if ((1 == osamples) & (1 == outputs))
        p.outputs = O_samples;
        [ p.Wh, p.Wo ] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
    else    
        p.outputs = outputs;
        [ p.Wh, p.Wo ] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
        p = train( p, I_samples, O_samples );
    end 

% endfunction jaknet

% --------------------------------
% Subfunction initialize
%
%    initialize uses the Random Nguyen-Widrow formulas to 
%    initialize the weights of the Perceptron
%

function [ W1, W2 ] = initialize( inputs, hidden_units, outputs, MinsAndMaxs )

  % Initialize weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  [W1,B1] = nwtan( hidden_units, inputs, MinsAndMaxs);
  W1 = [ B1, W1 ];
  W2 = rands( outputs, hidden_units + 1) * 0.5; 
  
% endfunction initialize

%*****************************************************
% History:
% 
% $Log: jaknet.m,v $
% Revision 1.1  1997/11/29 21:10:39  jak
% A New network type - uses LMS training to improve first layer. -jak
%
%
