
function [cmat, pc, tpc] = conf( Desired, Actual )
% CONF - Generates and Returns a Confusion Matrix
%
%     [cmat, pc, tpc] = conf(Desired,Actual);
%
% Description:  The CONF function takes two matrices
% representing the desired or training desired output
% samples and the actual output samples from some
% classifier, and compares them to obtain a confusion
% matrix (returned in cmat), an array of probabilities
% of correct classification (in pc), and a single overall
% probability of being correctly classified (in tpc).
% Each input (Desired and Actual) is of the form 
% 'samples' x 'output classes'.
%
% $Id: conf.m,v 1.4 1997/11/29 21:10:05 jak Exp $
%
% 
    err = Desired - Actual;

    [ samples, classes ] = size( Desired );
    
    cmat = zeros(classes, classes);
    for s=1:samples
        from = 1;
        to = from;
        for c=1:classes
            if -1 == err(s,c)
                to = c;
            end
            
            if  1 == err(s,c)
                from = c;
            end
            
            if 1 == Desired(s,c)
                d = c;
            end
        end
        if from == to
            cmat(   d, d) = cmat(   d, d) + 1;
        else
            cmat(from,to) = cmat(from,to) + 1;
        end
    end
    
    samples_per_class = sum( Desired );

    correct = zeros(1,classes);
    for i=1:classes
        correct(1, i) = cmat(i,i);
    end
    pc = zeros(1,classes);
    for i=1:classes
        if  0 == samples_per_class(i)
            pc(1, i) = 100.0 ;
        else
            pc(1, i) = (correct(1,i) / samples_per_class(i)) * 100 ;
        end
    end
    if 0 == sum( samples_per_class )
        tpc = 100.0;
    else
        tpc = (sum( correct ) / sum( samples_per_class )) * 100;
    end

%endfunction

% --------------------------------
% History:
% $Log: conf.m,v $
% Revision 1.4  1997/11/29 21:10:05  jak
% Testing modifications - inconsequential. -jak
%
% Revision 1.3  1997/11/25 18:24:28  jak
% Small modifications for testing. -jak
%
% Revision 1.2  1997/11/18 16:47:52  jak
% fixed a bug in conf, more additions for testing in pshnn. -jak
%
% Revision 1.1  1997/10/29 00:10:17  jak
% Added more to Pshnn and added confusion matrix function. -jak
%
%
%
