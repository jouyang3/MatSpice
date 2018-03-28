classdef (Abstract) element < handle
    
    properties
        line
        id
        name
        pins
        val
    end
    
    methods
        function obj = element(line)
            %ELEMENT Construct an instance of this class
            %   Detailed explanation goes here
            obj.line = line;
            obj.name = -1;
            obj.pins = [];
            obj.val = -1;
        end
    end
    
    methods (Abstract)
        attach(this,cir,id)
    end
end

