
function p = consensus(I_samples, O_samples, varargin )
% consensus - consensus Class Method
%
%     p = consensus(I_samples, O_samples, [ NetworkCnt ] )
%
% Description:
%     Creates a consensus neural network with an architecture
%     which supports the I_samples and O_Samples which were
%     passed as arguments.  The NetworkCnt argument (optional),
%     if specified, gives the number of networks to generate
%     as a part of the consensus.  The default value of
%     NetworkCnt is 10.
%
% $Id: consensus.m,v 1.1 1997/11/18 16:48:46 jak Exp $
%

    [  samples,  inputs ] = size( I_samples );
    [ osamples, outputs ] = size( O_samples );

    p = struct( ...
        'inputs'           , inputs  ...
       ,'outputs'          , outputs ...
       ,'networkCnt'       , 10      ...
       ,'hiddenNodeCnt'    , 0       ...
       ,'member'           , []      ...
       ,'consNet'          , []      ...
    );
    p = class( p, 'consensus');
    
    if ~isempty( varargin ) 
        p.networkCnt = varargin{1};
        if nargin > 3
            p.hiddenNodeCnt = varargin{2};
        end
    end

    if ( p.hiddenNodeCnt == 0 )
        p.member{1} = sopnet( I_samples, O_samples );
        p.hiddenNodeCnt = getHiddenNodeCnt( p.member{1} );
    else
        p.member{1} = sopnet( I_samples, O_samples, p.hiddenNodeCnt, 0  );
    end
    for i = 2:p.networkCnt
        p.member{i} = sopnet( I_samples, O_samples, p.hiddenNodeCnt, 0 );
%        p.member{i} = sopnet( I_samples, O_samples );
    end
    
%    NetY = zeros( samples, p.outputs );
%    for i = 1:p.networkCnt
%        [Yc, Y] = eval( p.member{i}, I_samples );
%        NetY = [ NetY, Y ];
%    end
%    p.consNet = sopnet( NetY, O_samples );
    
% endfunction consensus

%*****************************************************
% History:
% 
% $Log: consensus.m,v $
% Revision 1.1  1997/11/18 16:48:46  jak
% New experiment - consensus nets! -jak
%
%
