
%*****************************************************
%
% pshnn.m  - MATLAB Script for PSHNN Algorithm 
%
% Description:
%
%
% $Id: pshnn.m,v 1.1 1997/10/28 18:38:36 jak Exp $
%
%*****************************************************
%

myData = colorado;

alltrainingsamples = getAllData( getTrainingSamples( myData ));

[ inputsamples, outputsamples ] = getSamplePair( alltrainingsamples, ':' );

net = chen_fln( inputsamples, 100, outputsamples );

[Yc, Y ] = eval( net, inputsamples );

%*****************************************************
% History:
% 
% $Log: pshnn.m,v $
% Revision 1.1  1997/10/28 18:38:36  jak
% Initial revision
%
%
