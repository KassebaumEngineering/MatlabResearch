
function [SEC, MSE] = perf(p, I_samples, O_samples)
% PERF - mdlnet Class Instance Method
%
%     p = perf(p, I_samples, O_samples)
%     
%     Perf evalutes the neural network 'p' using 
%     the 'I_samples' data provided, and reports
%     performance measures. 
%
%     p         -> a mdlnet Instance
%     I_samples -> samples x inputs
%
% $Id: perf.m,v 1.2 1999/09/30 04:34:54 jak Exp $
%

    % ---------------------------------------
    % Network Architecture Validation
    %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('mdlnet method: eval()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('mdlnet method: eval()');
    end
    samples = isamples;
    
    % ---------------------------------------
    % Calculate Net Output.
    %
    Y = p.Wo * [ ones( samples, 1 ), tansig( p.Wh * I_samples' + p.Bh * ones( 1, samples ))' ]';

    if ( 1 == p.classify )
        % ---------------------------------------
        % Assign Outputs to Classes
        %
        Yc = zeros( p.outputs, samples );
        for i=1:samples 
            max = 1;
            for j=2:p.outputs 
                if Y(j,i) > Y(max,i)
                    max = j;
                end
            end
            Yc( max, i ) = 1;
        end
        
      % ---------------------------------------
      % Use Classification error
      %
        err =  Yc - O_samples';
    else
      % ---------------------------------------
      % Use Residual error
      %
        err =  Y - O_samples';
    end

  % ---------------------------------------
  % Calculate Mean Square Error
  %
    MSE = 10^-20;
    for i=1:outputs
        MSE = MSE + (err(i, :) * err( i, : )');
    end
    MSE = MSE / (outputs * samples);

  % ---------------------------------------
  % Calculate Structure and Data Size Penalty Terms
  %
    ParamCnt = p.param_count; 
    DataCnt  = samples * p.outputs; 
  %
  % incorrect because residual is the error in the outputs - not the inputs
  %
  %  DataCnt  = samples * (p.inputs + p.outputs); 

  % ---------------------------------------
  % Form Convergence Criterion
  %
%%    SEC = DataCnt * log( MSE ) + ParamCnt * log( DataCnt );
    SEC = DataCnt * log2( MSE )/2 + ParamCnt;

% ****************************************
% History:
% $Log: perf.m,v $
% Revision 1.2  1999/09/30 04:34:54  jak
% Changes to files - added use of deterministic initialization. -jak
%
% Revision 1.1  1999/09/19 23:34:32  jak
% New version of @jaknet - to use for MDL surface topology experiments. -jak
%
