
%*****************************************************
%
% bayes.m  - MATLAB Script for Bayesian Experiments  
%
% Description:
%
%
% $Id: bayes.m,v 1.2 1998/03/08 07:17:42 jak Exp $
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
% Get the training/testing data from the collection.
%
  alltrainingsamples = getAllData( getTrainingSamples( myData ));
  [ trIsamples, trOsamples ] = getSamplePair( alltrainingsamples, ':' );
  
  alltestingsamples = getAllData( getTestingSamples( myData ));
  [ teIsamples, teOsamples ] = getSamplePair( alltestingsamples, ':' );


  for i = 80:-10:20,
    for j = 1:2,
    
      net(i,j,1).net = bayes1( trIsamples, trOsamples, i );
      
    %
    % Get Class by Class Probability of Error
    %
      [ Yc, Y ] = eval( net(i,j,1).net, trIsamples );
      [cmat, pc, TrErr] = conf( trOsamples, Yc );
      TrainError(i,j,1) = TrErr;
      TrErr
      
    %
    % Test The Network
    %
      [ Yc, Y ] = eval( net(i,j,1).net, teIsamples );
      [cmat, pc, TeErr] = conf( teOsamples, Yc );
      TestErr(i,j,1) = TeErr;
      TeErr
      
    %
    % Train the Network
    %
      for k = 2:5,
        net(i,j,k).net = train( net(i,j,k-1).net, trIsamples, trOsamples, 100 );
  
        %
        % Get Class by Class Probability of Error
        %
          [ Yc, Y ] = eval( net(i,j,k).net, trIsamples );
          [cmat, pc, TrErr] = conf( trOsamples, Yc );
          TrainError(i,j,k) = TrErr;
          TrErr

        %
        % Test The Network
        %
          [ Yc, Y ] = eval( net(i,j,k).net, teIsamples );
          [cmat, pc, TeErr] = conf( teOsamples, Yc );
          TestErr(i,j,k) = TeErr;
          TeErr
          
      end
    end
  end 
%
% Done! Remove path addition to be thorough.
%
%  rmpath .

%*****************************************************
% History:
% 
% $Log: bayes.m,v $
% Revision 1.2  1998/03/08 07:17:42  jak
% More interesting Tests. -jak
%
% Revision 1.1  1998/03/07 22:57:21  jak
% Added new script file. -jak
%
%
