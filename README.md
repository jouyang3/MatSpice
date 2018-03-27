# MatSpice
SPICE for Matlab


## Simple resistive divider. File: test.cir
```spice
This is a netlist		$must have a title line

r1	1	2	500	$resistor connecting node 1 and 2
r2  2   0   1600 $resistor
r3  2   3   400
r4  3   0   240
r5  3   4   200
r6  5   0   300
v1  1   0   dc  5   $voltage source
v2  4   5   dc  10
.end				$Must have an end
```

```matlab
spice_begin
%     global logger
%     logger.setLogLevel(log4m.INFO);
%     logger.setCommandWindowLevel(logger.INFO);
    cir = load('test.cir');
    dc(cir);
spice_end

v1 = cir.vdc(1,0);
v21 = cir.vdc(2,1);
```

```matlab
>> cir.A

ans =

    0.0020   -0.0020         0         0         0    1.0000         0         0
   -0.0020    0.0051   -0.0025         0         0         0         0         0
         0   -0.0025    0.0117   -0.0050         0         0         0         0
         0         0   -0.0050    0.0050         0         0    1.0000         0
         0         0         0         0    0.0033         0   -1.0000         0
    1.0000         0         0         0         0         0         0    5.0000
         0         0         0    1.0000   -1.0000         0         0   10.0000
```

```matlab
>> cir.DC

ans =

    1.0000         0         0         0         0         0         0    5.0000
         0    1.0000         0         0         0         0         0    3.5808
         0         0    1.0000         0         0         0         0    3.3406
         0         0         0    1.0000         0         0         0    6.0044
         0         0         0         0    1.0000         0         0   -3.9956
         0         0         0         0         0    1.0000         0   -0.0028
         0         0         0         0         0         0    1.0000   -0.0133
```

```matlab
>> v1

v1 =

     5
```

```matlab
>> v21

v21 =

   -1.4192
```