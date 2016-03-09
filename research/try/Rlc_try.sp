*Rlc try
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7 unwrap = 1
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2  CONVERGE=1 * gmindc=1.000E-10 dcon=2

.subckt HP vdd vss in out
R1 in out 10k
L1 out vss 0.1m
.ends


Vi  in gnd dc = 1 ac = 1
vd  vdd gnd dc = 3.3
vs  vss gnd dc = 0
vb  cz  gnd dc = 2.4
vb2 opb gnd dc = 2

.subckt Tr vdd vss vinp vinn vop cz rld=20k
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
*C2  1  von 1p
RL   vop    vinn rld
.ends

R1 in inx  1g
C1 in inx  100p
XTr vdd vss opb inx vop cz Tr rld = 1k

.op
.ac dec 1000 1 1g
.probe ac vp(out)
.pz v(out) vi
.end
