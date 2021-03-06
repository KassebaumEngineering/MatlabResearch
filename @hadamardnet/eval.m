
function [ Yc, Y ] = eval( p, I_samples )
% eval - jaknet Class Method
%
%     [Y, Yc ] = eval( p, arg )
%
% Description: Evaluate the jaknet with collection of
% input samples.
%
%     p         -> a jaknet Instance
%     I_samples -> samples x inputs
%
% $Id: eval.m,v 1.1 1999/09/19 23:29:43 jak Exp $
%

  % ---------------------------------------
  % Network Architecture Validation
  %
    [samples,  inputs ] = size( I_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('sopnet method: eval()');
    end

  % ---------------------------------------
  % Calculate Network Output
  %
    Yh = p.invhadamat * ...
         real( ( p.Wo * ...
               [ ones(samples, 1), ...
                 tanh(p.Wh * [ ones(samples, 1), I_samples]')' ...
               ]' ...
             ) ...
         );
    Y = Yh(1:p.outputs, : );
    
  % ---------------------------------------
  % Assign Outputs to Classes
  %
    Yc = zeros( p.outputs, samples );
    for i=1:samples 
        max = 1;
        for j=2:p.outputs 
            if Y(j, i) > Y(max, i)
                max = j;
            end
        end
        Yc( max, i ) = 1;
    end
    
    Y = Y';
    Yc = Yc' ;

% endfunction eval

%*****************************************************
% History:
% 
% $Log: eval.m,v $
% Revision 1.1  1999/09/19 23:29:43  jak
% Initial revision
%
% Revision 1.2  1998/03/07 22:58:13  jak
% I don't know .... hmmm. -jak
%
% Revision 1.1  1997/11/29 21:10:39  jak
% A New network type - uses LMS training to improve first layer. -jak
%
%
