
function p = mackayglass
% MACKAYGLASS - Constructor for MackayGlass Data 
%
%     p = mackayglass
%     
% Description: Builds the Training and Testing 
% Data for the 4-input 1-output Mackay-Glass chaotic
% time series data set.  The mackayglass object is an 
% aggregate of two collections of data: a training 
% collection, and a testing collection. Each collection 
% consists of 1 'iodata' with 4 inputs and 1 outputs
% for each regression sample. 
%
% $Id: mackayglass.m,v 1.2 2000/01/09 20:43:29 jak Exp $
%
% Uses private script Files:
%     mkgl_trn.m   - for training data
%     mkgl_test.m  - for testing data
%
%

    % ------------------------------------------------------------
    % read in the data set - training and test samples
    %
    mkgl_trn     % defines mackay-glass training data
    mkgl_test    % defines mackay-glass testing data

    number_of_test_cases     = length(mkglass_train);
    number_of_training_cases = length(mkglass_test);

    % ------------------------------------------------------------
    % test samples
    %
    test_data  = iodata( 'for testing', ...
        mkglass_test(:, 1:4 ), ...
        mkglass_test(:,  5  )  ...
    );

    % ------------------------------------------------------------
    % training samples
    %
    train_data  = iodata( 'for training', ...
        mkglass_train(:, 1:4 ), ...
        mkglass_train(:,  5  )  ...
    );

    p.trainingCases = number_of_training_cases;
    p.training = collection( 'mackay-glass training data', train_data );

    p.testCases   = number_of_test_cases;
    p.testing  = collection( 'mackay-glass testing data',  test_data );

    p = class(p, 'mackayglass');
      
%*****************************************************
% History:
% 
% $Log: mackayglass.m,v $
% Revision 1.2  2000/01/09 20:43:29  jak
% Fixed a bug in the naming conventions. -jak
%
% Revision 1.1  1998/03/19 05:48:40  jak
% A New data set - the mackay glass chaos data! -jak
%
%
