
%*****************************************************
%
% bayes.m  - MATLAB Script for Bayesian Experiments  
%
% Description:
%
%
% $Id: bayes.m,v 1.1 1998/03/07 22:57:21 jak Exp $
%
%*****************************************************
%

%
% Add the working directory to the Matlab Path
%
%  addpath .

%
% Obtain a Data Set - inthis case its the Colorado Data Set
%
  myData = colorado;

%
% Get the training data from the collection.
%
  alltrainingsamples = getAllData( getTrainingSamples( myData ));
  [ inputsamples, outputsamples ] = getSamplePair( alltrainingsamples, ':' );

%
% Build the 1st N-unit and evaluate it.
%
%t1 = cputime;
%  net = rfft_fln( inputsamples, outputsamples );
%t2 = cputime;
%t2 - t1
%  chenn = chen_fln( inputsamples, outputsamples );
%t3 = cputime;
%t3 - t2
%  net = sopnet( inputsamples, outputsamples );
%t4 = cputime;
%t4 - t3

%   net = sop;
%  net = pns_hnn( getTrainingSamples( myData ), 0.5 );

%  net = pns_hnn( inputsamples, outputsamples );
  
  net = jaknet( inputsamples, outputsamples, 40 );
  
%  net = consensus( inputsamples, outputsamples, 10 );
  [ Yc, Y ] = eval( net, inputsamples );

%
% Get Class by Class Probability of Error
%
  [cmat, pc, tpc] = conf( outputsamples, Yc );
  pc
  tpc
  cmat
  
%
% Test The Network
%
  alltestingsamples = getAllData( getTestingSamples( myData ));
  [ isamples, osamples ] = getSamplePair( alltestingsamples, ':' );
  [ Yc, Y ] = eval( net, isamples );
  [cmat, pc, tpc] = conf( osamples, Yc );
  pc
  tpc
  cmat
 
%
% Done! Remove path addition to be thorough.
%
%  rmpath .

%*****************************************************
% History:
% 
% $Log: bayes.m,v $
% Revision 1.1  1998/03/07 22:57:21  jak
% Added new script file. -jak
%
%
