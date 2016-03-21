***MyOp_2stage_aboveTH
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

***param***
.param
+comon		= 2
+bias       = 2.4
+bias1		= 1.3
+bias2		= 0.6
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
***netlist***

.subckt OP_fc vdd vss vinp vinn vop cp cp2 cn
***input stage***
Mb	b	cp	 vdd vdd pch W = 6u   L = 5u  m = 1
M1	1	Vinp b	 b	 pch W = 3u   L = 3u  m = 1
M2	2	Vinn b	 b	 pch W = 3u   L = 3u  m = 1
***output stage***
My1 von von  vdd vdd pch w = 3u   L = 5u  m = 1
My2 vop von  vdd vdd pch w = 3u   L = 5u  m = 1
M3	von cp2	 1   vss nch W = 3u   L = 3u  m = 1
M4	vop	cp2	 2   vss nch W = 3u   L = 3u  m = 1
Mz1 1	cn	 vss vss nch W = 5u   L = 3u  m = 2
Mz2	2	cn	 vss vss nch W = 5u   L = 3u  m = 2
.ends

.subckt OP vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 6u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u    m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
.ends
******

***current mirror***

.subckt CMB_bete5 vdd vss cp cn cp2
mc0 cp  cp  vdd vdd pch w = 5.1u l = 5u m = 1
mc1 cn  cp  vdd vdd pch w = 5.1u l = 5u m = 4
mc2 cn  cn  vss vss nch w = 3.2u  l = 5u m = 1
***(366n)
mc3 cp2 cp2 vdd vdd pch w = 5.1u l = 5u m = 3
mc4 cp2 cn  1   vss nch w = 1u  l = 5u m = 1
mc5 1   cn  2   vss nch w = 1u  l = 5u m = 1
mc6 2   cn vss  vss nch w = 1u  l = 5u m = 1
r1  rx  vss 25k
.ends
Xcmb   vdd vss cp cn cp2 CMB_bete5


***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb0		b0		gnd dc bias
vb1		b1		gnd dc bias1
vb2		b2		gnd dc bias2

***input***
vinp vinp gnd dc = 'comon+diff' ac = 1
vinn vinn gnd dc = 'comon-diff' *ac = 1 180

***test***
*mt	vdt	vgt	vss	vss	nch	w = 3.5u   l = 5u m = 1
mt	vgt	vgt	vst	vst	nch w = 10u l = 1u m = 1
*mt	vdt	vgt	vst	vst	pch	w = 12u   l = 5u m = 1
vtd	vdt	gnd dc = 2
vtg	vgt	gnd dc = 1.4
vts vst gnd dc = 0.6


***Open loop wi loading Test***


***cloase loop feedback test***



****Mos Resistor***




.op

***sweep***
.dc diff -0.2 0.2 0.001

***probe&measuring***
.ac dec 1000 0.1 1g
*.tf v(voa) vinp
*.pz v(2) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von)
+gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
*+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
*.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
*.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
*.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(vop) vinp 100

*.alter
*.protect
*.lib 'mm0355v.l' ff
*.unprotect
*.alter
*.protect
*.lib 'mm0355v.l' ss
*.unprotect

XOP vdd vss vinp vinn vop cp cp2 cn OP_fc
.alter
XOP vdd vss vinp vinn vop cn OP

.end
