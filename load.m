function cir = load(filename)
    % circuit structure definition
    fname = 'load';
    source = [];
    cir = circuit;

    global logger
    
    % file handle
    fid = fopen(filename,'r');

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
                cir.register(res(line));
            case 'C' % Capacitor
                logger.info(fname,'Capacitor');
            case 'L' % Inductor
                logger.info(fname,'Inductor');
            case 'I' % Current Source
                logger.info(fname,'Current Source');
                %buildI(line,z,cir);
            case 'V' % Voltage Source
                logger.info(fname,'Voltage Source');
                cir.register(vsrc(line));
            otherwise
                % do nothing
        end
    end
    
    cir.conform();
    
    % assume no dependent sources yet.
    cir.D = mat; cir.D.set(cir.C.m,cir.B.n,0);
    
    cir.A = [cir.G.A cir.B.A cir.I.A; cir.C.A, cir.D.A cir.V.A];
    
    fclose(fid);
end