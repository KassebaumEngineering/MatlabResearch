
%*****************************************************
%
% pshnn.m  - MATLAB Script for PSHNN Algorithm 
%
% Description:
%
%
% $Id: pshnn.m,v 1.13 1997/12/02 18:22:20 jak Exp $
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
t1 = cputime;
  net = rfft_fln( inputsamples, outputsamples );
t2 = cputime;
t2 - t1
%  chenn = chen_fln( inputsamples, outputsamples );
%t3 = cputime;
%t3 - t2
%  net = sopnet( inputsamples, outputsamples );
%t4 = cputime;
%t4 - t3

%   net = sop;
%  net = pns_hnn( getTrainingSamples( myData ), 0.5 );

%  net = pns_hnn( inputsamples, outputsamples );
  
%  net = jaknet( inputsamples, outputsamples, 50 );
  
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
% $Log: pshnn.m,v $
% Revision 1.13  1997/12/02 18:22:20  jak
% Pshnn - experiments. All others a bug fix and code additions. -jak
%
% Revision 1.12  1997/11/29 21:10:06  jak
% Testing modifications - inconsequential. -jak
%
% Revision 1.11  1997/11/25 18:24:28  jak
% Small modifications for testing. -jak
%
% Revision 1.10  1997/11/18 16:47:53  jak
% fixed a bug in conf, more additions for testing in pshnn. -jak
%
% Revision 1.9  1997/11/08 07:10:08  jak
% Added timing and comparisons. -jak
%
% Revision 1.8  1997/11/08 04:44:57  jak
% Testing fix of chen_fln. -jak
%
% Revision 1.7  1997/11/08 04:36:58  jak
% Added sopnet. -jak
%
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
