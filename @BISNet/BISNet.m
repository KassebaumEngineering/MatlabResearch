
function p = BISNet( I_samples, O_samples, quantiles, samplesPerHiddenNode, varargin  )
% BISNet - @BISNet Class Method
%
%     p = BISNet( I_samples, O_samples, quantiles, samplesPerHiddenNode [, classify] )
%
% Description:
%
% $Id: BISNet.m,v 1.3 2000/03/27 13:36:16 jak Exp $
%
    if ~isempty( varargin )
        classify = varargin{1};
    else 
        classify = 0;
    end

    [ isamples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

	bistree = BISTree( I_samples, quantiles );
	qtree = getQuantTrees( bistree, samplesPerHiddenNode );
	
	hiddencnt = getChildCount( qtree );

    p = struct( ...
        'inputs'           , inputs    ...
       ,'outputs'          , outputs   ...
       ,'hidden_units'     , hiddencnt ...
       ,'param_count'      , outputs * (hiddencnt+1) ...
                             + hiddencnt * (inputs+1) ...
       ,'Wh'               , []        ...
       ,'Bh'               , []        ...
       ,'Wo'               , []        ...
       ,'classify'         , classify ...
    );

    p = class( p, '@BISNet');
	
	%
	% To determine the centers, walk the qtree elements
	% and perform statistics on the leaves in those trees.
	%
	node = getFirstChild( qtree );
	i = 1;
	while ( ~isempty( node ) )
	    hidden(i) = getBISstats( node );
		node = getNextSibling( node );
    end
	
	%
	% Now, from the calculated centers and std devs, we 
	% calculate the actual hidden weights using the
	% unit vector of the center and a scale determined by
	% the spread of the function.  
	%
	% TBD <=========================================
	%

% endfunction BISNet

%*****************************************************
% History:
% 
% $Log: BISNet.m,v $
% Revision 1.3  2000/03/27 13:36:16  jak
% Small changes trying to get it through compile. -jak
%
% Revision 1.2  2000/03/15 10:54:34  jak
% More changes to get closer to a working BISNET. -jak
%
% Revision 1.1  2000/03/15 10:23:46  jak
% Working on a network to take advantage of the new mechanism. -jak
%
%
