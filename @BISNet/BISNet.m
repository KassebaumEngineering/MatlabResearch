
function p = BISNet( I_samples, O_samples, quantiles, samplesPerHiddenNode, varargin  )
% BISNet - @BISNet Class Method
%
%     p = BISNet( I_samples, O_samples, quantiles, samplesPerHiddenNode [, classify] )
%
% Description:
%
% $Id: BISNet.m,v 1.1 2000/03/15 10:23:46 jak Exp $
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

% endfunction BISNet

%*****************************************************
% History:
% 
% $Log: BISNet.m,v $
% Revision 1.1  2000/03/15 10:23:46  jak
% Working on a network to take advantage of the new mechanism. -jak
%
%
