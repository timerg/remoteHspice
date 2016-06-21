*Subtractor
.protect
.lib 'mm0355v.l' tt
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1


.subckt readout vdd vss vb1 vx vy vz out cp cn c1 c2
mc0 cp cp vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn cp vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn cn vss vss nch w = 3.5u l = 5u m = 1
Iin cp vss 1u

md1 c1  cp  vdd vdd pch w = 1.5u l = 1u m = 1
md2 c1  c1  vss vss nch w = 5u   l = 3u m = 3
md3 c2  c1  vss vss nch w = 5u   l = 3u m = 1
md4 c2  c2  vdd vdd pch w = 5u   l = 3u m = 2

Xsub0 vdd vss c2 c1 vx vy vz out subtractor
*Xop vdd vss vin vz c1 OP
.ends

.subckt subtractor vdd vss vb1 vb2 vx vy vz out
mb d2  vb1 vdd vdd pch w = 5u l = 3u m = 3
m1 d3  vx  d2  d2  pch w = 5u l = 3u m = 1
m2 out vy  d2  d2  pch w = 5u l = 3u m = 1
m3 vg  vg  vz  vz  pch w = 5u l = 3u m = 1
m4 vss vg  out out pch w = 5u l = 3u m = 1
m7 d6  d3  vss vss nch w = 5u l = 3u m = 8
m8 d7  d3  vss vss nch w = 5u l = 3u m = 8
m5 d3  vb2 d6  vss nch w = 5u l = 3u m = 8
m6 vg  vb2 d7  vss nch w = 5u l = 3u m = 8
.ends

*.subckt OP vdd vss vin out c2
*Mb o1  c2  vdd vdd pch w = 5u l = 3u m = 3
*m1 op  vin o1  o1  pch w = 5u l = 3u m = 2
*m2 out out o1  o1  pch w = 5u l = 3u m = 2
*m3 op  op  vss vss nch w = 5u l = 3u m = 4
*m4 out op  vss vss nch w = 5u l = 3u m = 4
*.ends
.subckt Buf vdd vss vin out c1
m4 out op  vdd vdd pch w = 5u l = 3u m = 1
m3 op  op  vdd vdd pch w = 5u l = 3u m = 1
m2 out out o1  vss nch w = 5u l = 3u m = 2
m1 op  vin o1  vss nch w = 5u l = 3u m = 2
Mb o1  c1  vss vss nch w = 5u l = 3u m = 1
.ends

vd vdd vss 3.3
vs vss gnd 0

XR1 vdd vss vb1 vx vy vz out cp cn c1 c2 readout
Xbuf vdd vss out outb c1 Buf

Rout outb vo 10k
Vo vo vss dc = 1

vxx vx vss dc = 1v  ac = 1
vyy vy vss dc = 0.8v
vzz vz vss dc = 1v

.op
.dc vxx 3.3 0 0.01
.ac dec 1000 1 1g
.end

