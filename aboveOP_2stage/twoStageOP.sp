***MyOp_2stage_aboveTH
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

***param***
.param
+comon		= 1
+bias		= 2.5
+bias1		= 0.6
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
***netlist***
***1st stage***
.subckt OP vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 12u  L = 10u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 5u   m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 5u   m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u   m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u   m = 1
.ends



***2nd stage***
.subckt sdStage vdd vss 2 vop cz
ma1 vop cz vdd vdd pch W = 2u L = 0.5u m = 1
ma2 vop 2  vss vss nch W = 4u L = 1u m = 2
.ends




XOP  vdd vss vinp vinn 2 cz OP
XOP2 vdd vss 2 vop b0 sdStage
***compensation***
C2 2 vop 10p

******

***current mirror***
.subckt CMB vdd vss cp cp2 cp3 cp4 cn     *cp = 2.4; cp2 = 1.25; cp3 = cn =  0.6; cp4 = 2.7
Iin cp  vss dc = 1u
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

Xcmb vdd vss cz cp2 cp3 cx cn CMB

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias1


***input***
vinp vinp gnd dc = 'comon-diff' ac = 1
vinn vinn gnd dc = 'comon+diff' *ac = 1 180

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
.dc diff -0.1 0.1 0.0001 sweep bias 2.2 2.3 0.1

***probe&measuring***
.ac dec 1000 1 1g sweep *bias 2.2 2.3 0.1
*.tf v(voa) vinp
.pz v(vop) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von) vp(vop)
+gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
*+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
*.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
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
