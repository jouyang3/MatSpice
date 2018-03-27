
clear;
spice_begin
     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rvCir.circ');
    dc(cir);
spice_end

v2 = cir.vdc(2,0);
v3 = cir.vdc(3,0);