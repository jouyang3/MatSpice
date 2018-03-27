classdef mat < handle
    %A matrix wrapper class to reduce memory copying operation on large
    %2D matrix. It is a handle class, so it does no operator overloading.
    
    properties
        A = zeros(0,0);
        m = 0;
        n = 0;
    end
    
    methods
        
        function obj = mat(varargin)
            defaults = {0,0};
            defaults(1:nargin) = varargin;
            obj.m = defaults{1};
            obj.n = defaults{2};
            obj.A = zeros(obj.m,obj.n);
        end
        function val = get(this,m,n)
            this.expand(m,n);
            val = this.A(m,n);
        end
        
        function set(this,m,n,val)
            this.expand(m,n);
            this.A(m,n) = val;
        end
        
        function add(this,m,n,val)
            this.set(m,n,this.get(m,n)+val);
        end
        
        function expand(this,m,n)
            [a,b] = size(this.A);
            
            if m>a
                this.A = [this.A;zeros(m-a,b)];
                this.m = m;
                if n>b
                    this.A = [this.A,zeros(m,n-b)];
                    this.n = n;
                end
            elseif n>b
                this.A = [this.A,zeros(a,n-b)];
                this.n = n;
                if m>a
                    this.A = [this.A;zeros(m-a,n)];
                    this.m = m;
                end
            end
        end
        
        function obj = horcat(this,other)
            [a,b] = size(this.A); [c,d] = size(other.A);
            this.expand(c,b); other.expand(a,d);
            this.A = [this.A,other.A];
            obj = this;
        end
        
        function obj = vercat(this,other)
            [a,b] = size(this.A); [c,d] = size(other.A);
            this.expand(a,d); other.expand(c,b);
            this.A = [this.A; other.A];
            obj = this;
        end
    end
end

