
function [Yc, Y] = eval( p, I_samples )
% eval - pns_hnn Class Method
%
%     [Yc, Y] = eval( p, InputSamples )
%
% Description: The eval method evaluates the
% network 
%
% $Id: eval.m,v 1.4 1997/11/25 18:24:54 jak Exp $
%

  if ~isempty( p.transform )
      [Nothing, InputSamples] = eval( p.transform, I_samples );
  else
      InputSamples = I_samples;
  end
  
  if isempty( p.S ) & ~isempty( p.N )
      [samples inputs] = size( InputSamples );
      Yc = zeros( samples,  p.outputCnt );
      Y  = zeros( samples,  p.outputCnt );
      
      [Yci, Yi] = eval( p.N, InputSamples );
      for j = 1:length( p.outputClass )
          Yc( :, p.outputClass(j) ) = Yci( :, j );
           Y( :, p.outputClass(j) ) =  Yi( :, j );
      end
      
  elseif isempty( p.N )
      Yc = [];
      Y  = [];
      
  else
  
      [samples inputs] = size( InputSamples );
      Yc = zeros( samples,  p.outputCnt );
      Y  = zeros( samples,  p.outputCnt );
      for i = 1:samples 
          [ PreRejc, PreRej ] = eval( p.P, InputSamples(i,:) );
          if PreRejc(1, 1) > PreRejc(1, 2)
              [ Yci, Yi ] = eval( p.pnsReject, InputSamples(i,:) );
              
          else
              [ Yci, Yi ] = eval( p.N, InputSamples(i,:) );
%              [PostRejc, PostRej ] = eval( p.S, [InputSamples(i,:), Yi]);
              [PostRejc, PostRej ] = eval( p.S, Yi );

              if PostRejc(1, 1) > PostRejc(1, 2) 
%                  if ~isempty( p.Srej )
%                      [ Yci, Yi ] = eval( p.Srej, InputSamples(i,:) );
%                  else
                      [ Yci, Yi ] = eval( p.pnsReject, InputSamples(i,:) );
%                  end
              end
          end
          for j = 1:length( p.outputClass )
              Yc( i, p.outputClass(j) ) = Yci( 1, j );
               Y( i, p.outputClass(j) ) =  Yi( 1, j );
          end
      end
           
  end

% endfunction eval

%*****************************************************
% History:
% 
% $Log: eval.m,v $
% Revision 1.4  1997/11/25 18:24:54  jak
% Total re-write to improve useability. -jak
%
% Revision 1.3  1997/11/18 16:49:43  jak
% Fixing bugs - still not ready for prime time though. -jak
%
% Revision 1.2  1997/11/07 05:40:16  jak
% More code - not working yet though!  -jak
%
% Revision 1.1  1997/11/04 16:54:31  jak
% First Check in of not-yet running PNS Module Class. -jak
%
%
