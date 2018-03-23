function buildR(line,G,z,cir)
    fname = 'buildR';
    global logger
    
    ii = 1; L = length(line);
    args = [];
    while ii <= L
        k = ii;
        [tok,n,errmsg,ii] = sscanf(line(ii:L),'%s+');
        ii = ii+k-1;
        if tok(1) == '$' % Comments
            tok = [tok line(ii:L)];
            ii = L+1;
        end
        
        args = [args;cellstr(tok)];
        logger.info(fname,tok);
    end
    
    a = int8(str2num(args{2}));
    b = int8(str2num(args{3}));
    R = str2num(args{4});
    
    cir.E(args{1}) = [a, b];
    % Emulating current flowing out of nodes
    % every increase in R in node a increase voltage of node a and
    % increase current flowing out of it by 1/R. And every increase of R
    % reduces voltage of node b and reduces voltage flowing out of node a
    % by 1/R (or increase by -1/R).
    %
    % Ignoring ground node.
    
    if a ~= 0
        G.add(a,a,1/R); 
        z.set(a,1,0);
        cir.V.set(a,1,0);
    end
    
    if b ~= 0
        G.add(b,b,1/R);
        z.set(b,1,0);
        cir.V.set(b,1,0);
    end
    
    if a ~= 0 && b ~= 0
        G.add(a,b,-1/R);
        G.add(b,a,-1/R);
    end
    
end