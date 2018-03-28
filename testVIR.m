
clear;
spice_begin
     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rviCir.cir');
    dc(cir);
spice_end

A = cir.A

DC = cir.DC

v1 = cir.vdc(1,0)

v2 = cir.vdc(2,0)

v3 = cir.vdc(3,0)

% charge flowing into the voltage source from a to b.
i1 = cir.idc('i1')

% charge flowing into the floating resistor from a to b (node OUT to ground).
ir1 = cir.idc('R1')

% charge flowing into the floating resistor from a to b (node OUT to ground).
ir2 = cir.idc('r2')

% charge flowing into the resistor 3 from a to b (node OUT to ground).
ir3 = cir.idc('r3')

iv1 = cir.idc('v1')