function y=rfft(x)
% RFFT - Real FFT of X
%
%     y = rfft(x)
%
% RFFT computes the RDFT of x.
% The input x is divided in to even and odd 
% components, and a complex vector z of half 
% the size is generated. The RDFT of x is 
% computed through DFT of z.
%
% Contributed by Prof. Okan Ersoy, Purdue University
%
%  $Id: rfft.m,v 1.1 1997/11/04 16:55:19 jak Exp $
%

    i=sqrt(-1);
    [l,n,m]=lmn(x);

    if l==1
        x=x';
    end

    n2=n/2;
    nm=n2-1;
    n1=n2+1;
    l1=1:2:n;
    l2=2:2:n;
    l3=1:n;
    l4=1:m;
    l5=2:n2;
    l6=n2-1:-1:1;
    z=x(l1,l4)+i*x(l2,l4);
    
    z=fft(z);
    
    r1=real(z(1,l4));
    i1=imag(z(1,l4));
    zr=real(z(l5,l4));
    rzr=zr(l6,l4);
    zi=imag(z(l5,l4));
    rzi=zi(l6,l4);
    zr1=zr+rzr;
    zr2=zr-rzr;
    zi1=zi+rzi;
    zi2=zi-rzi;
    p2=pi/n2;
    a=p2*(1:nm)';
    c=cos(a);
    s=sin(a);
    
    y(l5,l4)=zr1+vmm(c,zi1)-vmm(s,zr2);
    y(n:-1:n2+2,l4)=-zi2+vmm(s,zi1)+vmm(c,zr2);
    y(1,l4)=r1+i1;
    y(n1,l4)=r1-i1;

    if l==1 
        y=y';
    end

% History:
% $Log: rfft.m,v $
% Revision 1.1  1997/11/04 16:55:19  jak
% First Check in of running fft Network Class. -jak
%
% Revision 1.1.1.1  1997/10/28 18:38:36  jak
% Initial Import of Matlab Research tools and classes. -jak
%
%
