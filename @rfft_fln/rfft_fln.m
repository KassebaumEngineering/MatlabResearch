
function p = rfft_fln(I_samples, hidden_units, varargin)
% rfft_fln - Constructor for rfft_fln Class 
%
%     p = rfft_fln(I_samples, hidden_units [, O_Samples or NumberOfOutputVars])
%
% Description: Creates a neural network with an fixed architecture
%     given by the number of hidden units, and I_samples and O_Samples
%     passed as arguments.  The network is initialized using a
%     real fft. The inputs are padded with zeros to match the 
%     number of hidden units specified, which must be a power of 2.
%
% $Id: rfft_fln.m,v 1.1 1997/11/04 16:55:11 jak Exp $
%

    [ samples, inputs ] = size( I_samples );
    p.inputs = inputs;
    p.hidden_units = hidden_units; % MUST BE A POWER OF 2

    if isempty( varargin{1} )
        p.outputs = 1;
        p.Wo = initialize( p.hidden_units, p.outputs );
        p = class(p, 'rfft_fln');
    else    
        [osamples outputs] = size( varargin{1} );
        if osamples == 1 & outputs == 1 % arg is scalar number of outputs
            p.outputs = varargin{1};
            p.Wo = initialize( p.hidden_units, p.outputs );
            p = class(p, 'rfft_fln');
        else                            % Train the Network Output Layer
            p.outputs = outputs;
            O_samples = varargin{1};
            p.Wo = initialize( p.hidden_units, p.outputs );
            p = class(p, 'rfft_fln');
            p = train( p, I_samples, O_samples );
        end
    end


% endfunction rfft_fln


% --------------------------------
% Subfunction initialize
%
%    initialize uses the Random Nguyen-Widrow formulas to 
%    initialize the weights of the Perceptron
%

function W2 = initialize( hidden_units, outputs )

  % Initialize weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  W2 = rands( outputs, hidden_units ) * 0.5; 

% endfunction initialize

%*****************************************************
% History:
% 
% $Log: rfft_fln.m,v $
% Revision 1.1  1997/11/04 16:55:11  jak
% First Check in of running fft Network Class. -jak
%
%
