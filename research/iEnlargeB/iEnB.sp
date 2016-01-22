*Current Enlargge: Use an OP and two mos of current mirror
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2

***OP include***


******netlist***
.subckt OP vdd vss vinn vinp cp cn vop
Mb	b	cp	vdd	vdd	pch	W = 31u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 10u L = 0.4u m = 1
M2	2	Vinp	b		b		pch	W = 10u L = 0.4u m = 1
M3	1	cn		vss	vss	nch	W = 4.2u L = 0.4u m = 2
M4	2	cn		vss	vss	nch	W = 4.2u L = 0.4u m = 2

m1pa	voa	voa	vdd	vdd	pch	w = 4u l = 0.4u    m = 2
m1pb	von	von	voa	voa	pch	w = 4u l = 0.4u    m = 2
m2pa	vo2	voa	vdd	vdd	pch	w = 4u l = 0.4u    m = 2
m2pb	vop	von	vo2 vo2	pch	w = 4u l = 0.4u    m = 2
m3n	    von	1   vss vss nch w = 15u   l = 0.4u    m = 2
m4n	    vop	2   vss vss nch w = 15u   l = 0.4u    m = 2

******Compensation***
Cvonvop zon vop 1p
*vvb zb gnd dc = 2
*mz1 zon zb von von pch w = 1u l = 1u
Rz zon von 100k
.ends

******current mirror***
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3

XOP1 vdd vss vinn vinp cp cn vop OP
*Ei vop gnd OPAMP vinp vinn 100
******OPTEST_open***
*vinp vinp gnd dc = 'comon-diff' *ac = 1
vinn vinn gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 1.7
+diff		= 0
********************
********************

***enlargement Mos***
*******Pinput*******
*Me1 vinp vop vdd vdd pch w = 5u l = 0.4u
*Me2 vout vop vdd vdd pch w = 5u l = 0.4u m = 100
*Me1b vinp eb vss vss nch w = 2u l = 0.4u            *decide by noise:
*Me2b vout eb vss vss nch w = 2u l = 0.4u m = 100    *Id ~45n, In~0.8n
*veb eb gnd dc = 0.6
*******Ninput*******
Me1b vinp eb vdd vdd pch w = 8u l = 0.4u
Me2b vout eb vdd vdd pch w = 8u l = 0.4u m = 100
Me1 vinp vop vss vss nch w = 2u l = 0.4u            *decide by noise:
Me2 vout vop vss vss nch w = 2u l = 0.4u m = 100    *Id ~45n, In~0.8n
veb eb gnd dc = '3.3-0.57'
***

***input***
*******Source Input*******
Iin vinp vdd dc = 10n  ac = 1  sin(1u 10n 1k 1ns)
*Iin vdd vinp dc = 100n  ac = 1  sin(1u 10n 1k 1ns)
*******Mos Input*******

***output***
******E element***
*eo vout gnd OPAMP ref vout
*vr ref gnd dc = 1.7
*.probe dc i(eo)

******OP by Design***
XOP2 vdd vss vop2 vinp2 cp cn vop2 OP
vinp2 vinp2 gnd dc = 1.7
Ro vout vop2 0
.probe dc i(ro)

***
***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
.param
+supplyp	= 3.3
+supplyn	= 0

***Test***
Mt  vdt vgt vst vst pch w = 5u l = 0.4u
It  vdd vst dc = 100n
vtg vgt gnd dc = 2v
vtd vdt gnd dc = 1v

.op

******Iinput*******
.dc Iin dec 100 1n 10u
*.dc It dec 100 1n 1u
*.probe dc i(me1) i(me2)
*+lx3(me1) lx3(me2) lx7(me1) lx7(me2)
*+I(xop1.m4n)
*********input impedance*********
*.print zin=par('v(vinp)/I(iin)') Id=par('I(iin)')

******AC*******
.ac dec 100 1 1g
.noise i(ro) Iin

******Trans******
*.tran 100ns 2ms
*.probe tran i(me1) i(me2)
.end
