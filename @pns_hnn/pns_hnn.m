
function p = pns_hnn( TrainingSamples, ProbThreshold )
% pns_hnn - pns_hnn Class Method
%
%     p = pns_hnn( TrainingSamples, ProbThreshold )
%
% Description: This is the Hierarchical PNS module network.  
% The arguments for the construction: 
%   TrainingSamples - a collection of iodata samples, or iodata 
%   ProbThreshold   - scalar probability (0 .. 1)
%
% The pns_hnn returns a PNS module or hierarchy.
%
% $Id: pns_hnn.m,v 1.1 1997/11/04 16:54:32 jak Exp $
%

% ------
% Retrieve data and needed parameters from the arguments
%
  % should do more error checking!
  if (1 == isa( TrainingSamples, 'collection' ))
      ioSamples = getAllData( getTrainingSamples( TrainingSamples ));
  else % iodata
      ioSamples = TrainingSamples; 
  end
  [ isamples, osamples ] = getSamplePair( ioSamples, ':' );
  samples = getSampleSize( ioSamples );
  
% ------
% Train N: I -> D => Y, Yc 
% Calculate probabilities of correct classification.
%
  N = chen_fln( inputsamples, 100, outputsamples );
  [Yc, Y ] = eval( net, inputsamples );
  [cmat, pc, tpc] = conf( outputsamples, Yc );

% ------
%  Base Case: (stop recursion)
%    if 'probability of correct classification' for each class is
%    greater than the argument Pth 'Probability Threshold'.
%
  if ( min( pc ) > (ProbThreshold * 100.0) )
  
      p.P = [];
      p.N = N;
      p.S = [];
      p.pnsReject = [];
      
      p = class( p, 'pns_hnn');
      return

  end

% ------
% Construct Post-Reject Training Data
%
  % Erroneously Classified Points
  desiredSPe    = sum( abs( outputsamples - Yc ) );
  desiredSPeBar = ones( samples, 1 ) - desiredSPe; % Correct Classifications
  STrainData = iodata( 'Post-reject Training Data', Y, [desiredSPe, desiredSPeBar], 0 );
  
%
% Train S: Y -> |D-Yc| => Spe - prob of error per sample
%
  p.S = pns_hnn( STrainData, ProbThreshold );
  [PostRejc, PostRej ] = eval( p.S, Y );

% ------
% Construct Pre-Rejector Training Data 
%
  % Erroneously Classified Classes
  for i=1:getOutputSize( ioSamples )
      if pc(i) > (ProbThreshold * 100.0)
          for j=1:samples
              if 1 == osamples(j,i)
                  desiredPPe(j) = 1;
              else
                  desiredPPe(j) = desiredSPe(j);
              end
          end
      end
  end
  desiredPPeBar = ones( samples, 1 ) - desiredPPe; % Correct Classifications

%
% Assemble iodata for P-unit Accept and Reject classes
%
  PTrainData = iodata( 'Pre-reject Training Data', isamples, [desiredPPe, desiredPPeBar], 0 );
  
%
% Train P: I -> R/A => <Ir, Dr> and <Ia, Da>  -> Freeze P!
%
  p.P = pns_hnn( PTrainData, ProbThreshold );
  [PreRejc, PreRej ] = eval( p.P, isamples );
  
% ------
% Assemble new iodata for Rejected and Accepted data samples.
%
% ****UNDER CONSTRUCTION    
  RejectedTrainData = iodata( 'Rejected Training Data', isamples, [desiredPPe, desiredPPeBar], 0 );
  AcceptedTrainData = iodata( 'Rejected Training Data', isamples, [desiredPPe, desiredPPeBar], 0 );
  
%
% Train pnsReject: R -> D => RYc, RY  -> Freeze P!
%
  
  
%
% Return a pns_hnn class object.
%
  p = class( p, 'pns_hnn');

% endfunction pns_hnn

%*****************************************************
% History:
% 
% $Log: pns_hnn.m,v $
% Revision 1.1  1997/11/04 16:54:32  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%
