***Switch
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1


.subckt switch vdd vss en in out
Mip eo  en  vdd vdd pch w = 2.3u l = 0.35u
Min eo  en  vss vss nch w = 1u l = 0.35u
Msp in  en  out vdd pch w = 2.3u l = 0.35u m = 2
Msn in  eo  out vss nch w = 1u l = 0.35u m = 2
.ends

XS1 vdd vss en in out switch
ro out vss 100k


.param voff = 0.3
vin in vss dc = voff sin(voff 0.1 1k 1us)
ven en vss dc = 3.3 pulse(0 3.3 1us 1us 1us 988us 2ms)

vd vdd gnd dc = 3.3
vs vss gnd dc = 0

.op
.tran 1us 10ms

.end