
function p = perceptron(inputs, hidden_units, outputs, I_samples)
% PERCEPTRON - Constructor for Perceptron Class
%
%     p = perceptron(inputs, hidden_units, outputs, I_samples)
%     
%     Creates a neural network with an fixed architecture
%     given by the number of inputs, hidden units, and outputs
%     passed as arguments.  The network is initialized using
%     random Nguyen-Widrow values.  If the training input samples -
%     I_samples - are provided (optional argument), then the min
%     and max are used to adjust the Nguyen-Widrow values.
%
% $Id: perceptron.m,v 1.1.1.1 1997/10/28 18:38:44 jak Exp $

  if nargin == 0 || nargin == 1 || nargin == 2
      fprintf (2, 'perceptron() must be passed at least three arguments!');
      help perceptron
      error();
    
  elseif nargin == 4
      validate( inputs, I_samples );
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
      [p.Wh p.Bh p.Wo p.Bo] = initialize( inputs, hidden_units, outputs, MaM );

  elseif nargin == 3
      [p.Wh p.Bh p.Wo p.Bo] = initialize( inputs, hidden_units, outputs );

  else
      fprintf (2, 'Percptron() must be passed no more than four arguments!');
      help perceptron
      error();

  end
  
  p.inputs = inputs;
  p.hidden_units = hidden_units;
  p.outputs = outputs;
  
  disp_freq = 10;
  max_epoch = epochs;
  err_goal = 0.02;
  lr = 0.01;
  lr_inc = 1.05;
  lr_dec = 0.7;
  err_ratio = 1.04;
    
  p.TP = [disp_freq max_epoch err_goal lr lr_inc lr_dec err_ratio];

  p = class(p, 'perceptron');
  
% endfunction perceptron

% --------------------------------
% Subfunction initialize
%
%    initialize uses the Random Nguyen-Widrow formulas to 
%    initialize the weights of the perceptron
%

function [ W1 B1 W2 B2 ] = initialize( inputs, hidden_units, outputs, MinsAndMaxs )

  % Initialize weights and biases.
  % Use Random Nguyen-Widrow Values
  %
  [W1,B1] = nwtan(hidden_units,inputs,MaM);
  W2 = rands(classes,hidden_units)*0.5; 
  B2 = rands(classes,1)*0.5;

% endfunction initialize


% --------------------------------
% Subfunction validate
%
%    validate verifies the agreement of the perceptron 
%    architecture with the given training data
%

function validate( inputs, I_samples )

  [samples, channels] = size( I_samples );
  if channels ~= inputs 
      fprintf( 2, 'Samples with %d inputs do not match specified %d inputs!', channels, inputs);
      error('Incompatible Initial Training Data!');
  end

% endfunction validate


% ****************************************
% History:
% $Log: perceptron.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:44  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
