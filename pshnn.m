
%*****************************************************
%
% pshnn.m  - MATLAB Script for PSHNN Algorithm 
%
% Description:
%
%
% $Id: pshnn.m,v 1.6 1997/11/07 06:19:37 jak Exp $
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
  net = rfft_fln( inputsamples, outputsamples );
%  net = chen_fln( inputsamples, outputsamples );

%  net = pns_hnn( getTrainingSamples( myData ), 0.5 );
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
% $Log: pshnn.m,v $
% Revision 1.6  1997/11/07 06:19:37  jak
% Fixed new calling conventions for rfft_fln. -jak
%
% Revision 1.5  1997/11/07 05:38:22  jak
% Added more testing code. -jak
%
% Revision 1.4  1997/11/05 04:39:34  jak
% Added a commented line to compare with chen_fln. -jak
%
% Revision 1.3  1997/11/04 16:53:42  jak
% Added Testing of Network. -jak
%
% Revision 1.2  1997/10/29 00:10:18  jak
% Added more to Pshnn and added confusion matrix function. -jak
%
% Revision 1.1.1.1  1997/10/28 18:38:36  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
