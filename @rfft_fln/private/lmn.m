function [l,n,m]=lmn(x)
% LMN - a short helper function for Rfft 
% (this should probably be a subfunction of Rfft)
% 
% LMN finds [l,m]=size(x);
%     then, if l=1 it sets n=m, and m=1 
%     which should case the caller Rfft to
%     set x=x'.  Otherwise, it set n=1.
%
% Contributed by Prof. Okan Ersoy, Purdue University
%
% $Id: lmn.m,v 1.1 1997/11/04 22:44:51 jak Exp $
%
    [l,m] = size(x);
    if 1 == l 
	    n = m;
	    m = 1;
    else 
	    n = l;
    end

% *************************************************
% History:
% $Log: lmn.m,v $
% Revision 1.1  1997/11/04 22:44:51  jak
% Added the missing file from professor Ersoy. -jak
%
%
		
		
