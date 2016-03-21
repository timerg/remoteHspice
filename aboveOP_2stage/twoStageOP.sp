***MyOp_2stage_aboveTH
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 *dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

***param***
.param
+comon		= 0.802
+bias		= 2.5
+bias1		= 0.6
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
+wx             = 10u
***netlist***
***1st stage***
.subckt OP vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 10u  L = 5u   m = 1
M1	1	Vinn b	 b	 pch W = 5u   L = 2u   m = 1
M2	2	Vinp b	 b	 pch W = 5u   L = 2u   m = 1
M3	1	1	 vss vss nch W = 2u   L = 2u   m = 1
M4	2	1	 vss vss nch W = 2u   L = 2u   m = 1
*Cc  2   gnd  100f
.ends

.subckt OP_a vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 12u  L = 10u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
.ends

.subckt OP_b vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 12u  L = 10u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
.ends

.subckt OP_ca vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 10u  L = 3u   m = 1
M1	1	Vinn b	 b	 pch W = 5u   L = 2u   m = 3
M2	2	Vinp b	 b	 pch W = 5u   L = 2u   m = 3
M3	1	1	 vss vss nch W = 2u   L = 0.8u   m = 1
M4	2	1	 vss vss nch W = 2u   L = 0.8u   m = 1
.ends

***2nd stage***
.subckt sdStage vdd vss 2 vop cz
ma1 vop cz vdd vdd pch W = 4u L = 1u m = 2
ma2 vop 2  vss vss nch W = 4u L = 1u m = 2
.ends
.subckt sdStage_a vdd vss 2 vop cz
ma1 vop cz vdd vdd pch W = 3.8u L = 1u m = 4
ma2 vop 2  vss vss nch W = 4u L = 1u m = 2
.ends


XOP  vdd vss vinp vinn 2 cz OP
XOP2 vdd vss 2 vop cz sdStage
***compensation***
Cc xx vop 1p
Rc 2  xx  15k

******

***current mirror***
.subckt CMB_beta4 vdd vss 1 4
M1 1   1   vdd vdd pch w = 20u l = 5u m = 1
M2 2   1   vdd vdd pch w = 20u l = 5u m = 1
M3 3   3   1   1   pch w = 20u l = 1u m = 1
M4 4   3   2   2   pch w = 20u l = 1u m = 1
M5 3   4   rx  vss nch w = '3.5u * 4' l = 5u m = 1
M6 4   4   vss vss nch w = '3.5u * 1' l = 5u m = 1
Msus1a s0  s1  vdd vdd pch w = 1u l = 5u m = 1
Msus1b s1  s1  s0  s0  pch w = 1u l = 5u m = 1
Msus2  s1  4   vss vss nch w = 3.5u l = 5u m = 1
Msus3  1   s1  4   vss nch w = 1u   l = 1u m = 1
r1 rx vss 25k
.ends
Xcmb vdd vss cz opb1 CMB_beta4

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias1


***input***
vinp vinp gnd dc = 'comon-diff' ac = 1
vinn vinn gnd dc = 'comon+diff' *ac = 1 180
*vinn vinn opb1 dc = 0

***test***
mt	vdt	vgt	vst	vst	nch	w = 6u   l = 5u m = 1
*mt	vdt	vgt	vst	vst	pch w = 2.8u l = 2u m = 1
*mt	vdt	vgt	vst	vst	pch	w = 12u   l = 5u m = 1
vtd	vdt	gnd dc = 0.3
vtg	vgt	gnd dc = 0.6
vts vst gnd dc = 0


***Open loop wi loading Test***


***cloase loop feedback test***



****Mos Resistor***




.op

***sweep***
*.dc diff -0.02 0.02 0.0001 *sweep bias wx 1u 12u 2u
.dc vinp 0 3.3 0.001

***probe&measuring***
.ac dec 1000 1 1g *sweep wx 1u 12u 2u
*.tf v(voa) vinp
.pz v(vop) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von) vp(vop)
+gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
*+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
*.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
*.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
*.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
*.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(2) vinp 100

*.alter
*.protect
*.lib 'mm0355v.l' ff
*.unprotect
*.alter
*.protect
*.lib 'mm0355v.l' ss
*.unprotect

.end
