function y=comin(x)
% COMIN - Pre and post-processing used in the Inverse Real FFT.
%
%     y = comin(x)
%
% pre and postprocessing in inverse rfft
%
% Contributed by Prof. Okan Ersoy, Purdue University
%
%  $Id: comin.m,v 1.1 1997/12/02 18:22:19 jak Exp $
%

    [l,n,m]=lmn(x);
    
    if l==1
        x=x';
    end
    
    n2=n/2;
    n1=n2+1;
    mm=1:m;
    l1=2:n2;
    l2=n:-1:n2+2;
    
    y(1,mm)=2*x(1,mm);
    y(n1,mm)=2*x(n1,mm);
    y(l1,mm)=x(l1,mm)+x(l2,mm);
    y(l2,mm)=x(l1,mm)-x(l2,mm);
    
    if l==1 
        y=y';
    end
    
%
% History:
% $Log: comin.m,v $
% Revision 1.1  1997/12/02 18:22:19  jak
% Pshnn - experiments. All others a bug fix and code additions. -jak
%
%
