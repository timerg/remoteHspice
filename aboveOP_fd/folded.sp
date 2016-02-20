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
***1st stage***
Mb	b	cp	 vdd vdd pch W = 6u   L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 3u  m = 1
M2	2	Vinp b	 b	 pch W = 3u   L = 3u  m = 1

*Mx1 x   x1   vdd vdd pch w = 10u   L = 1u  m = 1
*Mx2 x1  x1   vdd vdd pch w = 10u   L = 1u  m = 1
My1 von von  vdd vdd pch w = 3u   L = 5u  m = 1
My2 vop von  vdd vdd pch w = 3u   L = 5u  m = 1
M3	von	b1	 1   vss nch W = 3u   L = 3u  m = 1
M4	vop	b1	 2   vss nch W = 3u   L = 3u  m = 1
Mz1 1	cn	 vss vss nch W = 5u   L = 3u  m = 2
Mz2	2	cn	 vss vss nch W = 5u   L = 3u  m = 2


***2nd stage***

***compensation***

******

***current mirror***
Iin  cp vss dc = 1u
mc0  cp0 cp0 vdd vdd pch w = 2u   l = 0.4u   m = 5
mc0a cp  cp  cp0 cp0 pch w = 10u   l = 0.4u   m = 5
mc1  c0  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc5  c2  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc2  cp2 cp2 c0  c0  pch w = 1u   l = 5u     m = 1
mc6  c3  cp2 c2  c2  pch w = 1u   l = 5u     m = 1
mc3  cn  cp3 cp2 cp2 pch w = 5u   l = 0.5u   m = 2
mc7  cp3 cp3 c3  c3  pch w = 5u   l = 0.5u   m = 2
mc4  cn  cn  vss vss nch w = 1u   l = 3u     m = 1
mc8  cp3 cn  vss vss nch w = 1u   l = 3u     m = 1


***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb0		b0		gnd dc bias
vb1		b1		gnd dc bias1
vb2		b2		gnd dc bias2

***input***
vinp vinp gnd dc = 'comon-diff' ac = 1
vinn vinn gnd dc = 'comon+diff' *ac = 1 180

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

.end
