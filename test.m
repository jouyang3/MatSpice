
clear;
spice_begin
     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rvCir.cir');
    dc(cir);
spice_end

voutin = cir.vdc('out','in')

vout3 = cir.vdc('out',3)

vout = cir.vdc('out',0)

% charge flowing into the voltage source from a to b.
iv1 = cir.idc('v1')

% charge flowing into the floating resistor from a to b (node OUT to ground).
ir1 = cir.idc('R1')

% charge flowing into the floating resistor from a to b (node OUT to ground).
ir2 = cir.idc('r2')

% charge flowing into the resistor 3 from a to b (node OUT to ground).
ir3 = cir.idc('r3')