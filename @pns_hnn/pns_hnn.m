
function p = pns_hnn( In_samples, O_samples, varargin )
% pns_hnn - pns_hnn Class Method
%
%     p = pns_hnn( I_samples, O_samples, ProbThreshold, OutputClasses, OutputCnt )
%
% Description: This is the Hierarchical PNS module network.  
% The arguments for the construction: 
%   I_samples     - (samples x  inputs) - The  input training samples.
%   O_samples     - (samples x outputs) - The output training samples.
%
%  optional:
%   ProbThreshold - scalar probability (0 .. 1) which is the class 
%                   error probability minimum for class rejection.
%   OutputClasses - (1 x outputs) - Assignment of net outputs to arbitrary 
%                   classes via identication numbers.
%   OutputCnt     - the number of outputs in the true parent system
%
% The pns_hnn returns a PNS module or hierarchy.
%
% $Id: pns_hnn.m,v 1.4 1997/11/25 18:24:55 jak Exp $
%

% ------
% Retrieve data and needed parameters from the arguments
%
  fprintf(2,'<pns>: \n');

  [ isamples,  inputs ] = size( In_samples );
  [ osamples, outputs ] = size( O_samples );
  if isamples ~= osamples
      fprintf(2,'%d input samples not eqaul to %d output samples !\n', isamples, osamples);
      exit 1
  else
      sampleCnt = isamples;
  end
  if 0 == sampleCnt 
      fprintf(2,'N %d samples! -> doing nothing!\n', sampleCnt);
      return;
  end
  
% -----
% Test Varargin
%
  if ~isempty( varargin ) & (5 == nargin)
      ProbThreshold = varargin{1};
      if ProbThreshold < 0.0
          PassMinusOne = 1;
      else 
          PassMinusOne = 0;
      end
      OutputClasses = varargin{2};
      OutputCnt = varargin{3};
      inputs = 100;
      Transform = sopnet( In_samples, inputs, 2*inputs, 0 );
      [Nothing, I_samples] = eval( Transform, In_samples );
  else
      if ~isempty( varargin )
          ProbThreshold = varargin{1};
      else
          ProbThreshold = -1.0;
      end
      if ProbThreshold < 0.0
          PassMinusOne = 1;
      else 
          PassMinusOne = 0;
      end
      OutputClasses = [];
      for i=1:outputs
          OutputClasses = [ OutputClasses, i ];
      end
      OutputCnt = outputs;
%      inputs = 100;
%      Transform = sopnet( In_samples, inputs, 2*inputs, 0 );
%      [Nothing, I_samples] = eval( Transform, In_samples );
      Transform = [];
      I_samples = In_samples;
  end

% ------
% Define the PNS structure
%
  p = struct( ...
            'transform'    , Transform      ...
           ,'P'            , []             ...
           ,'N'            , []             ...
           ,'S'            , []             ...
           ,'pnsReject'    , []             ...
           ,'outputClass'  , OutputClasses  ...
           ,'outputCnt'    , OutputCnt      ...
        );
  p = class( p, 'pns_hnn' );
 
% ------
% Train N: I -> D => Y, Yc 
% Calculate probabilities of correct classification.
%
  fprintf(2,'N %d samples -> %d outputs\n', sampleCnt, p.outputCnt );
  
  
  p.N = sopnet( I_samples, O_samples );

  [Yc, Y ] = eval( p.N, I_samples );
  [cmat, pc, tpc] = conf( O_samples, Yc );

% ------
%  Base Case: (stop recursion)
%    if 'probability of correct classification' for each class is
%    greater than the argument Pth 'Probability Threshold'.
%
  cmat
  pc
  tpc
  if ProbThreshold < 0.0
      ProbThreshold = tpc / 100.0;
  end

%  if ( tpc >= (ProbThreshold * 100.0) ) | (length( pc ) < 2)
  if ( min( pc ) >= (ProbThreshold * 100.0) ) | (length( pc ) < 2)
  
      p.P = [];
      % set above -> p.N = p.N;
      p.S = [];
      p.pnsReject = [];
      
      return

  end

