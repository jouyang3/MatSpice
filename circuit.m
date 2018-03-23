classdef circuit < handle
    
    properties
        A = []; % Modified nodal analysis matrix
        R = []; % Gaussian-Jordan reduced matrix of A
        E = containers.Map('KeyType','char','ValueType','any'); % Element to terminal mappings
        V = mat; % Containers for all node's voltages
    end
    
    methods
        
        function val = v(this,a,b)
        %% v: query node voltage.
            va = 0; vb = 0;
            if a ~= 0
                va = this.V.get(a,1); % this.A(a,end)
            end
            
            if b ~= 0
                vb = this.V.get(b,1); % this.A(b,end)
            end
            
            val = va - vb;
        end
        
        function val = i(this,s)
        %% i: query element current
            val = 0;
            global logger;
            if isempty(s)
                logger.error('i','Must specify an element.');
            end
        end
    end
        
end

