
function p = jaknet( I_samples, O_samples, varargin )
% jaknet - jaknet Class Constructor Method
%
%     p = jaknet( I_samples, O_samples )
%
% Description: Jaknet creates a single layer perceptron
% structured network with tanh nonlinearities at the
% outputs of the hidden layer.
%
% $Id: hadamardnet.m,v 1.1.1.1 1999/09/19 23:29:43 jak Exp $
%
    
    [  samples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

    % ------------------------------------
    % The Hadamard Transform Matrix
    %   HADAMARD(N) is a Hadamard matrix of order N, that is,
    %   a matrix H with elements 1 or -1 such that H'*H = N*EYE(N).
    %   An N-by-N Hadamard matrix with N > 2 exists only if REM(N,4)=0.
    %   This function handles only the cases where N, N/12 or N/20
    %   is a power of 2.
    % ------------------------------------
    % thus :
    % hadasizes = [4,8,12,16,20,24,32,40,48,60,64,72,80, ... ];
    % 4 ,8 ,16,32,64
    % 12,24,48,72
    % 20,40,60,80
    
    hadasizes = [];
    for i=2:log2(outputs)+1
        hadasizes = [ hadasizes, 2^i ];
    end
    for i=2:log2(outputs)-1
        hadasizes = [ hadasizes, 3*2^i ];
    end
    for i=2:log2(outputs)-1
        hadasizes = [ hadasizes, 5*2^i ];
    end
    hadasizes = sort( hadasizes );

    for i = 1 : length( hadasizes )
        if outputs < hadasizes( i )
            hadaputs = hadasizes( i );
            break;
        end
    end

    hadamat = hadamard( hadaputs );
    invhadamat = hadamat' / hadaputs;
    
    p = struct( ...
        'inputs'           , inputs                ...
       ,'outputs'          , outputs               ...
       ,'hadaputs'         , hadaputs              ...
       ,'hadamat'          , hadamat               ...
       ,'invhadamat'       , invhadamat            ...
       ,'hidden_units'     , 0                     ...
       ,'Wh'               , []                    ...
       ,'Wo'               , []                    ...
       ,'freezeHiddenLayer', 0                     ...
    );
    p = class( p, 'jaknet');
    
    
    H_samples = (p.hadamat * [ O_samples, zeros(samples, hadaputs-outputs ) ]')';
    
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

    MaMout = zeros( hadaputs, 2);
    for r= 1:hadaputs
        min = H_samples(1, r);
        max = H_samples(1, r);
        for i= 2:samples
        if  H_samples(i, r) > max
            max = H_samples(i, r);
        end
        if  H_samples(i, r) < min
            min = H_samples(i, r);
        end
        end
        if min == max
            MaMout(r,1)= -1;
            MaMout(r,2)= 1;
        else
            MaMout(r,1)=min;
            MaMout(r,2)=max;
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
        [ p.Wh, p.Wo ] = initialize( p.inputs, p.hidden_units, p.hadaputs, MaM, MaMout );
    else    
        p.outputs = outputs;
        [ p.Wh, p.Wo ] = initialize( p.inputs, p.hidden_units, p.hadaputs, MaM, MaMout );
        p = train( p, I_samples, O_samples );
    end 

% endfunction jaknet

% --------------------------------
% Subfunction initialize
%
%    initialize uses the Random Nguyen-Widrow formulas to 
%    initialize the weights of the Perceptron
%

function [ W1, W2 ] = initialize( inputs, hidden_units, outputs, MinsAndMaxs, MaMout )

  % Initialize weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  [Wr,Br] = nwtan( hidden_units, inputs, MinsAndMaxs);
  [Wi,Bi] = nwtan( hidden_units, inputs, MinsAndMaxs);
  W1 = [ Br + i*Bi, Wr + i*Wi ];
  [Wr,Br] = nwtan( outputs, hidden_units, MaMout );
  [Wi,Bi] = nwtan( outputs, hidden_units, MaMout );
  W2 = [ Br + i*Bi, Wr + i*Wi ]; 
  
% endfunction initialize

%*****************************************************
% History:
% 
% $Log: hadamardnet.m,v $
% Revision 1.1.1.1  1999/09/19 23:29:43  jak
% Re-checkin of original @jaknet - named changed to @hadamardnet for clarity. -jak
%
% Revision 1.2  1998/03/07 22:58:14  jak
% I don't know .... hmmm. -jak
%
% Revision 1.1  1997/11/29 21:10:39  jak
% A New network type - uses LMS training to improve first layer. -jak
%
%
