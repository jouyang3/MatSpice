classdef nodemap < handle
    %NODEMAP Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        map
        id
    end
    
    methods
        function obj = nodemap
            obj.id = 0;
            obj.map = containers.Map('KeyType','char','ValueType','int32');
            obj.map('0') = 0; % ground node.
        end
        
        function b = isKey(this,key)
            b = this.map.isKey(key);
        end
        
        function val = get(this,key)
            if isKey(this.map,key)
                val = this.map(key);
            else
                this.id = this.id+1;
                this.map(key) = this.id;
                val = this.id;
            end
        end
    end
end

