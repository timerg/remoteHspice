*Try logarithm circuits
.protect
.lib '../mm0355v.l' TT DIO
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2

***netlist***

M2i v2  v2  v1  v1  nch w = 3u l = 1u
M1i v1  v1  gnd gnd nch w = 3u l = 1u
M2o out v2  v1o v1o nch w = 3u l = 1u m = 2
M1o v1o v1o gnd gnd nch w = 3u l = 1u m = 2

Iin gnd v2 dc = 1u
Eo  out gnd OPAMP ref out
vr ref gnd 2v
***
.op
.dc iin dec 1000 2n 2u
.probe dc i(eo)

.end
