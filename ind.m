classdef ind < element
    
    methods
        function obj = ind(line)
            obj@element(line)
        end
        
        function attach(this,cir,id)
            fname = 'L.attach';
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
            L = str2num(args{4});
            
            this.name = args{1};
            this.pins = [a, b];
            this.val = L;
            this.id = id;
            
            s = sprintf('%s (I%d) = %f',this.name,this.id,L);
            logger.info(fname,s);
            
            % Currently, map does not pass by reference...
            cir.Ind(this.name) = this;

            % Emulating current flowing out of nodes
            % every increase in R in node a increase voltage of node a and
            % increase current flowing out of it by 1/R. And every increase of R
            % reduces voltage of node b and reduces voltage flowing out of node a
            % by 1/R (or increase by -1/R).
            %
            % Ignoring ground node.
            
            if a ~= 0
                cir.L.add(a,this.id,1);
                cir.VL.set(this.id,1,0);
            end
            
            if b ~= 0
                cir.L.add(b,this.id,-1);
                cir.VL.set(this.id,1,0);
            end
        end
    end
end

