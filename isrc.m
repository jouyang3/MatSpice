classdef isrc < element
    
    methods
        function obj = isrc(line)
            obj@element(line)
        end
        
        function attach(this,cir,id)
            fname = 'I.attach';
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
            
            as = args{2};
            bs = args{3};
            
            a = cir.nodes.get(as);    
            b = cir.nodes.get(bs);
            I = str2num(args{5});
            
            this.name = args{1};
            this.pins = [a, b];
            this.val = I;
            this.id = id;
            
            s = sprintf('%s (I%d) = %f',this.name,this.id,I);
            logger.info(fname,s);
            
            % Currently, map does not pass by reference...
            cir.Isrc(this.name) = this;

            % every volt increase in voltage source increase current flowing out of
            % node a by 1A (a is the + of voltage source).
            
            % B: For i x j matrix, the jth direction represents jth voltage source.
            % C: For i x j matrix, the ith direction represents ith voltage source.
            % B = C' for circuit without dependent voltage sources.
            
            % Best to count the number of pins, voltage sources, current sources
            % before analyzing takes place
            
            if a ~= 0
                cir.I.set(a,1,-I);
            end
            
            if b ~= 0
                cir.V.set(b,1,I);
            end
        end
    end
end

