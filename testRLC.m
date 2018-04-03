
clear;
spice_begin
     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('rcl.cir');
    dc(cir);
spice_end

% v1 = cir.vdc(1,0)
% 
% v2 = cir.vdc(2,0)
% 
% v3 = cir.vdc(3,0)
% 
% v4 = cir.vdc(4,0)

% charge flowing into the voltage source from a to b.
iv1 = cir.idc('v1')

% charge flowing into R1 from a to b .
ir1 = cir.idc('r1')

% charge flowing into R2 from a to b .
ir2 = cir.idc('r1')

% charge flowing through inductor L1 from a to b .
il1 = cir.idc('l1')

% charge flowing through inductor L1 from a to b .
il2 = cir.idc('l2')

% charge flowing into C1 from a to b .
ic1 = cir.idc('c1')

% charge flowing into C2 from a to b .
ic2 = cir.idc('c2')

% MNA matrix
cir.A

% DC solution
cir.DC