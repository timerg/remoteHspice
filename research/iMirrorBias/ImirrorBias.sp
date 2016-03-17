***Current Mirror
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1


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
mcb cp4 cn  vss vss nch w = 1u   l = 3u     m = 1
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

.subckt CMB_beta4 vdd vss 1 4
M1 1   1   vdd vdd pch w = 20u l = 5u m = 1
M2 2   1   vdd vdd pch w = 20u l = 5u m = 1
M3 3   3   1   1   pch w = 20u l = 5u m = 1
M4 4   3   2   2   pch w = 20u l = 5u m = 1
M5 3   4   rx  vss nch w = '3.5u * 4' l = 5u m = 1
M6 4   4   vss vss nch w = '3.5u * 1' l = 5u m = 1
r1 rx vss 25k
.ends

*.subckt OPnw vdd vss vinp vinn vop cz
*Mb	b	cz	 vdd vdd pch W = 12u  L = 10u  m = 1
*M1	1	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
*M2	2	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
*M3	1	1	 vss vss nch W = 1u   L = 1u  m = 1
*M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
*ma1 vop cz vdd vdd pch W =  2u L = 0.5u m = 1
*ma2 vop 2  vss vss nch W =  4u L = 1u m = 2
*.ends
*XOPnw vdd vss mpy 1 mpx cz OPnw
*
*Mpn


Iin cp  vss dc = 1u
Iin2 ix vss dc = 1u
*Xcmb   vdd vss cp cp2 cp3 cp4 cn CMB
*Xcmb_b vdd vss 1 2 3 4 CMB_beta2 rr = 10k wx = 1u
*Xcmb_c vdd vss ix 1 2 3 4 CMB_beta3 rr = 10k wx = 1u
Xcmb_d vdd vss 1 4 CMB_beta4

.param
+supplyp	= 3.3
+supplyn	= 0
vd		vdd 	gnd dc supplyp ac = 1
vs		vss 	gnd dc supplyn

.op
.ac dec 1000 1 1g
.dc wx 1u 20u 1u  *sweep rr dec 5 10k 100k
*.dc rr 10 10k 10x

.probe dc I(Xcmb_d.m1) I(Xcmb_d.m2)

.end




*.subckt CMB_beta4 vdd vss 1 4
*M1 1   1   vdd vdd pch w = 20u l = 5u m = 1
*M2 2   1   vdd vdd pch w = 20u l = 5u m = 1
*M3 3   3   1   1   pch w = 20u l = 5u m = 1
*M4 4   3   2   2   pch w = 20u l = 5u m = 1
*M5 3   4   rx  vss nch w = '3.5u * 4' l = 5u m = 1
*M6 4   4   vss vss nch w = '3.5u * 1' l = 5u m = 1
*r1 rx vss 25k
*.ends
*
*Xcmb vdd vss cz opb1 CMB_beta4
