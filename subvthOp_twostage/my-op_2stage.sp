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
M3	1	cn		vss	vss	nch	W = 4.2u L = 0.4u m = 2
M4	2	cn		vss	vss	nch	W = 4.2u L = 0.4u m = 2


***2nd stage***
m1pa	voa	voa	vdd	vdd	pch	w = 11u l = 0.4u    m = 2
m1pb	von	von	voa	voa	pch	w = 11u l = 0.4u    m = 2
m2pa	vo2	voa	vdd	vdd	pch	w = 11u l = 0.4u    m = 2
m2pb	vop	von	vo2 vo2	pch	w = 11u l = 0.4u    m = 2
m3n	    von	1   vss vss nch w = 5u  l = 0.4u    m = 1
m4n	    vop	2   vss vss nch w = 5u  l = 0.4u    m = 1

***compensation***
*Ct	gnd		2   100f
*Con	gnd	von 10p
*Con1 1 von 350f
*Cop2 2 vop 300f
*C1   1 gnd 100f  *flatten end
*C2   2 gnd  200f
*Cb   b gnd 10f         useless
*Cvoa gnd voa 500f      *useless
*Cvo2 gnd vo2 300f
*Cvoavo2 voa vo2 800f
Cvonvop von vop 100f
*Rz1	z1		1   100k
*Rl vop gnd 10x

***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
vb 		b0		gnd dc bias
vb1		b1		gnd dc bias2


***input***
vinp vinp gnd dc = 'comon-diff' ac = 1
vinn vinn gnd dc = 'comon+diff' *ac = 1 180
*viac 2 gnd ac = 1
*Lac 2 vac 1x
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

***feedback test***
*Rf vop vinn 1x
*If vdd vinn  dc = 10n





.op

***sweep***
.dc diff -0.5 0.5 0.01
*.dc If dec 100 1n 100n
***probe&measuring***
.ac dec 1000 10 1g
*.tf v(voa) vinp
.pz v(vop) vinp
*.pz v(vop) viac
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
*Vop: C=23.8f       R = 42.2Meg     1/RC = 9.94e5
*Von: C=1.58f       R = 1.26Meg     1/RC = 5.0189e8
*1:   C=12.81f      R = 7.82Meg     1/RC = 9.992e6
*2:   C=70.5f       R = 7.82Meg     1/RC = 1.83e6
*voa:               R = 0.64Meg



* When no compensation
*poles (rad/sec)                 poles ( hertz)
*real            imag            real            imag
*-991.234k       0.              -157.760k       0.
*-3.70828x       0.              -590.191k       0.
*-10.4857x       5.09194x        -1.66885x       810.407k       related with 2/vo2
*-10.4857x       -5.09194x       -1.66885x       -810.407k
*-33.8793x       2.52538x        -5.39205x       401.927k       related with von/voa
*-33.8793x       -2.52538x       -5.39205x       -401.927k
*-57.5252x       0.              -9.15541x       0.
*-93.0328x       0.              -14.8066x       0.
*-206.303x       0.              -32.8342x       0.
*-600.462x       0.              -95.5665x       0.
*
* zeros (rad/sec)                 zeros ( hertz)
*real            imag            real            imag
*-4.17705x       0.              -664.799k       0.
*-19.3206x       -41.3205        -3.07497x       -6.57636
*-32.5246x       31.1010x        -5.17645x       4.94988x
*-32.5249x       -31.1012x       -5.17649x       -4.94990x
*-34.7112x       0.              -5.52446x       0.
*-75.9391x       0.              -12.0861x       0.
*-203.883x       0.              -32.4491x       0.
*-595.997x       0.              -94.8558x       0.
*1.56105g        0.              248.449x        0.


***Belows are all hertz

*10p on vop
    *-376.340        0.
    *-656.088k       0.
    *-1.27406x       0.
    *-3.52040x       767.800k
    *-3.52040x       -767.800k
    *-5.38261x       0.
    *-9.26847x       0.
    *-14.8927x       0.
    *-32.8038x       0.
    *-95.5616x       0.
*20p on vop
    *-188.394        0.
    *-656.175k       0.
    *-1.27338x       0.
    *-3.52042x       -770.733k
    *-3.52042x       770.733k
    *-5.38276x       0.
    *-9.26858x       0.
    *-14.8928x       0.
    *-32.8038x       0.
    *-95.5616x       0.

*10p on von
    *-12.6388k       0.
    *-137.133k       0.
    *-1.05275x       0.
    *-1.51183x       -1.01119x
    *-1.51183x       1.01119x
    *-5.68914x       0.
    *-9.27224x       0.
    *-14.8896x       0.
    *-32.8078x       0.
    *-95.5625x       0.
*20p on von
    *-6.31962k       0.
    *-137.875k       0.
    *-1.05002x       0.
    *-1.51140x       -1.01021x
    *-1.51140x       1.01021x
    *-5.68922x       0.
    *-9.27234x       0.
    *-14.8898x       0.
    *-32.8078x       0.
    *-95.5625x       0.

*10p on 1
    *-2.03268k       0.
    *-134.362k       0.
    *-1.52181x       -791.868k
    *-1.52181x       791.868k
    *-4.88827x       0.
    *-5.36748x       0.
    *-9.75394x       0.
    *-16.1904x       0.
    *-31.6174x       0.
    *-95.0939x       0.
