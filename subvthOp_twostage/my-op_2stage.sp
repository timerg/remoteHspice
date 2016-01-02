***MyOp_2stage

.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
*.option dccap=1 accurate=1 post

***param***
.param
+comon		= 2
+bias		= 2.7
+bias2		= 0.45
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
***netlist***
***1st stage***
Mb	b	cp	vdd	vdd	pch	W = 31u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 10u L = 0.4u m = 1
M2	2	Vinp	b		b		pch	W = 10u L = 0.4u m = 1
M3	1	cn		vss	vss	nch	W = 4.1u L = 0.4u m = 2
M4	2	cn		vss	vss	nch	W = 4.1u L = 0.4u m = 2


***2nd stage***
m1pa	voa	voa	vdd	vdd	pch	w = 11u l = 0.4u    m = 2
m1pb	von	von	voa	voa	pch	w = 11u l = 0.4u    m = 2
m2pa	vo2	voa	vdd	vdd	pch	w = 11u l = 0.4u    m = 2
m2pb	vop	von	vo2 vo2	pch	w = 11u l = 0.4u    m = 2
m3n	    von	1   vss vss nch w = 5u  l = 0.4u    m = 1
m4n	    vop	2   vss vss nch w = 5u  l = 0.4u    m = 1

***compensation***
C1	2		von 200f
*C1	z1		von 400f
*Rz1	z1		1   350k
*C2	2			vop 300f


***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2


***input***
vinp vinp gnd dc = 'comon-diff' ac = 1
vinn vinn gnd dc = 'comon+diff' ac = 1 180

***current mirror***
Iin cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3

***test
*mt	vdt	vgt	vss	vss	nch	w = 2.7u   l = 0.5u m = 1
*mt	vdt	vgt	vdd	vdd	pch w = 9.7u l = 0.5u m = 1

*vtd	vdt	gnd dc = '1-499.7048m'
*vtg	vgt	gnd dc = '1-397.6836m'

***






.op

***sweep***
.dc diff -0.5 0.5 0.01
***probe&measuring***
.ac dec 1000 10 1g
*.tf v(1) vinp
*.pz v(vop) vinp
.probe dc I(m1) I(m2)	I(mt)
.probe ac cap(von)
+gain1st=par('Vdb(2, 1)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2,1)')
+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(1) vinn 10
.end


input =  0:vinp          output = v(vop)
* When no compensation
*   poles (rad/sec)                 poles ( hertz)
*real            imag            real            imag
*-2.80101x       0.              -445.795k       0.         on vop
*-5.61522x       0.              -893.689k       0.         on von
*-13.5275x       5.90903x        -2.15297x       940.451k
*-13.5275x       -5.90903x       -2.15297x       -940.451k
*-63.7656x       -8.96797x       -10.1486x       -1.42730x
*-63.7656x       8.96797x        -10.1486x       1.42730x
*-64.5024x       0.              -10.2659x       0.
*
*   zeros (rad/sec)                 zeros ( hertz)
*real            imag            real            imag
*-5.99163x       0.              -953.597k       0.
*-34.8033x       0.              -5.53911x       0.
*-42.3097x       42.6888x        -6.73381x       6.79414x
*-42.3097x       -42.6888x       -6.73381x       -6.79414x
*-63.8969x       0.              -10.1695x       0.
*1.66244g        0.              264.586x        0.
*10.9342g        0.              1.74024g        0.

*10p on von
*real            imag
*-689.315        0.
*-949.089k       0.
*-1.55498x       0.
*-6.61421x       -1.56277x
*-6.61421x       1.56277x
*-9.66091x       0.
*20p on von
*poles ( hertz)
*real            imag
*-344.925        0.
*-949.121k       0.
*-1.55466x       0.
*-6.61363x       1.56890x
*-6.61363x       -1.56890x
*-9.66216x       0.
*-10.2886x       0.


*10p on von
*real            imag
*-23.0853k       0.
*-414.689k       0.
*-1.36164x       0.
*-1.83273x       -1.48514x
*-1.83273x       1.48514x
*-10.0949x       0.
*-10.5872x       0.
*20p on von
*real            imag
*-11.6008k       0.
*-415.266k       0.
*-1.35863x       0.
*-1.83129x       -1.48205x
*-1.83129x       1.48205x
*-10.0950x       0.
*-10.5874x       0.

*5f on 2
*real            imag
*-410.465k       0.
*-790.082k       0.
*-2.05000x       -432.530k
*-2.05000x       432.530k
*-10.2211x       3.13995x
*-10.2211x       -3.13995x
*-10.5283x       0.
*10f on 2
*poles ( hertz)
*real            imag
*-368.853k       0.
*-714.132k       0.
*-1.73524x       0.
*-2.31034x       0.
*-10.3137x       3.74602x
*-10.3137x       -3.74602x
*-10.5503x       0.
*100f on 2
*real            imag
*-92.2256k       0.
*-571.771k       0.
*-1.30979x       0.
*-2.73241x       0.
*-10.5639x       -5.03642x
*-10.5639x       5.03642x
*-10.5740x       0.
*200f on 2
*real            imag
*-49.1352k       0.
*-564.470k       0.
*-1.29206x       0.
*-2.75561x       0.
*-10.5754x       0.
*-10.5917x       -5.16479x
*-10.5917x       5.16479x
