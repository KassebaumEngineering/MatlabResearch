
function p = rfft_fln(I_samples, O_samples, varargin)
% rfft_fln - Constructor for rfft_fln Class 
%
%   p = rfft_fln(I_samples, O_samples,[ hidden_units, CvgOff])
%
%   Creates a neural network with an fixed architecture
%   given by the number of hidden units, and I_samples and O_Samples
%   passed as arguments.  The network is initialized using a
%   real fft. The inputs are padded with zeros to match the 
%   number of hidden units specified, which must be a power of 2.
%   The CvgOff argument, if supplied, tells the 
%   object to avoid iterative training and to use exactly the
%   number of hidden_nodes specified.
%
% $Id: rfft_fln.m,v 1.2 1997/11/07 06:20:09 jak Exp $
%

    [  samples, inputs ] = size( I_samples );
    [ osamples, outputs] = size( O_samples );
    
    for i=1:8
        if 2^i > inputs
            hidden_units = 2^i;
            break;
        end
    end
    
    p = struct( ...
        'inputs'           , inputs            ...
       ,'outputs'          , 1                 ...
       ,'hidden_units'     , hidden_units      ...
       ,'Bh'               , []                ...
       ,'Wo'               , []                ...
       ,'freezeHiddenLayer', 0                 ...
    );
    p = class( p, 'rfft_fln' ); 
    
    if ~isempty( varargin )
        p.hidden_units = varargin{1}; % MUST BE A POWER OF 2
        if ( nargin > 3 )
            p.freezeHiddenLayer = 1;
        end
    end

    if ((1 == osamples) & (1 == outputs))
        p.outputs = O_samples;
        p.Wo = initialize( p.hidden_units, p.outputs );
    else    
        p.outputs = outputs;
        p.Wo = initialize( p.hidden_units, p.outputs );
        p = train( p, I_samples, O_samples );
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
% Revision 1.2  1997/11/07 06:20:09  jak
% Changed calling conventions, cleaned up stuff, ready for iteration. -jak
%
% Revision 1.1  1997/11/04 16:55:11  jak
% First Check in of running fft Network Class. -jak
%
%
