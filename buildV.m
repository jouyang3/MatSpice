function buildV(line,B,C,z,cir)
    fname = 'buildV';
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
    V = str2num(args{5});
    
    cir.E(args{1}) = [a, b];
    % every volt increase in voltage source increase current flowing out of
    % node a by 1A (a is the + of voltage source). 
    
    % B: For i x j matrix, the jth direction represents jth voltage source.
    % C: For i x j matrix, the ith direction represents ith voltage source.
    % B = C' for circuit without dependent voltage sources.
    
    newVs = B.n+1;
    newVz = z.m+1;
    
    if a ~= 0
        B.set(a,newVs,1);
        % assume no dependent voltage source for now so that B = C'
        C.set(newVs,a,1);
        z.set(newVz,1,V);
        cir.V.set(a,1,-1);
    end
    
    if b ~= 0
        B.set(b,newVs,-1);
        % assume no dependent voltage source for now so that B = C'
        C.set(newVs,b,-1);
        z.set(newVz,1,V);
        cir.V.set(b,1,-1);
    end
end