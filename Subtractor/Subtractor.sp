*Subtractor
.protect
.lib 'mm0355v.l' tt
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1


.subckt readout vdd vss vb1 vx vy vz out
mb1 vb1 vb1 vdd vdd pch w = 5u l = 3u m = 16
mb2 vb2 vb1 vdd vdd pch w = 5u l = 3u m = 16
mb3 vb2 vb2 vss vss nch w = 3u l = 15u

Xsub0 vb1 vb2 vx vy vz out vdd vss subtractor

.ends

.subckt subtractor vb1 vb2 vx vy vz out vdd vss
mb d2  vb1 vdd vdd pch w = 5u l = 3u m = 16
m1 d3  vx  d2  d2  pch w = 1u l = 18u
m2 out vy  d2  d2  pch w = 1u l = 18u
m3 vg  vg  vz  vz  pch w = 1u l = 18u
m4 vss vg  out out pch w = 1u l = 18u
m7 d6  d3  vss vss nch w = 5u l = 3u m = 8
m8 d7  d3  vss vss nch w = 5u l = 3u m = 8
m5 d3  vb2 d6  vss nch w = 5u l = 3u m = 8
m6 vg  vb2 d7  vss nch w = 5u l = 3u m = 8
.ends

mc0 cp cp vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn cp vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn cn vss vss nch w = 3.5u l = 5u m = 1
Iin cp vss 1u

vd vdd vss 3.3
vs vss gnd 0

XR1 vdd vss vb1 vx vy vz out readout
R1 vb1 vss 7x

vxx vx vss dc = 1.5v
vyy vy vss dc = 1.5v
vzz vz vss dc = 1.5v

.op
.dc vxx 3.3 0 0.01
.end

