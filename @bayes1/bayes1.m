
function p = bayes1( I_samples, O_samples, hidden_units )
% bayes1 - Constructor for bayes1 Class
%
%     p = bayes1(I_samples, O_samples, hidden_units )
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
% $Id: bayes1.m,v 1.2 1998/03/08 07:18:19 jak Exp $
%

    [ isamples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );
    samples = isamples;

    disp_freq = 10;
    max_epoch = 100;
    err_goal = 0.02;
    lr = 0.000000025;
    lr_inc = 1.05;
    lr_dec = 0.7;
    momentum = 0.9;
    err_ratio = 1.04;

    p = struct( ...
        'inputs'           , inputs       ...
       ,'outputs'          , outputs      ...
       ,'hidden_units'     , hidden_units ...
       ,'Wh'               , []           ...
       ,'Bh'               , []           ...
       ,'Wo'               , []           ...
       ,'Tp'               , [disp_freq max_epoch err_goal lr lr_inc lr_dec momentum err_ratio] ...
       ,'freezeHiddenLayer', 0            ...
    );
    p = class( p, 'bayes1' ); 
    
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

    p.outputs = outputs;
    [p.Wh, p.Bh, p.Wo ] = initialize( p.inputs, p.hidden_units, p.outputs, MaM );
        
  % ---------------------------------------
  % Generate Enhancement Functions of Inputs.
  % 
    if isempty( p.Wh )
        H = [ ones(isamples,1) ];
    else
        H = [ ones(isamples,1), tansig( p.Wh * I_samples', p.Bh)' ];
    end

    p.Wo = O_samples' * pinv( H )';

    %%% -----------------------------------------------------------
    %%%  % Y (outputs x samples) = p.Wo (outputs x hiddens) * H' (hiddnes x samples)
    %%%   p.Wo = O_samples' * pinv( H' );
    %%% -----------------------------------------------------------

  % ---------------------------------------
  % Calculate Network Output
  %
    Y = (p.Wo * H');

  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( outputs, osamples );
    for i=1:osamples 
        max = 1;
        for j=2:outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end

  % ---------------------------------------
  % Calculate Mean Square Error
  %
    err =  Y - O_samples';
%    err =  Yc - O_samples';
    sse = 10^-20;
    for i=1:outputs
        sse = sse + (err(i, :) * err( i, : )');
    end

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = p.outputs * p.hidden_units +  p.hidden_units * p.inputs; 
    DataCnt  = isamples * (p.inputs + p.outputs); 

  % ---------------------------------------
  % Form Convergence Criterion
  %
    SEC = DataCnt * log( sse / (osamples * outputs) ) ...
              + ParamCnt * log( DataCnt );
    
    fprintf( 1, '%d nodes: SEC = %e, sse = %e\n', p.hidden_units, SEC, sse );


  % ----
  %  p = train( p, I_samples, O_samples );

% endfunction bayes1

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
  W2 = rands( outputs, hidden_units + 1) * 0.5; 
  
% endfunction initialize


% ****************************************
% History:
% $Log: bayes1.m,v $
% Revision 1.2  1998/03/08 07:18:19  jak
% Well .... it works now ... thanks to God.  -jak
%
% Revision 1.1  1998/03/08 00:23:37  jak
% Ooops wrong name. -jak
%
% Revision 1.1  1998/03/07 22:57:37  jak
% Added new test class. -jak
%
% Revision 1.3  1997/11/25 18:26:14  jak
% Added some useful features to improve classification performance. -jak
%
% Revision 1.2  1997/11/18 16:50:28  jak
% Some experiments to test performance under different SECs. -jak
%
% Revision 1.1  1997/11/08 04:37:55  jak
% First Turn in of Self-Organizing Percepton Network! - jak
%
%
