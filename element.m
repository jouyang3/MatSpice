classdef (Abstract) element
    
    properties
        line
        pins
        val
    end
    
    methods
        function obj = element(line)
            %ELEMENT Construct an instance of this class
            %   Detailed explanation goes here
            obj.line = line;
        end
    end
    
    methods (Abstract)
        attach(this,cir)
    end
end

