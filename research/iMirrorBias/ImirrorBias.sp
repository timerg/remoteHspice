***Current Mirror
.protect
.lib 'mm0355v.l' sf
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1
*.OPTIONS NODE LIST


.subckt CMB vdd vss cp cp2 cp3 cp4 cn     *cp = 2.4; cp2 = 1.25; cp3 = 0.6; cp4 = 2.7
mc0 cp  cp  vdd vdd pch w = 5.1u l = 5u     m = 1
mc1 c0  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc5 c2  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc2 cp2 cp2 c0  c0  pch w = 1u   l = 5u     m = 1
mc6 c3  cp2 c2  c2  pch w = 1u   l = 5u     m = 1
mc3 cn  cp3 cp2 cp2 pch w = 5u   l = 0.5u   m = 2
mc7 cp3 cp3 c3  c3  pch w = 5u   l = 0.5u   m = 2
mc4 cn  cn  vss vss nch w = 1u   l = 3u     m = 1
mc8 cp3 cn  vss vss nch w = 1u   l = 3u     m = 1

mca cp4 cp4 vdd vdd pch w = 5u   l = 0.5u   m = 6
mcb cp4 cn  vss vss nch w = 1u   l = 2u     m = 1
.ends

.subckt CMB_beta vdd vss ix 1 2 rr = 60k wx = 1u
M0 ix  ix  vdd vdd pch w = 5u l = 5u  m = 1
M1 1   ix   vdd vdd pch w = 5u l = 5u m = 1
M2 2   ix   vdd vdd pch w = 5u l = 5u m = 1
M3 1   rx   vss vss nch w = wx  l = 2u m = 1
M4 2   1   rx  vss nch w = 'wx * 4' l = 2u m = 1
R1 rx  vss 1000k
.ends

.subckt CMB_beta2 vdd vss 1 2 3 4 rr = 60k wx = 1u
M1 1   1   vdd vdd pch w = 5u l = 5u m = 1
M2 2   1   vdd vdd pch w = 5u l = 5u m = 1
M3 1   2   3   vss nch w = wx  l = 1u m = 3
M4 2   2   4   vss nch w = wx  l = 1u m = 3
M5 3   3   vss vss nch w = wx  l = 1u m = 4
M6 4   3   rx  vss nch w = 'wx * 4' l = 1u m = 4
R1 rx  vss rr
.ends

.subckt CMB_beta3 vdd vss ix 1 2 3 4 rr = 60k wx = 1u
M0 ix  ix  vdd vdd pch w = 5u l = 5u  m = 1
M1 1   ix  vdd vdd pch w = 5u l = 5u m = 1
M2 2   ix  vdd vdd pch w = 5u l = 5u m = 1
M3 3   3   1   1   pch w = 5u l = 5u m = 1
M4 4   3   2   2   pch w = 5u l = 5u m = 1
M5 3   4   rx vss nch w = 'wx * 4'  l = 1u m = 1
M6 4   4   vss vss nch w = wx l = 1u m = 1
R1 rx  vss rr
.ends

.subckt CMB_beta4 vdd vss 1 4 wp = 20u
M1 1   1   vdd vdd pch w = wp l = 5u m = 1
M2 2   1   vdd vdd pch w = wp l = 5u m = 1
M3 3   3   1   1   pch w = wp l = 1u m = 1
M4 4   3   2   2   pch w = wp l = 1u m = 1
M5 3   4   rx  vss nch w = '3.5u * 4' l = 5u m = 1
M6 4   4   vss vss nch w = '3.5u * 1' l = 5u m = 1
r1 rx vss 25k
Msus1a s0  s1  vdd vdd pch w = 1u l = 5u m = 1
Msus1b s1  s1  s0  s0  pch w = 1u l = 5u m = 1
Msus2  s1  4   vss vss nch w = 3.5u l = 5u m = 1
Msus3  1   s1  4   vss nch w = 1u   l = 1u m = 1
.ends

.subckt CMB_bete5 vdd vss cp cn wp = 5u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1
.ends

.subckt Ibias vdd vss cn mpx mpy rin = 10k
mp  mpy mpx vdd vdd pch w = 1u   l =  0.5u m = 5
mpb io  mpx vdd vdd pch w = 1u   l =  0.5u m = 1
*Eo  io  vss OPAMP opb1 io

*vio vio vss dc = 0.8
Eio io gnd OPAMP io cn
*(id, vgs, gm, rds): (10n, -0.5423, 2.363e-07, 574x); (10u, -0.9871,  7.141e-05, 1.67x)
mn  mpy cn rx vss nch w = 3.5u l =  1u m = 2
r1  rx  vss rin
.ends

.subckt OPnw vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 12u  L = 10u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 1u  m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 1u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
ma1 vop cz vdd vdd pch W =  2u L = 0.5u m = 1
ma2 vop 2  vss vss nch W =  4u L = 1u m = 2
.ends

