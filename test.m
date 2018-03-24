
clear;
spice_begin
%     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rCirc.circ');
    dc(cir);
spice_end

v1 = cir.v(1,0);
v21 = cir.v(2,1);