*20p on 1
    *-1.01687k       0.
    *-134.480k       0.
    *-1.52168x       791.806k
    *-1.52168x       -791.806k
    *-4.88756x       0.
    *-5.36776x       0.
    *-9.75445x       0.
    *-16.1923x       0.
    *-31.6158x       0.
    *-95.0933x       0.

*10p on 2
    *-2.02090k       0.
    *-253.350k       0.
    *-1.01610x       0.
    *-1.44566x       0.
    *-5.28245x       -348.531k
    *-5.28245x       348.531k
    *-9.75076x       0.
    *-16.1967x       0.
    *-31.6118x       0.
    *-95.0930x       0.
*20p on 2
    *-1.01393k       0.
    *-252.912k       0.
    *-1.01471x       0.
    *-1.44689x       0.
    *-5.28236x       348.474k
    *-5.28236x       -348.474k
    *-9.75127x       0.
    *-16.1985x       0.
    *-31.6102x       0.
    *-95.0924x       0.

*10p on voa
    *-24.9726k       0.
    *-135.803k       0.
    *-1.03813x       0.
    *-1.44614x       1.01803x
    *-1.44614x       -1.01803x
    *-5.27405x       0.
    *-9.19147x       0.
    *-14.8347x       0.
    *-32.8250x       0.
    *-95.5651x       0.
*20p on voa
    *-12.4628k       0.
    *-137.463k       0.
    *-1.03286x       0.
    *-1.44559x       1.01562x
    *-1.44559x       -1.01562x
    *-5.27415x       0.
    *-9.19151x       0.
    *-14.8348x       0.
    *-32.8250x       0.
    *-95.5651x       0.


********************seperate Analysis***************
*Only first stage:
*1:   C=20.8f      R = 7.80Meg     1/RC = 6.16e6
* Cgtot of M3n = 4.2f.      If add, 1/RC = 5.12e6
    *output = v(2)
    *          poles ( hertz)
    *    real            imag
    *    -886.270k       0.
    *    -1.60085x       0.
    *    -9.01906x       0.
    *    -14.4680x       0.
    *    -33.2242x       0.
    *    -95.7495x       0.
    *          zeros ( hertz)
    *    real            imag
    *    -848.888k       0.
    *    -6.29865x       0.
    *    -12.7089x       0.
    *    -32.7232x       0.
    *    -95.0935x       0.
    *    281.367x        0.

    *node 1
        *50f on 1
        *        poles ( hertz)
        *real            imag
        *-288.159k       0.
        *-1.33452x       0.
        *-9.52682x       0.
        *-15.4585x       0.
        *-32.2845x       0.
        *-95.3476x       0.
        *zeros ( hertz)
        *real            imag
        *-215.482k       0.
        *-7.30722x       0.
        *-13.1237x       0.
        *-31.8567x       0.
        *-94.7120x       0.
        *283.933x        0.
        *
        *100f on 1
        *        poles ( hertz)
        *real            imag
        *-168.922k       0.
        *-1.31870x       0.
        *-9.59380x       0.
        *-15.6478x       0.
        *-32.1096x       0.
        *-95.2783x       0.
        *zeros ( hertz)
        *real            imag
        *-123.715k       0.
        *-7.45753x       0.
        *-13.2103x       0.
        *-31.6979x       0.
        *-94.6461x       0.
        *284.382x        0.

***********test record*********

*novoa       voa = 100f:                    voa = 300f          voa = 500f
*            output = v(vop)
*                  poles ( hertz)
*            real            imag
*            -159.572k       0.
*            -506.086k       0.
*1.6x 0.8xj  -1.80793x       -1.06880x
*1.6x-0.8xj  -1.80793x       1.06880x
*5.4x 0.4xj  -1.92130x       0.     ->>   1.38x
*5.4x-0.4xj  -5.25387x       0.     ->>   trival changing
*            -9.18434x       0.
*            -14.8268x       0.
*            -32.8281x       0.
*            -95.5656x       0.
*                  zeros ( hertz)
*            real            imag
*            -669.750k       0.
*3x          -2.34489x       1.06876x                       ->> 768k (couple with 1st zero)
*5.1 5xj     -2.34491x       -1.06876x                      ->> 2.0x
*5.1-5xj     -5.73303x       4.20699x
*            -5.73304x       -4.20697x
*            -12.1759x       0.
*            -32.4657x       0.
*            -94.8875x       0.
*            248.449x        0.
*            266.390x        0.

*novo2      vo2 = 100f                      vo2 = 300f
*           output = v(vop)
*                 poles ( hertz)
*           real            imag
*           -147.244k       0.
*590k       -728.711k       -171.924k       0.4x -0.18x
*1.6x 0.8k  -728.711k       171.924k        0.4x + 0.18x
*1.6x-0.8k  -1.41122x       0.              1.6x
*5.4x 0.4x  -4.26628x       0.              4.1x
*5.4x-0.4x  -5.64215x       0.
*           -9.19128x       0.
*           -14.8336x       0.
*           -32.8242x       0.
*           -95.5648x       0.
*                 zeros ( hertz)
*           real            imag
*           -647.637k       0.
*           -1.15770x       0.
*           -5.39008x       -5.15500x
*           -5.39010x       5.15498x
*           -5.39292x       0.
*           -12.0852x       0.
*           -32.4608x       0.
*           -94.8945x       0.
*           248.449x        0.
*           270.007x        0.
