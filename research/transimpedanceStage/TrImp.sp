***Trimp
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1 reltol=1e-5

***param***
.param
*+comon		= 0.7967
+diff = 0
+supplyp	= 3.3
+supplyn	= 0
***netlist***
***1st stage***
*.param wx = 1.5u
Mb	b	cz	 vdd vdd pch W = 1.5u  L = 1u  m = 2          * 2.211u
M1	1	Vinn b	 b	 pch W = 3u   L = 1u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 1u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 3u   L = 1u    m = 1


***2nd stage***
*ma1 vop cz vdd vdd pch W = 4u L = 1u m = 1
*ma2 vop 2  vss vss nch W = 5.4u L = 1u m = 2   *use 21u when in new model
ma1 vop cz vdd vdd pch   W = 1.5u L = 1u m = 24
ma2 vop 2  vss vss nch   W = 12u L = 0.4u m = 3

***compensation***
*C1  vop gnd 1p   *~ 60db
Cc xx vop 50f
Rc 2  xx  10k
******

***current mirror***
*.subckt CMB vdd vss cp cp2 cp3 cp4 cn     *cp = 2.4; cp2 = 1.25; cp3 = cn =  0.6; cp4 = 2.7
*Iin cp  vss dc = 1u
*mc0 cp  cp  vdd vdd pch w = 5.1u l = 5u     m = 1
*mc1 c0  cp  vdd vdd pch w = 2u   l = 5u     m = 1
*mc5 c2  cp  vdd vdd pch w = 2u   l = 5u     m = 1
*mc2 cp2 cp2 c0  c0  pch w = 1u   l = 5u     m = 1
*mc6 c3  cp2 c2  c2  pch w = 1u   l = 5u     m = 1
*mc3 cn  cp3 cp2 cp2 pch w = 5u   l = 0.5u   m = 2
*mc7 cp3 cp3 c3  c3  pch w = 5u   l = 0.5u   m = 2
*mc4 cn  cn  vss vss nch w = 1u   l = 3u     m = 1
*mc8 cp3 cn  vss vss nch w = 1u   l = 3u     m = 1
*
*mca cp4 cp4 vdd vdd pch w = 5u   l = 0.5u   m = 6
*mcb cp4 cn  vss vss nch w = 1u   l = 3u     m = 1
*.ends
*
*Xcmb vdd vss cz cp2 cp3 cx cn CMB

.subckt CMB_bete5 vdd vss cp cn wp = 5u
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1
.ends
Xcmb   vdd vss cz opb1 CMB_bete5
*vb opb0 opb1 dc = 0

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
*vb 		b0		gnd dc bias
*vb1		b1		gnd dc bias2





***test***
mt	vgt	vgt	vss	vss	nch	w = 3u   l = 5u m = 1
*mt	vdt	vgt	vst	vst	pch w = 2.8u l = 2u m = 1
*mt	vdt	vgt	vst	vst	pch	w = 12u   l = 5u m = 1
vtd	vdt	gnd dc = 2.9
vtg	vgt	gnd dc = 0.65
vts vst gnd dc = 3.3

*
*
****sweep***
*
****input***
.alter *TrImp_Ol_woload
.lib 'Test.l' OPwoload

.alter *TrImp_Ol_wiload
.del lib 'Test.l' OPwoload
*.lib 'Test.l' OPwiload

****cloase loop feedback test***
*.alter *TrImp_IdcRTest
*.del lib 'Test.l' OPwiload
.lib 'Test.l' Cloop

***probe&measuring***

*.alter
*.protect
*.lib 'mm0355v.l' ff
*.unprotect
*.alter
*.protect
*.lib 'mm0355v.l' ss
*.unprotect

.end
