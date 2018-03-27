classdef res < element
    
    methods
        function obj = res(line)
            obj@element(line)
        end
        
        function attach(this,cir)
            fname = 'R.attach';
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
            R = str2num(args{4});
            
            cir.Ele(args{1}) = [a, b];
            this.pins = [a, b];
            this.val = R;
            cir.Res = [cir.Res this];
            % Emulating current flowing out of nodes
            % every increase in R in node a increase voltage of node a and
            % increase current flowing out of it by 1/R. And every increase of R
            % reduces voltage of node b and reduces voltage flowing out of node a
            % by 1/R (or increase by -1/R).
            %
            % Ignoring ground node.
            
            if a ~= 0
                cir.G.add(a,a,1/R);
                
            end
            
            if b ~= 0
                cir.G.add(b,b,1/R);
                
            end
            
            if a ~= 0 && b ~= 0
                cir.G.add(a,b,-1/R);
                cir.G.add(b,a,-1/R);
            end
        end
    end
end

