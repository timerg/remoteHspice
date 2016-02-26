*Current Enlargge: Use an OP and two mos of current mirror
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=0 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2

***OP include***


******netlist***

.subckt OP_a vdd vss vinn vinp cz 2
Mb	b	cz	 vdd vdd pch W = 1u   L = 5u  m = 1
M1	1	Vinp b	 b	 pch W = 1u   L = 5u  m = 1
M2	2	Vinn b	 b	 pch W = 1u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 1u   L = 5u  m = 1
*R1  2   gnd  700k
.ends
******current mirror***
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
Me1b vinp eb vdd vdd pch w = 10u l = 0.4u
Me2b vout eb vdd vdd pch w = 10u l = 0.4u m = 10
Me1 vinp vop vss vss nch w = 2u l = 1u            *decide by noise:
Me2 vout vop vss vss nch w = 2u l = 1u m = 10    *Id ~45n, In~0.8n
*veb eb gnd dc = '3.3-0.5'      *10n
veb eb gnd dc = '3.3-0.58'      *100n
*veb eb gnd dc = '3.3-0.7'      *1u
*veb eb gnd dc = '0.835'      *10u

Xcmb vdd vss cz cp2 cp3 cx cn CMB


XOP1 vdd vss vinn vinp cx vop OP_a




***input***
vinn vinn gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Iin vdd vinp dc = 10n  ac = 1  sin(1u 10n 1k 1ns)
Rin vinp gnd 100x

***output***

Eout vop2 gnd OPAMP opb vop2
Ro vout vop2 20
.probe dc i(ro)

***Compensation***
.param xx = 10f
Cc  vinp vop 10f

***
***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb      opb     gnd dc = comon
.param
+supplyp	= 3.3
+supplyn	= 0

***Test***
Mt  vdt vgt vst vst pch w = 5u l = 0.4u
It  vdd vst dc = 10n
vtg vgt gnd dc = 2v
vtd vdt gnd dc = 1v

XTest vdd vss in2 ip2 cx out_t OP_a
Vi in2 gnd dc = 2
Vi2 ip2 gnd dc = 2 ac = 1

.op

******Iinput*******
.dc Iin dec 100 1n 100u
*.dc It dec 100 1n 1u
*.probe dc i(me1) i(me2)
*+lx3(me1) lx3(me2) lx7(me1) lx7(me2)
*+I(xop1.m4n)
*********input impedance*********
*.print zin=par('v(vinp)/I(iin)') Id=par('I(iin)')

******AC*******
.ac dec 100 1 1g *sweep
.probe ac i(ro) vp(vop2)
*.pz i(ro) iin
.noise i(ro) Iin

******Trans******
*.tran 100ns 2ms
*.probe tran i(me1) i(me2)







.end



*output = v(vop2)
*           poles ( hertz)
*     real            imag
*     911.700k        -8.56193x
*     911.700k        8.56193x
*     -4.38735x       0.
*     -5.31034x       0.
*     -17.3329x       0.
*     -19.1465x       0.
*     -22.6105x       0.
*     -28.5118x       0.
*     -85.7586x       0.
*           zeros ( hertz)
*     real            imag
*     -4.39355x       0.
*     -5.31034x       0.
*     -17.6133x       0.
*     -19.1546x       0.
*     -28.5156x       0.
*     -63.4604x       0.
*     -85.7553x       0.
*     -259.342x       0.
*     1.14751g        0.
