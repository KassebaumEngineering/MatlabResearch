
function [Yc, Y] = eval( p, InputSamples )
% eval - pns_hnn Class Method
%
%     [Yc, Y] = eval( p, InputSamples )
%
% Description: The eval method evaluates the
% network 
%
% $Id: eval.m,v 1.2 1997/11/07 05:40:16 jak Exp $
%

  if isempty( p.S )
      [Yc, Y] = eval( p.N, InputSamples );
  else
      [PreRejc, PreRej] = eval( p.P, InputSamples );
    
      [samples inputs] = size( InputSamples );
      RejectSamples = sparse(samples, inputs);
      AcceptSamples = sparse(samples, inputs);
      for i=1:samples 
          if PreRejc(i, 0) > PreRejc(i, 1)
              RejectSamples(i,:) = InputSamples(i,:);
          else
              AcceptSamples(i,:) = InputSamples(i,:); 
          end
     end
     
     [YcA, YA] = eval( p.N, AcceptSamples );
     [PostRejc, PostRej] = eval( p.S, YA );
     [i,j,s] = find( PostRejc );
     for k = 1,length(i)
         RejectSamples(i(k),:) = AcceptSamples(i(k),:);
         AcceptSamples(i(k),:) = zeros(1,inputs);
     end
     
     [YcR, YR] = eval( p.pnsReject, RejectSamples );
     
     for i = 1:samples
         if (PreRejc(i, 0) > PreRejc(i, 1)) | (PostRejc(i,0) > PostRejc(i,0) )
             Yc(i,:) = YcR(i,:);
              Y(i,:) = YR(i,:);
         else
             Yc(i,:) = YcA(i,:);
              Y(i,:) = YA(i,:);
         end
     end
     
  end

% endfunction eval

%*****************************************************
% History:
% 
% $Log: eval.m,v $
% Revision 1.2  1997/11/07 05:40:16  jak
% More code - not working yet though!  -jak
%
% Revision 1.1  1997/11/04 16:54:31  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%
