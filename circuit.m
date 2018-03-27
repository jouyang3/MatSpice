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
        
        Vsrc = []; % Containers for voltage sources
        Isrc = []; % Containers for current sources
        Res = []; % Containers for resistors
        Cap = []; % Containers for capacitors
        Ind = []; % Containers for inductors
        Ele = containers.Map('KeyType','char','ValueType','any'); % Element to terminal mappings
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
            
            obj.Vsrc = []; % Containers for voltage sources
            obj.Isrc = []; % Containers for current sources
            obj.Res = []; % Containers for resistors
            obj.Cap = []; % Containers for capacitors
            obj.Ind = []; % Containers for inductors
            obj.Ele = containers.Map('KeyType','char','ValueType','any'); % Element to terminal mappings
        end
        
        function register(this,element)
            element.attach(this);
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
        end
    end
    
end

