
function p = prune(p, I_samples, O_samples)
% PRUNE - mdlnet Class Instance Method
%
%     p = prune(p, I_samples, O_samples)
%
%     p            -> a mdlnet Instance
%     I_samples    -> samples x inputs
%     O_samples    -> samples x outputs
%     MinsAndMaxes -> inputs x 2 array of 
%                     min (:,1) and max (:,2)
%                     input data ranges.
%
% $Id: prune.m,v 1.1.1.1 1999/09/19 23:24:57 jak Exp $
%

  % ---------------------------------------
  % Network Architecture Validation
  %
    [isamples,  inputs ] = size( I_samples );
    [osamples, outputs ] = size( O_samples );
    if inputs ~= p.inputs
        fprintf(2, 'Input Data Incompatible with Network Architecture!');
        fprintf(2, '%d inputs instead of %d inputs!', inputs, p.inputs);
        error('mdlnet method: prune()');
    end
    if outputs ~= p.outputs
        fprintf(2, 'Output Data Incompatible with Network Architecture!');
        fprintf(2, '%d outputs instead of %d outputs!', outputs, p.outputs);
        error('mdlnet method: prune()');        
    end 
    if isamples ~= osamples 
        fprintf(2, 'Unequal Amounts of Sample Data!');
        fprintf(2, '%d input samples -> %d output samples :', ...
                   isamples, inputs, osamples, outputs );
        error('mdlnet method: prune()');        
    end
     
  % ---------------------------------------
  % Find Mins and maxes for input data
  %
    iMaM = zeros(inputs,2);
    for r= 1:inputs
        imin = I_samples(1, r);
        imax = I_samples(1, r);
        for i= 2:isamples
            if  I_samples(i, r) > imax
                imax = I_samples(i, r);
            end
            if  I_samples(i, r) < imin
                imin = I_samples(i, r);
            end
        end
        iMaM(r,1)=imin;
        iMaM(r,2)=imax;
    end
    irngmin = iMaM(:,1);
    irngmax = iMaM(:,2);
    irng =  irngmax - irngmin;
    imid = (irngmax + irngmin)/2;    

    oMaM = zeros(outputs,2);
    for r= 1:outputs
        omin = O_samples(1, r);
        omax = O_samples(1, r);
        for i= 2:osamples
            if  O_samples(i, r) > omax
                omax = O_samples(i, r);
            end
            if  O_samples(i, r) < omin
                omin = O_samples(i, r);
            end
        end
        oMaM(r,1)=omin;
        oMaM(r,2)=omax;
    end
    orngmin = oMaM(:,1);
    orngmax = oMaM(:,2);
    orng =  orngmax - orngmin;
    omid = (orngmax + orngmin)/2;    

  % ---------------------------------------
  % Scale Hidden Weights and Biases
  % for weight size comparison
  %
    Bh = abs( p.Bh + p.Wh * imid );
    Wh = abs( ( p.Wh / 2 ) .* ( ones(p.hidden_units,1) * irng' ));

  % ---------------------------------------
  % Start Pruning 
  %
    [SEC MSE] = perf(p, I_samples, O_samples );
    fprintf( 1, 'Initial SEC = %e, MSE = %e \n',SEC,MSE);
    fprintf( 1, 'Begin Pruning\n');
    
  % ---------------------------------------
  % Prune the Hidden Layer 
  %
  % Try Removing Each Hidden Node
    fprintf( 1, '\nHidden Nodes\n', r );
    tmpWo = p.Wo;
    rcnt = 1;
    hidcnt = p.hidden_units;
    for r = 1:p.hidden_units 
        fprintf( 1, '%d,', r );
        tmpW = p.Wh(rcnt,:);
        tmpB = p.Bh(rcnt,:);
        %p.Wh(r,:) = zeros( 1, p.inputs );
        %p.Bh(r,:) = zeros( 1, 1 );
        if rcnt == 1
            p.Wh = [p.Wh(rcnt+1:hidcnt,:)]; 
            p.Bh = [p.Bh(rcnt+1:hidcnt,:)];
        elseif rcnt == hidcnt
            p.Wh = [p.Wh(1:rcnt-1,:)]; 
            p.Bh = [p.Bh(1:rcnt-1,:)];
        else 
            p.Wh = [p.Wh(1:rcnt-1,:); p.Wh(rcnt+1:hidcnt,:)];
            p.Bh = [p.Bh(1:rcnt-1,:); p.Bh(rcnt+1:hidcnt,:)];
        end
        deltaparam = - (p.inputs + 1) - p.outputs;
        p.param_count = p.param_count + deltaparam;
        H = [ ones(isamples, 1), tansig( p.Wh * I_samples', p.Bh)' ];
        % p.Wo = O_samples' * pinv( H )';
        p.Wo = O_samples' / H';
        [newSEC newMSE] = perf(p, I_samples, O_samples );
        if newSEC < SEC 
            fprintf( 1, '\n node <%d> eliminated, new SEC = %e, new MSE = %e \n',r,newSEC,newMSE);
            SEC = newSEC;
            tmpWo = p.Wo;
            hidcnt = hidcnt-1;;
        else
            p.param_count = p.param_count - deltaparam;
            if rcnt == 1
                p.Wh = [tmpW; p.Wh(rcnt:hidcnt-1,:)]; 
                p.Bh = [tmpB; p.Bh(rcnt:hidcnt-1,:)];
            elseif rcnt == p.hidden_units
                p.Wh = [p.Wh(1:rcnt-1,:); tmpW]; 
                p.Bh = [p.Bh(1:rcnt-1,:); tmpB];
            else 
                p.Wh = [p.Wh(1:rcnt-1,:); tmpW; p.Wh(rcnt:hidcnt-1,:)];
                p.Bh = [p.Bh(1:rcnt-1,:); tmpB; p.Bh(rcnt:hidcnt-1,:)];
            end
            %p.Wh(r,:) = tmpW;
            %p.Bh(r,:) = tmpB;
            rcnt = rcnt + 1;
        end       
    end
    fprintf( 1, '\n%d Hidden Nodes were Eliminated\n', p.hidden_units-hidcnt );
    p.hidden_units = hidcnt;
    p.Wo = tmpWo;
    
    fprintf( 1, '\nPrune Hidden Weights in Node\n', r );
  % Each Row of Wh is a Hidden Node
    for r = 1:p.hidden_units  
        fprintf( 1, '%d,', r );
        stop = 0;
        while stop == 0
            [minval, index] = min( Wh(r,:) );
            tmp = p.Wh(r,index);
            p.Wh(r,index) = 0.0;
            p.param_count = p.param_count - 1;
            H = [ ones(isamples, 1), tansig( p.Wh * I_samples', p.Bh)' ];
            % p.Wo = O_samples' * pinv( H )';
            p.Wo = O_samples' / H';
            [newSEC newMSE] = perf(p, I_samples, O_samples );
            if newSEC < SEC 
                Wh(r,index) = 10^20;
                fprintf( 1, '\nWh<%d,%d> %e eliminated, new SEC = %e, new MSE = %e \n',r,index,tmp,newSEC,newMSE);
                SEC = newSEC;
                tmpWo = p.Wo;
            else
                p.Wh(r,index) = tmp;
                p.param_count = p.param_count + 1;
                stop = 1;
            end
        end
    end
    p.Wo = tmpWo;
    
%    H = [ ones(isamples, 1), tansig( p.Wh * I_samples', p.Bh)' ];
%    p.Wo = O_samples' * pinv( H )';
%    p.Wo = O_samples' / H';
    
  % ---------------------------------------
  % Scale Output Weights and Biases
  % for weight size comparison
  %
    % note: Bo = abs( p.Wo(:,1) );
    Wo = abs(...
      [  p.Wo(:,1) , ...
         (p.Wo(:,2:p.hidden_units+1) * 2) ./ ( ones(p.hidden_units,1) * orng' )' ...
      ]);
      
  % ---------------------------------------
  % Prune the Output Layer 
  %
  % Each Row of Wo is an Output Node
    fprintf( 1, '\nPrune Output Weights & Biases in Output Node\n', r );
    [SEC MSE] = perf(p, I_samples, O_samples );
    fprintf( 1, 'Initial SEC = %e, MSE = %e \n',SEC, MSE);
    fprintf( 1, 'Begin Pruning\n');
    for r = 1:outputs    
        fprintf( 1, '%d,', r );
        stop = 0;
        while stop == 0
            [minval, index] = min( Wo(r,:) );
            tmp = p.Wo(r,index);
            p.Wo(r,index) = 0.0;
            p.param_count = p.param_count - 1;
            [newSEC newMSE] = perf(p, I_samples, O_samples );
            if newSEC < SEC 
                Wo(r,index) = 10^20;
                fprintf( 1, '\nWo<%d,%d> %e eliminated, new SEC = %e, new MSE = %e\n',r,index,tmp,newSEC,newMSE);
                SEC = newSEC;
            else
                p.Wo(r,index) = tmp;
                p.param_count = p.param_count + 1;
                stop = 1;
            end
        end
    end
    
% ****************************************
% History:
% $Log: prune.m,v $
% Revision 1.1.1.1  1999/09/19 23:24:57  jak
% Initial checkin of the single shot NW with LMS training method with 
% output of MDL SEC values. -jak
%
