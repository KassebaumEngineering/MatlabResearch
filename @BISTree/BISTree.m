
function p = BISTree( I_samples, O_samples, quantiles )
% BISTree - @BISTree Class Method
%
%     p = BISTree( I_samples, O_samples, quantiles )
%
% Description:
%
% $Id: BISTree.m,v 1.1 2000/03/15 08:48:46 jak Exp $
%
    bis = BitInterleavedSort( I_samples, quantiles );
	
	node = rootNode = TreeNode();
	for i = 1:bis.rows
	    for j = 1:bis.quantiles
		    if ( node.hasValue() ) then
		    	if ( bis(i,j) ~= node.getValue() ) then
		    		node.setValue( bis(i,j) );
					child = TreeNode();
					node.addChild( child );
				else
				    child = node.getFirstChild();
				end
			else
		    	node.setValue( bis(i,j) );
				child = TreeNode();
				node.addChild( child );
			end
			node = child;
		end
	end

    p = struct( ...
	    'root',	rootNode	...
	)

    p = class( p, '@BISTree');
	
% endfunction BISTree

%*****************************************************
% History:
% 
% $Log: BISTree.m,v $
% Revision 1.1  2000/03/15 08:48:46  jak
% New class to handle tree bit interleaved sorts. -jak
%
%
