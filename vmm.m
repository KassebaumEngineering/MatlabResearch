function z=vmm(x,y)
% VMM - Vector Multiply X and Y
%
%     z = vmm(x,y)
%
% Vector x multiplies every column of matrix y pointwise 
%
% Contributed by Prof. Okan Ersoy, Purdue University
%
%  $Id: vmm.m,v 1.1.1.1 1997/10/28 18:38:36 jak Exp $
%

    [m,n]=size(y); 
    mm=1:m; 

    for i=1:n 
	    z(mm,i)=x.*y(mm,i); 
    end 


% History:
% $Log: vmm.m,v $
% Revision 1.1.1.1  1997/10/28 18:38:36  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
