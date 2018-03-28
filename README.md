# MatSpice
SPICE for Matlab


## Simple resistive divider. File: rvCir.cir
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