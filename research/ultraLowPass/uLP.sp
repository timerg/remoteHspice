*ultra Low Pass filter. with my-2stageOP
*Tf: A(s)=Vout/Iin=-Rf/(1+(sRfCf/a))
*Rf use Mos implant; a is a current separation ratio
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1

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
**vvb zb gnd dc = 2
**mz1 zon zb von von pch w = 1u l = 1u
Rz zon von 100k
.ends

******current mirror***
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3

XOP1 vdd vss vinn vinp cp cn vop OP
******OPTEST_open***
vinp vinp gnd dc = 'comon-diff' *ac = 1
*vinn vinn gnd dc = 'comon+diff' ac = 1 *180
.param
+comon		= 2
+diff		= 0
********************
********************

***LowPass***
Rf vinn   vop 1000k
Cf vinn vop 1p

***input***
Iin vdd vinn dc = 100n  ac = 1u  *sin(1u 10n 1k 1ns)
Cin vinn gnd 3p
***output***
******E element***
eo vout gnd OPAMP ref vout
vr ref gnd dc = 2.2
.probe i(eo)
******OP by Design***
*XOP2 vdd vss vop2 vinp2 cp cn vop2 OP
*vinp2 vinp2 gnd dc = 2
*Ro vout vop2 0
*.probe dc i(ro)

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
.param
+supplyp	= 3.3
+supplyn	= 0

***Test***
Mt vgt vgt vst vst pch w = 1u l = 1u
It vst vdd dc = 1u
vtg vgt gnd dc = 2v

.op
*.dc Iin dec 100 1n 10u
*.dc It dec 100 1n 1u
*.probe dc i(me1) i(me2)
*+lx3(me1) lx3(me2) lx7(me1) lx7(me2)
.ac dec 1000 1 1g
.pz v(vop) Iin

.probe ac cap(von)
+gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

.end



*
*input =  0:vinn          output = v(vop)
*
*   poles (rad/sec)                 poles ( hertz)
*real            imag            real            imag
*-319.446k       0.              -50.8413k       0.
*-1.61208x       0.              -256.571k       0.
*-4.97363x       0.              -791.578k       0.
*-10.9005x       0.              -1.73486x       0.
*-61.3548x       0.              -9.76492x       0.
*-101.671x       0.              -16.1814x       0.
*-148.128x       0.              -23.5754x       0.
*-198.642x       0.              -31.6148x       0.
*-289.652x       0.              -46.0995x       0.
*-338.816x       0.              -53.9243x       0.
*-442.511x       0.              -70.4278x       0.
*-598.018x       0.              -95.1775x       0.
*
*   zeros (rad/sec)                 zeros ( hertz)
*real            imag            real            imag
*-1.85076x       0.              -294.558k       0.
*-9.78197x       0.              -1.55685x       0.
*14.2403x        0.              2.26641x        0.
*-20.7518x       0.              -3.30275x       0.
*-56.8046x       0.              -9.04074x       0.
*-97.6089x       0.              -15.5349x       0.
*-148.128x       0.              -23.5754x       0.
*-198.688x       0.              -31.6222x       0.
*-289.782x       0.              -46.1203x       0.
*-337.601x       0.              -53.7309x       0.
*-443.368x       0.              -70.5643x       0.
*-598.007x       0.              -95.1757x       0.