% ------
% Construct Pre-Rejector, Accepted, and Rejected Training Data
%
  samples_per_class = sum( O_samples );
  rejCnt = 0;
  rejSampleCnt = 0;
  rejClass = [];
  accClass = [];
  for i = 1:outputs
      if pc(i) < (ProbThreshold * 100.0)
          rejCnt = rejCnt+1;
          rejSampleCnt = rejSampleCnt + samples_per_class(i);
          rejClass = [ rejClass, i ];
      else
          accClass = [ accClass, i ];
      end
  end
  
  R_in  =  zeros( rejSampleCnt, inputs );
  R_out =  zeros( rejSampleCnt, rejCnt ); 
  Rsample = 0;
  for i=1:length( rejClass )
      for j=1:sampleCnt
          if 0 ~= O_samples( j, rejClass(i) )
               Rsample = Rsample + 1;
               R_in ( Rsample, : ) = I_samples( j, : );
               for k = 1:length( rejClass )
                   R_out( Rsample, k ) = O_samples( j, rejClass( k ) );
               end
          end
      end
  end
  
  N_in  =  zeros( sampleCnt - rejSampleCnt, inputs );
  N_out =  zeros( sampleCnt - rejSampleCnt, outputs - rejCnt );
  Asample = 0;
  for i=1:length( accClass )
      for j=1:sampleCnt
          if 0 ~= O_samples( j, accClass(i) )
               Asample = Asample + 1;
               N_in ( Asample, : ) = I_samples( j, : );
               for k = 1:length( accClass )
                   N_out( Asample, k ) = O_samples( j, accClass( k ) );
               end
          end
      end
  end
  
  P_in  =  I_samples;
  P_out =  zeros( sampleCnt, 2 );
  for i = 1:outputs
      if pc(i) < (ProbThreshold * 100.0)  % Reject => 1
          for j = 1:sampleCnt
              if 0 ~= O_samples( j, i )
                  P_out(j, 1) = 1;
              end
          end
      else                                % Accept => 2
          for j = 1:sampleCnt
              if 0 ~= O_samples( j, i )
                  P_out(j, 2) = 1;
              end
          end
      end
  end
  
% ------
% Train P: I -> Reject/Accept => Y, Yc 
% Calculate probabilities of correct classification.
%
  fprintf(2,'P %d samples -> accept %d, reject %d\n', sampleCnt, sampleCnt - rejSampleCnt, rejSampleCnt);
  
  p.P = sopnet( P_in, P_out );
  
  [PreRejc, PreRej ] = eval( p.P, P_in );
  [cmat, pc, tpc] = conf( P_out, PreRejc );
  cmat
  pc
  tpc
  

% ------
% Train N: I -> D => Y, Yc 
%
%  fprintf(2,'N %d samples\n', Asample);
%  p.N = pns_hnn( N_in, N_out, ProbThreshold, accClass, p.outputCnt );


%  Big_N_out = zeros( sampleCnt-rejSampleCnt, p.outputCnt );
%  for i = 1:length( accClass )
%      Big_N_out( :, accClass(i) ) = N_out( :, i );
%  end
  
%  p.N = sopnet ( N_in, Big_N_out );
%  [Yc, Y ] = eval( p.N, N_in );

%  [cmat, pc, tpc] = conf( Big_N_out, Yc );
%  cmat
%  pc
%  tpc

% ------
% Train S: I_samples, Y -> |D-Yc| => Spe - prob of error per sample
%     
 % Erroneously Classified Points
%  desiredSPe    = 0.5 * sum( abs( Big_N_out - Yc )' )';
 % Correct Classifications
%  desiredSPeBar = ones( Asample, 1 ) - desiredSPe; 

%  fprintf(2,'S %d samples -> accept %d, reject %d\n', Asample, sum(desiredSPeBar), sum(desiredSPe));
  
 % Erroneously Classified Points
  desiredSPe    = 0.5 * sum( abs( O_samples - Yc )' )';
 % Correct Classifications
  desiredSPeBar = ones( sampleCnt, 1 ) - desiredSPe; 

  fprintf(2,'S %d samples -> accept %d, reject %d\n', sampleCnt, sum(desiredSPeBar), sum(desiredSPe));

%  p.S = sopnet( [I_samples, Y], [desiredSPe, desiredSPeBar] );
  p.S = sopnet( Y, [desiredSPe, desiredSPeBar] );
  
%  [PostRejc, PostRej ] = eval( p.S, [I_samples, Y] );
  [PostRejc, PostRej ] = eval( p.S, Y );
  [cmat, pc, tpc] = conf( [desiredSPe, desiredSPeBar], PostRejc );
  cmat
  pc
  tpc
  
% ----
% Train pnsReject: R -> D => RYc, RY  -> Freeze P!
%
  fprintf(2,'pnsReject  %d samples\n', Rsample );
  if 1 == PassMinusOne 
       p.pnsReject = pns_hnn( R_in, R_out, -1.0, rejClass, p.outputCnt );
  else
       p.pnsReject = pns_hnn( R_in, R_out, ProbThreshold, rejClass, p.outputCnt );
  end
  
% endfunction pns_hnn

%*****************************************************
% History:
% 
% $Log: pns_hnn.m,v $
% Revision 1.4  1997/11/25 18:24:55  jak
% Total re-write to improve useability. -jak
%
% Revision 1.3  1997/11/18 16:49:43  jak
% Fixing bugs - still not ready for prime time though. -jak
%
% Revision 1.2  1997/11/07 05:40:17  jak
% More code - not working yet though!  -jak
%
% Revision 1.1  1997/11/04 16:54:32  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%
