classdef vsrc < element
    
    methods
        function obj = vsrc(line)
            obj@element(line)
        end
        
        function attach(this,cir)
            fname = 'V.attach';
            global logger
            % logger.info(fname,this.line);
            ii = 1; L = length(this.line);
            args = [];
            while ii <= L
                k = ii;
                [tok,n,errmsg,ii] = sscanf(this.line(ii:L),'%s+');
                ii = ii+k-1;
                if tok(1) == '$' % Comments
                    tok = [tok this.line(ii:L)];
                    ii = L+1;
                end
                
                args = [args;cellstr(tok)];
                logger.info(fname,tok);
            end
            
            a = int8(str2num(args{2}));
            b = int8(str2num(args{3}));
            V = str2num(args{5});
            
            cir.Ele(args{1}) = [a, b];
            this.pins = [a, b];
            this.val = V;
            cir.Vsrc = [cir.Vsrc this];
            % every volt increase in voltage source increase current flowing out of
            % node a by 1A (a is the + of voltage source).
            
            % B: For i x j matrix, the jth direction represents jth voltage source.
            % C: For i x j matrix, the ith direction represents ith voltage source.
            % B = C' for circuit without dependent voltage sources.
            
            newVs = cir.B.n+1;
            newV = cir.V.m+1;
            
            % Best to count the number of pins, voltage sources, current sources
            % before analyzing takes place
            
            if a ~= 0
                cir.B.set(a,newVs,1);
                % assume no dependent voltage source for now so that B = C'
                cir.C.set(newVs,a,1);
                cir.V.set(newV,1,V);
            end
            
            if b ~= 0
                cir.B.set(b,newVs,-1);
                % assume no dependent voltage source for now so that B = C'
                cir.C.set(newVs,b,-1);
                cir.V.set(newV,1,V);
            end
        end
    end
end