.subckt OPnw2 vdd vss vinp vinn 2 opb1 cp
******** bias from fd Op *******
mc1 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc2 cp2 opb1  cn2 cn2 nch w = 3.5u l = 1u   m = 3
mc3 cn2 cn2 vss vss nch w = 5u   l = 1u m = 2
********
M1	1	Vinp b	 vss nch W = 5u   L = 2u  m = 1
M2	2	Vinn b	 vss nch W = 5u   L = 2u  m = 1
M3	1	1	 vdd vdd pch W = 2u   L = 1u  m = 1
M4	2	1	 vdd vdd pch W = 2u   L = 1u  m = 1
Mb  b   cn2  vss vss nch w = 2u   l = 1u m = 1
C1   2   vinp 30f
*C3   1   vinp 100f
Mr1  xx  rb  1   1   pch w = 1u l = 5u m = 1
Mcr1 cr1 1   vdd vdd pch W = 2u l = 1u m = 1
Mcr2 cr1 cr1 vss vss nch w = 1u l = 0.5u m = 1
Mcr3 rb  cr1 vss vss nch w = 1u l = 0.5u m = 1
Mcr4 rb  rb  cr2 cr2 pch w = 1u l = 1u m = 2
Mcr5 cr2 cr2 vdd vdd pch W = 2u l = 1u m = 1
C2   2   xx  200f
*C5  vinp vss  100f
*C3   2  1 100f
*R3  zz  1  10x
.ends

.subckt OP_fc vdd vss vinp vinn vop cn cp
***input stage***
Mn	1	Vinp b	 b	 nch W = 3u   L = 5u  m = 2
Mp	2	Vinn b	 b	 nch W = 3u   L = 5u  m = 2
Mb 	b	cn2	 vss  vss nch W = 5u   L = 1u  m = 4
***output stage***
m1  1   cp2 vdd vdd pch w = 1u   l = 5u m = 2
m2  2   cp2 vdd vdd pch w = 1u   l = 5u m = 2
M3	von cp	1   1   pch W = 2u   L = 1u  m = 1      * gm*rds = 50 (id = 200n)
M4	vop	cp	2   2   pch W = 2u   L = 1u  m = 1
M5  von	cn  5   vss nch W = 2u   L = 1u  m = 1
M6  vop	cn  6   vss nch W = 2u   L = 1u  m = 1
M7  5   von vss vss nch W = 3u   L = 5u  m = 1
M8  6   von vss vss nch W = 3u   L = 5u  m = 1
mc1 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc2 cp2 cn  cn2 cn2 nch w = 3.5u l = 1u   m = 3
mc3 cn2 cn2 vss vss nch w = 5u   l = 1u m = 2
*C1  vop vss 5p
.ends




* vgsi + vdsb = 0.8; 0.8 - vth < vdsb
* => 0.8 - vth < 0.8 - vgsi -> vth > vgsi




Iin cp  vss dc = 1u
*Iin2 ix vss dc = 1u
Xcmb   vdd vss cp cn CMB_bete5 wp = 5u
*Xcmb_b vdd vss 1 2 3 4 CMB_beta2 rr = 10k wx = 1u
*Xcmb_c vdd vss ix 1 2 3 4 CMB_beta3 rr = 10k wx = 1u
*Xcmb_d vdd vss cz 4 CMB_beta4 wp = 20u



*** Compensation ***
*C1  vss mpy 1p
*R1  mpx xx 25k

*C2  xx 1   100f
*R2  mpy xx  100k



Mt vdt vgt vst vst nch w = 5u l = 5u
vtd vdt gnd dc = 2
vtg vgt gnd dc = 1.5
*vts vst gnd dc =
*vtb vbt gnd
It vst vss dc = 1u


.param
+supplyp	= 3.3
+supplyn	= 0
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn







*.tran 1us 20ms
*.ic v(1) = 3.3
**.ic v(4) = 0

*.alter
*.lib 'Test.l'  NoIb


.alter
.del lib 'Test.l'  NoIb
.lib 'Test.l' Closed
*
*
.alter
.del lib 'Test.l' Closed
.lib 'Test.l' IbOPtest

.alter
.del lib 'Test.l' IbOPtest
.lib 'Test.l' Loop
.end




*.subckt CMB_beta4 vdd vss 1 4
*M1 1   1   vdd vdd pch w = 20u l = 5u m = 1
*M2 2   1   vdd vdd pch w = 20u l = 5u m = 1
*M3 3   3   1   1   pch w = 20u l = 1u m = 1
*M4 4   3   2   2   pch w = 20u l = 1u m = 1
*M5 3   4   rx  vss nch w = '3.5u * 4' l = 5u m = 1
*M6 4   4   vss vss nch w = '3.5u * 1' l = 5u m = 1
*r1 rx vss 25k
*Msus1a s0  s1  vdd vdd pch w = 1u l = 5u m = 1
*Msus1b s1  s1  s0  s0  pch w = 1u l = 5u m = 1
*Msus2  s1  4   vss vss nch w = 3.5u l = 5u m = 1
*Msus3  1   s1  4   vss nch w = 1u   l = 1u m = 1
*.ends
*
*Xcmb vdd vss cz opb1 CMB_beta4
