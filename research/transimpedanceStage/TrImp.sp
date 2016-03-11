***MyOp_2stage_aboveTH
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1 reltol=1e-5

***param***
.param
+comon		= 1
+bias		= 2.4
+bias2		= 2.4
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
+wx         = 10u
***netlist***
***1st stage***
Mb	b	cz	 vdd vdd pch W = wx  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 1u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 1u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 3u L = 1u    m = 1


***2nd stage***
ma1 vop cz vdd vdd pch W = 4u L = 0.5u m = 2
ma2 vop 2  vss vss nch W = 1u L = 1u m = 2   *use 21u when in new model
***compensation***
*C1  2 vop 20f   *~ 60db
C1  2 vop 1p   *100f=~60db for RL added; but should be 600f for iEn added to get a flat band
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
vb1		b1		gnd dc bias2





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
.op
**.alter TrImp_Ol_woload
*vinp vinp gnd dc = 'comon-diff' *ac = 1
*vinn vinn gnd dc = 'comon+diff' ac = 1 *180
*.dc diff -0.5 0.5 0.01
*.ac dec 1000 0.1 1g
**.tf v(voa) vinp
*.pz v(vop) vinn
*.probe dc I(m1) I(m2)	I(mt)
*.probe ac vp(vop)
*+gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
*+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
*.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
*.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
*.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
*.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(vop) vinn 100
**
****Open loop wi loading Test***
.alter *TrImp_Ol_wiload
vinp vinp gnd dc = 'comon-diff' *ac = 1
vinn in gnd dc = 'comon+diff' ac = 1 180
Rin  in vinn 50K
RL   vop  gnd 50K
.ac dec 1000 0.1 1g
*.tf v(voa) vinp
.pz v(vop) vinn
.probe dc I(m1) I(m2)	I(mt)
.probe ac vp(vop)
+gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(vop) vinn 100

****cloase loop feedback test***
.alter *TrImp_IdcRTest
vinp vinp gnd  dc = 'comon' *ac = 1
Iin  vdd vinn dc = 1u ac = 1
*Rin  vinp vss 100g
RL   vop    vinn 50k
.dc Iin dec 50 1n 200u
*.dc Iin 100n 1000n 10n
.probe i(ma1)
.ac dec 1000 0.1 1g *sweep wx 5u 17u 3u
.pz v(vop) Iin
*.noise v(vop) Iin 100

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
