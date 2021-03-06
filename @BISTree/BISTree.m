
function p = BISTree( I_samples, O_samples, quantiles )
% BISTree - @BISTree Class Method
%
%     p = BISTree( I_samples, O_samples, quantiles )
%
% Description:
%
% $Id: BISTree.m,v 1.4 2000/03/27 13:36:20 jak Exp $
%
    bis = BitInterleavedSort( I_samples, quantiles );
	
	rootNode = TreeNode;
    node = rootNode;
	for i = 1:bis.rows
	    for j = 1:bis.quantiles
		    if ( node.hasValue ) then
			    while ( bis(i,j) ~= node.getValue )
				    if ( node.hasSibling )
				        node = node.getNextSibling;
					else
					    break;
					end
				end
		    	if ( bis(i,j) ~= node.getValue ) then
				    sibling = TreeNode;
					sibling.setValue( bis(i,j) );
					node.setNextSibling( sibling );
					child = TreeNode;
					sibling.setFirstChild( child );
				else
				    child = node.getFirstChild;
				end
			else
		    	node.setValue( bis(i,j) );
				child = TreeNode;
				node.setFirstChild( child );
			end
			last = node;
			node = child;
		end
		last.setLeafReference( bis{ i, 1:bis.quantiles } );
		node = rootNode;
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
% Revision 1.4  2000/03/27 13:36:20  jak
% Small changes trying to get it through compile. -jak
%
% Revision 1.3  2000/03/15 09:58:13  jak
% More code - to try and extract interesting subtrees. -jak
%
% Revision 1.2  2000/03/15 09:08:31  jak
% Fixes to the tree walking construction. -jak
%
% Revision 1.1  2000/03/15 08:48:46  jak
% New class to handle tree bit interleaved sorts. -jak
%
%
