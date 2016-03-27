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

*.subckt OP_fc vdd vss vinp vinn vop cp cp2 cn
****input stage***
*Mn	1	Vinn b	 b	 nch W = 3u   L = 1u  m = 2
*Mp	2	Vinp b	 b	 nch W = 3u   L = 1u  m = 2
*Mb1	b	cn	 01  vss nch W = 1u   L = 4u  m = 2
*Mb2	01	cn	 02  vss nch W = 1u   L = 4u  m = 2
*Mb3	02	cn	 vss vss nch W = 1u   L = 4u  m = 2
****output stage***
*m1  1   cp2 vdd vdd pch w = 3u   l = 2u  m = 3
*m2  2   cp2 vdd vdd pch w = 3u   l = 2u  m = 3
*M3	von cp	1   1   pch W = 5u   L = 1u  m = 2      * gm*rds = 50 (id = 200n)
*M4	vop	cp	2   2   pch W = 5u   L = 1u  m = 2
*M5  von	cn  5   vss nch W = 5u   L = 1u  m = 2
*M6  vop	cn  6   vss nch W = 5u   L = 1u  m = 2
*M7  5   von vss vss nch W = 3u   L = 5u  m = 1
*M8  6   von vss vss nch W = 3u   L = 5u  m = 1
*.ends
.subckt OP_fc vdd vss vinp vinn vop cp cn
***input stage***
Mn	1	Vinn b	 b	 nch W = 3u   L = 5u  m = 2
Mp	2	Vinp b	 b	 nch W = 3u   L = 5u  m = 2
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
.ends



*mc4 2 cp3 vdd vdd pch w = 5u l = 0.5u m = 1
*mc5 3 cp  2   2   pch w = 5u l = 0.5u m = 1
*Mc6	3 cn  cn2 vss nch W = 3.5u l = 1u  m = 1
*Mc7	cn2 cn2 vss vss nch W = 3.5u l = 5u  m = 1


.subckt OP vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 6u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
M2	2	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 1u    m = 1
M4	2	1	 vss vss nch W = 1u   L = 1u    m = 1
.ends
******
***current mirror***

*.subckt CMB_bete5 vdd vss cp cn cp2
*Iin cp  vss dc = 1u
*mc0 cp  cp  vdd vdd pch w = 5.1u l = 5u m = 1
*mc1 cn  cp  vdd vdd pch w = 5.1u l = 5u m = 4
*mc2 cn  cn  vss vss nch w = 3.2u  l = 5u m = 1
****(366n)
*mc3 cp2 cp2 vdd vdd pch w = 5.1u l = 5u m = 3
*mc4 cp2 cn  1   vss nch w = 1u  l = 5u m = 1
*mc5 1   cn  2   vss nch w = 1u  l = 5u m = 1
*mc6 2   cn vss  vss nch w = 1u  l = 5u m = 1
*r1  rx  vss 25k
*.ends
.subckt CMB_bete5 vdd vss cp cn cp2 wp = 5u
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1

.ends

*vcp2 cp2 gnd dc = 2.5454



Xcmb   vdd vss cp cn cp2 CMB_bete5


XOP    vdd vss vinp vinn vop cp cn  OP_fc




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
Mt vdt vgt vst vst nch w = 5u l = 1u m = 1
*vtd vdt gnd dc =
vtg vgt cp2  dc = 1.7441
vts vst gnd dc = 0
*vtb vbt gnd
It vdd vdt dc = 200n
*Im3,4 : 2.352e-07

*.dc It 0n 300n 1n

***Open loop wi loading Test***


***cloase loop feedback test***



****Mos Resistor***




.op

***sweep***
.dc diff -0.01 0.01 0.00001

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

.noise v(vop) vinp 100

*.alter
*.protect
*.lib 'mm0355v.l' ff
*.unprotect
*.alter
*.protect
*.lib 'mm0355v.l' ss
*.unprotect

*XOP vdd vss vinp vinn vop cp cp2 cn OP_fc
*.alter
*XOP vdd vss vinp vinn vop cn OP

.end
