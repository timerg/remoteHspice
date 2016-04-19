***Switch
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

Mip eo  en  vdd vdd pch w = 2.3u l = 0.35u
Min eo  en  vss vss nch w = 1u l = 0.35u

Msn in  eo  out vss nch w = 1u l = 0.35u
Msp out eo  in  vdd pch w = 2.3u l = 0.35u

.param voff = 1.7
vin in vss dc = voff sin(voff 0.1 1k 1ns)
ven en vss dc = 3.3 pulse(0 3.3 1us 1us 1us 48us 100us)

vd vdd gnd dc = 3.3
vs vss gnd dc = 0

.op
.tran 1us 10ms

.end