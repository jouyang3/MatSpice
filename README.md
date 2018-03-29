# MatSpice
SPICE for Matlab

## DC Simulations
### Simple resistive divider. Netlist File: rvCir.cir
```spice
This is a netlist		$must have a title line

r1	in	out	1000	$resistor connecting node 1 and 2
r2  out   3   500 $resistor
r3  out   0   250
v1  in   0   dc  6   $voltage source
.end				$Must have an end
```

```matlab
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
```

```matlab
>> test

voutin =

   -4.8000


vout3 =

     0


vout =

    1.2000


iv1 =

   -0.0048


ir1 =

    0.0048


ir2 =

     0


ir3 =

    0.0048
```

```matlab
>> cir.A

ans =

    0.0010   -0.0010         0    1.0000         0
   -0.0010    0.0070   -0.0020         0         0
         0   -0.0020    0.0020         0         0
    1.0000         0         0         0    6.0000
```

```matlab
>> cir.DC

ans =

    1.0000         0         0         0    6.0000
         0    1.0000         0         0    1.2000
         0         0    1.0000         0    1.2000
         0         0         0    1.0000   -0.0048
```

### Circuit with current source. Netlist File: rviCir.cir
```spice
This is a netlist		$must have a title line

r1	1	2	1000	$resistor connecting node 1 and 2
r2  2   3   500 $resistor
r3  2   0   250
i1  3   0   dc  0.001
v1  1   0   dc  6   $voltage source
.end				$Must have an end
```

```matlab

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
```

```matlab
A =

    0.0010   -0.0010         0    1.0000         0
   -0.0010    0.0070   -0.0020         0         0
         0   -0.0020    0.0020         0   -0.0010
    1.0000         0         0         0    6.0000


DC =

    1.0000         0         0         0    6.0000
         0    1.0000         0         0    1.0000
         0         0    1.0000         0    0.5000
         0         0         0    1.0000   -0.0050


v1 =

     6


v2 =

    1.0000


v3 =

    0.5000


i1 =

   1.0000e-03


ir1 =

    0.0050


ir2 =

   1.0000e-03


ir3 =

    0.0040


iv1 =

   -0.0050
```

### Simple RC circuit. Netlist File: rc.cir
```spice
This is a netlist		$must have a title line

r1	1	2	1000	$resistor connecting node 1 and 2
r2  2   0   500 $resistor
c1  2   3   300e-15 $capacitor
c2  3   0   200e-15
v1  1   0   dc  5   $voltage source
.end				$Must have an end
```

```matlab

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
```

```matlab
voutin =

     5


vout3 =

    1.6667


vout =

    1.0000


iv1 =

   -0.0033


ir1 =

    0.0033


ir2 =

    0.0033


ic1 =

   2.0000e-19


ic2 =

   2.0000e-19


ans =

    0.0010   -0.0010         0    1.0000         0
   -0.0010    0.0030   -0.0000         0         0
         0   -0.0000    0.0000         0         0
    1.0000         0         0         0    5.0000


ans =

    1.0000         0         0         0    5.0000
         0    1.0000         0         0    1.6667
         0         0    1.0000         0    1.0000
         0         0         0    1.0000   -0.0033
```