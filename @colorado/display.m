
function p = display( p )
% display - colorado Class Method
%
%     p = display( p )
%
% Description: Display the Colorado Data Set.
%
% $Id: display.m,v 1.1 1997/10/28 18:38:41 jak Exp $
%

  fprintf( 1, 'Colorado Data Set\n');
  fprintf( 1, '%d training cases, %d testing cases\n', p.trainingCases, p.testCases );
  fprintf( 1, '%d input variables, %d classes (outputs)\n', 7, 10 );
  
  fprintf( 1, '\n');
  display ( p.training );
  fprintf( 1, '\n');
  display ( p.testing  );
  
% endfunction display

%*****************************************************
% History:
% 
% $Log: display.m,v $
% Revision 1.1  1997/10/28 18:38:41  jak
% Initial revision
%
%
