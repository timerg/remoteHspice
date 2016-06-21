*Subtractor
.protect
.lib 'mm0355v.l' tt
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1

mc0 cp cp vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn cp vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn cn vss vss nch w = 3.5u l = 5u m = 1
Iin cp vss 1u

md1 c1  cp  vdd vdd pch w = 1.5u l = 1u m = 1
md2 c1  c1  vss vss nch w = 5u   l = 3u m = 3
md3 c2  c1  vss vss nch w = 5u   l = 3u m = 1
md4 c2  c2  vdd vdd pch w = 5u   l = 3u m = 2



.subckt OP vdd vss vip vi out c2
Mb b   c2  vdd vdd pch w = 5u l = 3u m = 3
m1 op  vin b   b   pch w = 5u l = 3u m = 4
m2 o1  vip b   b   pch w = 5u l = 3u m = 4
m3 op  op  vss vss nch w = 5u l = 3u m = 1
m4 o1  op  vss vss nch w = 5u l = 3u m = 1

map out c2  vdd vdd pch w = 5u l = 3u m = 4
man out o1  vss vss nch w = 5u l = 3u m = 2
Ro  out vin 1000k
Ri  vi  vin 10k
*Mo  vin c1 out out pch w = 1u l = 5u
*Mi  vin c1  vi  vi  pch w = 1u l = 5u m = 100
.ends

XOP vdd vss vip vi vop c2 OP


Vd vdd vss dc = 3.3
Vs vss gnd dc = 0
Vip vip gnd dc = 1v

Vin vi vss dc = 1 ac = 1

.op
.dc Vin 0 3.3 0.001
.probe i(xop.ri)
.ac dec 1000 1 1g
.end