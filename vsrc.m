classdef vsrc < element
    
    methods
        function obj = vsrc(line)
            obj@element(line)
        end
        
        function attach(this,cir,id)
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
            
            as = args{2};
            bs = args{3};
            
            a = cir.nodes.get(as);    
            b = cir.nodes.get(bs);
            V = str2num(args{5});

            logger.info(fname,V);
            
            this.name = args{1};
            this.pins = [a, b];
            this.val = V;
            this.id = id;
            
            s = sprintf('%s (I%d) = %f',this.name,this.id,V);
            logger.info(fname,s);
            
            % Currently, map does not pass by reference...
            cir.Vsrc(this.name) = this;

            % every volt increase in voltage source increase current flowing out of
            % node a by 1A (a is the + of voltage source).
            
            % B: For i x j matrix, the jth direction represents jth voltage source.
            % C: For i x j matrix, the ith direction represents ith voltage source.
            % B = C' for circuit without dependent voltage sources.
            
            
            % Best to count the number of pins, voltage sources, current sources
            % before analyzing takes place
            
            if a ~= 0
                cir.B.set(a,this.id,1);
                % assume no dependent voltage source for now so that B = C'
                cir.C.set(this.id,a,1);
                cir.V.set(this.id,1,V);
            end
            
            if b ~= 0
                cir.B.set(b,this.id,-1);
                % assume no dependent voltage source for now so that B = C'
                cir.C.set(this.id,b,-1);
                cir.V.set(this.id,1,V);
            end
        end
    end
end

