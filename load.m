function cir = load(filename)
    % circuit structure definition
    fname = 'load';
    source = [];
    cir = circuit;

    global logger
    
    % file handle
    fid = fopen(filename,'r');
    
    % Modified Nodal Analysis: http://qucs.sourceforge.net/tech/node14.html
    G = mat; % passive elements
    B = mat; % independent voltage elements
    
    % definition of C and D subject to change for dependent voltage
    % sources.
    C = mat; % transpose of indepdent voltage elements
    D = mat; % zero matrix
    
    z = mat; % constraint vector.
    
    %TODO: For all elements, need to map node names to numbers. As of now,
    %it is marking nodes with numbers. The algorithm breaks if nodes are
    %not continuous integers from 1:n.
    while 1
        line = upper(fgetl(fid));
        if isempty(line)
            continue;
        end
        
        if line == -1
            break;
        end
        
        type = line(1);
        logger.info('%s',line);
        %fprintf('%s\n',type);
        switch type
            case 'R' % Resistor
                logger.info(fname,'Resistor');
                buildR(line,G,z,cir);
            case 'C' % Capacitor
                logger.info(fname,'Capacitor');
            case 'L' % Inductor
                logger.info(fname,'Inductor');
            case 'I' % Current Source
                logger.info(fname,'Current Source');
            case 'V' % Voltage Source
                logger.info(fname,'Voltage Source');
                buildV(line,B,C,z,cir);
            otherwise
                % do nothing
        end
    end
    
    % assume no dependent sources yet.
    D = mat; D.set(C.m,B.n,0);
    
    G.horcat(B).vercat(C.horcat(D)).horcat(z);
    
    fclose(fid);
    
    cir.A = G.A;
end