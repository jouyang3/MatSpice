
clear;
spice_begin
     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rc.cir');
    dc(cir);
spice_end

voutin = cir.vdc(1,0)

vout3 = cir.vdc(2,0)

vout = cir.vdc(3,0)

% charge flowing into the voltage source from a to b.
iv1 = cir.idc('v1')

% charge flowing into R1 from a to b (node OUT to ground).
ir1 = cir.idc('R1')

% charge flowing into R2 from a to b (node OUT to ground).
ir2 = cir.idc('r2')

% charge flowing into C1 from a to b (node OUT to ground).
ic1 = cir.idc('c1')

% charge flowing into C2 from a to b (node OUT to ground).
ic2 = cir.idc('c2')

% MNA matrix
cir.A

% DC solution
cir.DC