
function p = pns_hnn( TrainingSamples, ProbThreshold )
% pns_hnn - pns_hnn Class Method
%
%     p = pns_hnn( TrainingSamples, ProbThreshold )
%
% Description: This is the Hierarchical PNS module network.  
% The arguments for the construction: 
%   TrainingSamples - a collection of iodata samples 
%   ProbThreshold   - scalar probability (0 .. 1)
%
% The pns_hnn returns a PNS module or hierarchy.
%
% $Id: pns_hnn.m,v 1.2 1997/11/07 05:40:17 jak Exp $
%

% ------
% Retrieve data and needed parameters from the arguments
%
fprintf(2,'<pns>: ');

  if (1 == isa( TrainingSamples, 'collection' ))
      ioSamples = getAllData( TrainingSamples );
  else % iodata
      fprintf( 1, 'PNS_HNN: Pass an iodata collection - not %s!', class(TrainingSamples));
      exit 1
  end
  
  [ isamples, osamples ] = getSamplePair( ioSamples, ':' );
  sampleCnt = getSampleSize( ioSamples );
  
% ------
% Train N: I -> D => Y, Yc 
% Calculate probabilities of correct classification.
%
fprintf(2,'N %d samples', sampleCnt);
  p.N = chen_fln( isamples, 30, osamples );
  [Yc, Y ] = eval( p.N, isamples );
  [cmat, pc, tpc] = conf( osamples, Yc );

% ------
%  Base Case: (stop recursion)
%    if 'probability of correct classification' for each class is
%    greater than the argument Pth 'Probability Threshold'.
%
  pc
  if ( min( pc ) > (ProbThreshold * 100.0) )
  
      p.P = [];
      % set above -> p.N = p.N;
      p.S = [];
      p.pnsReject = [];
      
      p = class( p, 'pns_hnn');
      return

  end

% ------
% Construct Post-Reject Training Data
%
  % Erroneously Classified Points
  desiredSPe    = 0.5 * sum( abs( osamples - Yc )' )';
  desiredSPeBar = ones( sampleCnt, 1 ) - desiredSPe; % Correct Classifications
  STrainData = collection( 'S Training Data' ...
                   ,iodata( 'Post-rejection', Y, [desiredSPe, desiredSPeBar], 0 ) ...
               );
  
%
% Train S: Y -> |D-Yc| => Spe - prob of error per sample
%
fprintf(2,'S ');
  p.S = pns_hnn( STrainData, ProbThreshold );
  [PostRejc, PostRej ] = eval( p.S, Y );

% ------
% Construct Pre-Rejector Training Data 
%
  % Erroneously Classified Classes
  for i=1:getOutputSize( ioSamples )
      if pc(i) > (ProbThreshold * 100.0)
          for j=1:sampleCnt
              if 1 == osamples(j,i)
                  desiredPPe(j) = 1;
              else
                  desiredPPe(j) = desiredSPe(j);
              end
          end
      end
  end
  desiredPPeBar = ones( sampleCnt, 1 ) - desiredPPe; % Correct Classifications

%
% Assemble iodata for P-unit Accept and Reject classes
%
  PTrainData = iodata( 'Pre-reject Training Data', isamples, [desiredPPe, desiredPPeBar], 0 );
  
%
% Train P: I -> R/A => <Ir, Dr> and <Ia, Da>  -> Freeze P!
%
fprintf(2,'P ');
  p.P = pns_hnn( PTrainData, ProbThreshold );
  [PreRejc, PreRej ] = eval( p.P, isamples );
  
% ------
% Assemble new iodata for Rejected and Accepted data samples.
%     

  for i=1:getOutputSize( ioSamples )
      Rejected{i} = [];
      Accepted{i} = [];
  end
  for i=1:sampleCnt
      if 1 == PreRejc( 0 )   % Rejected Sample
          for j=1:getOutputSize( ioSamples )
              if 1 == osamples(i, j)
                  index = j;
                  break;
              end
          end
          % add sample i to rejected data in class index
          if isempty( Rejected{index} )
              Rejected{index} = iodata(i, isamples(i,:), osamples(i,:), 0 );
          else
              addSample( Rejected{index}, isamples(i,:), osamples(i,:) ); 
          end
      else                   % Accepted Sample
          for j=1:getOutputSize( ioSamples )
              if 1 == osamples(i, j)
                  index = j;
                  break;
              end
          end
          % add sample i to acccepted data in class index
          if isempty( Rejected{index} )
              Accepted{index} = iodata(i, isamples(i,:), osamples(i,:), 0 );
          else
              addSample( Accepted{index}, isamples(i,:), osamples(i,:) );
          end
      end
  end
   
  RejectedCollection = collection( 'reject', Rejected );
  AcceptedCollection = collection( 'accept', Accepted );
  
% -----
% Re-Train N: I -> D => Y, Yc
%
  
  ioSamples = getAllData( getTrainingSamples( AcceptedCollection ));
  [ isamples, osamples ] = getSamplePair( ioSamples, ':' );
  sampleCnt = getSampleSize( ioSamples );

fprintf(2,'N ');
  p.N = pns_hnn( AcceptedCollection, ProbThreshold );
  [Yc, Y ] = eval( p.N, isamples );
  [cmat, pc, tpc] = conf( osamples, Yc );

  desiredSPe    = sum( abs( osamples - Yc ) );
  desiredSPeBar = ones( sampleCnt, 1 ) - desiredSPe; % Correct Classifications
  STrainData = collection( 'Post-Rejector', ...
                 iodata( 'Post-Rejector', Y, [desiredSPe, desiredSPeBar], 0 ) ...
               );
  
% ----
% Re- Train S: Y -> |D-Yc| => Spe - prob of error per sample
%
fprintf(2,'S ');
  p.S = pns_hnn( STrainData, ProbThreshold );
  [PostRejc, PostRej ] = eval( p.S, Y );

  
% ----
% Train pnsReject: R -> D => RYc, RY  -> Freeze P!
%
fprintf(2,'pnsReject ');
  p.pnsReject = pns_hnn( RejectedCollection, ProbThreshold );
 
%
% Return a pns_hnn class object.
%
  p = class( p, 'pns_hnn');

% endfunction pns_hnn

%*****************************************************
% History:
% 
% $Log: pns_hnn.m,v $
% Revision 1.2  1997/11/07 05:40:17  jak
% More code - not working yet though!  -jak
%
% Revision 1.1  1997/11/04 16:54:32  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%
