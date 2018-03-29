classdef circuit < handle
    
    properties
        A = []; % Modified nodal analysis matrix
        DC = []; % DC result matrix
        G = mat; % passive elements
        B = mat; % independent voltage elements
        
        % definition of C and D subject to change for dependent voltage
        % sources.
        C = mat; % transpose of reindepdent voltage elements
        D = mat; % zero matrix
        
        I = mat; % KCL constraint.
        V = mat; % KVL constraint.
        
        Vsrc = containers.Map('KeyType','char','ValueType','any'); % Containers for voltage sources
        Isrc = containers.Map('KeyType','char','ValueType','any'); % Containers for current sources
        Res = containers.Map('KeyType','char','ValueType','any'); % Containers for resistors
        Cap = containers.Map('KeyType','char','ValueType','any'); % Containers for capacitors
        Ind = containers.Map('KeyType','char','ValueType','any'); % Containers for inductors
        % Ele = containers.Map('KeyType','char','ValueType','any'); % Element to terminal mappings
        nodes = nodemap;
    end
    
    methods
        
        function obj = circuit()
            obj.A = []; % Modified nodal analysis matrix
            obj.DC = []; % DC result matrix
            obj.G = mat; % passive elements
            obj.B = mat; % independent voltage elements
            
            % definition of C and D subject to change for dependent voltage
            % sources.
            obj.C = mat; % transpose of reindepdent voltage elements
            obj.D = mat; % zero matrix
            
            obj.I = mat; % KCL constraint vector.
            obj.V = mat; % KVL constraint vector.
            
            Vsrc = containers.Map('KeyType','char','ValueType','any'); % Containers for voltage sources
            Isrc = containers.Map('KeyType','char','ValueType','any'); % Containers for current sources
            Res = containers.Map('KeyType','char','ValueType','any'); % Containers for resistors
            Cap = containers.Map('KeyType','char','ValueType','any'); % Containers for capacitors
            Ind = containers.Map('KeyType','char','ValueType','any'); % Containers for inductors
            obj.nodes = nodemap;
        end
        
        function register(this,element,id)
            element.attach(this,id);
        end
        
        function conform(this) %fill zeros for the MNA matrix
            for ii=1:this.B.n
                this.B.A(this.B.m+1:this.G.m,ii) = 0;
            end
            this.B.m = this.G.m;
            for ii=1:this.C.m
                this.C.A(ii,this.C.n+1:this.G.n) = 0;
            end
            this.C.n = this.G.n;
            
            this.I.A(this.I.m+1:this.G.m,1) = 0;
            this.I.m = this.G.m;
        end
        
        function val = vdc(this,a,b)
            %% v: query node voltage.
            fname = 'vdc';
            global logger
            
            if length(this.DC) == 0
                logger.error(fname,'No DC solution');
                val = -1;
                return;
            end
            
            % Check input arguments are string or number
            
            if isa(a,'char')
                a = upper(a);
                if this.nodes.isKey(a)
                    a = this.nodes.get(a);
                else
                    es = sprintf('No such node exists: %s',a);
                    logger.error(fname,es);
                    val = -1;
                    return;
                end
            end
            
            if isa(b,'char')
                b = upper(b);
                if this.nodes.isKey(b)
                    b = this.nodes.get(b);
                else
                    es = sprintf('No such node exists: %s',a);
                    logger.error(fname,es);
                    val = -1;
                    return;
                end
            end 
            
            va = 0; vb = 0;
            if a ~= 0
                va = this.DC(a,end);
            end
            
            if b ~= 0
                vb = this.DC(b,end);
            end
            
            val = va - vb;
        end
        
        function val = idc(this,s)
            fname = 'idc';
            %% i: query element current
            val = 0;
            global logger;
            if isempty(s)
                logger.error('i','Must specify an element.');
                val = -1;
                return;
            end
            
            if length(this.DC) == 0
                logger.error(fname,'No DC solution');
                val = -1;
                return;
            end
            
            s = upper(s);
            type = s(1);
            
            switch(type)
                case 'R'
                    if ~isKey(this.Res,s)
                        es = sprintf('No such resistor exists: %s',s);
                        logger.error(fname,es);
                        val = -1;
                        return;
                    end
                    ele = this.Res(s);
                    va = this.vdc(ele.pins(1),0);
                    vb = this.vdc(ele.pins(2),0);
                    R = ele.val;
                    val = (va-vb)/R;
                    case 'C'
                    if ~isKey(this.Cap,s)
                        es = sprintf('No such capacitor exists: %s',s);
                        logger.error(fname,es);
                        val = -1;
                        return;
                    end
                    ele = this.Cap(s);
                    va = this.vdc(ele.pins(1),0);
                    vb = this.vdc(ele.pins(2),0);
                    C = ele.val;
                    val = (va-vb)*C/ele.tau;
                case 'V'
                    if ~isKey(this.Vsrc,s)
                        es = sprintf('No such voltage source exists: %s',s);
                        logger.error(fname,es);
                        val = -1;
                        return;
                    end
                    ele = this.Vsrc(s);
                    n = ele.id;
                    val = this.DC(this.G.m+n,end);
                case 'I'
                    if ~isKey(this.Isrc,s)
                        es = sprintf('No such current source exists: %s',s);
                        logger.error(fname,es);
                        val = -1;
                        return;
                    end
                    ele = this.Isrc(s);
                    val = ele.val;
                otherwise
                    es = sprintf('Element type unknown: %s',type);
                    logger.error(fname,es);
                    val = -1;
                    return;
            end
        end
    end
    
end

