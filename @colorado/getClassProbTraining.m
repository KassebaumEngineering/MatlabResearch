
function anArray = getClassProbTraining( p )
% getClassProbTraining - @colorado Class Method
%
%     p = getClassProbTraining( p )
%
% Description: Return the array of class membership
% probabilities as defined by the members of the training set.
%
% $Id: getClassProbTraining.m,v 1.1.1.1 1997/10/28 18:38:41 jak Exp $
%

  anArray = p.probabilityOfTrainingClass;

% endfunction getClassProbTraining

%*****************************************************
% History:
% 
% $Log: getClassProbTraining.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:41  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
