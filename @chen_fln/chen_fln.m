
function p = chen_fln(I_samples, hidden_units, varargin)
% CHEN_FLN - Constructor for Chen_fln Class
%
%     p = chen_fln(I_samples, hidden_units [, O_Samples or NumberOfOutputVars])
%     
%     Creates a neural network with an fixed architecture
%     given by the number of hidden units, and I_samples and O_Samples
%     passed as arguments.  The network is initialized using
%     random Nguyen-Widrow values.  The min and max are used to 
%     adjust the Nguyen-Widrow values.
%
% $Id: chen_fln.m,v 1.1 1997/10/28 18:38:43 jak Exp $
%
 
    [ samples, inputs ] = size( I_samples );

    MaM = zeros(inputs,2);
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

    p.inputs = inputs;
    p.hidden_units = hidden_units;
    
    
    if isempty( varargin{1} )
        p.outputs = 1;
        [p.Wh p.Bh p.Wo] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
        p = class(p, 'chen_fln');
    else    
        [osamples outputs] = size( varargin{1} );
        if osamples == 1 & outputs == 1 % arg is scalar number of outputs
            p.outputs = varargin{1};
            [p.Wh p.Bh p.Wo] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
            p = class(p, 'chen_fln');
        else                            % Train the Network Output Layer
            p.outputs = outputs;
            O_samples = varargin{1};
            [p.Wh p.Bh p.Wo] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
            p = class(p, 'chen_fln');
            p = train( p, I_samples, O_samples );
        end
    end
        
% endfunction chen_fln

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
% $Log: chen_fln.m,v $
% Revision 1.1  1997/10/28 18:38:43  jak
% Initial revision
%
%
