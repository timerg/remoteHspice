*Current Enlargge: Use an OP and two mos of current mirror
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=0 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2

***netlist***
******iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch W = 12u  L = 5u  m = 1
M1	von	Vinp b	 b	 pch W = 6u   L = 5u  m = 1
M2	vop	Vinn b	 b	 pch W = 6u   L = 5u  m = 1
M3	von	von	 vss vss nch W = 3u   L = 5u  m = 1
M4	vop	von	 vss vss nch W = 3u   L = 5u    m = 1

Me1b vinp eb vdd vdd pch w = 10u l = 0.4u
Me2b vout eb vdd vdd pch w = 10u l = 0.4u m = 10
Me1 vinp vop vss vss nch w = 2u l = 0.4u            *decide by noise:
Me2 vout vop vss vss nch w = 2u l = 0.4u m = 10    *Id ~45n, In~0.8n
*Rc  xx   vop 100k
Cc  vinp vop  1p
*Ct  vout gnd 300f
.ends

******Transimpedance******
.subckt Tr vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
RL   vop    vinn 20k
.ends

******current mirror******
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3
mcx  cz cz vdd vdd pch w = 1u l = 1u m = 1
mcz  cz cn vss vss nch w = 10u l = 1u m = 3


***
XiEn vdd vss opb iEn_in tr_in cz eb iEn
XTr  vdd vss opb tr_in  tr_out  cz    Tr
******OP_Bias***
vopbias opb gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 2
+diff		= 0
********************
********************



***bias***

*veb eb gnd dc = '3.3-0.5'      *10n
*veb eb gnd dc = '3.3-0.58'      *100n
*veb eb gnd dc = '3.3-0.7'      *1u
veb eb gnd dc = '3.3-0.85'      *10u



***input***
*******Source Input*******
Iin iEn_in vdd dc = 1u  ac = 1  sin(1u 10n 1k 1ns)
*Iin vdd iEn_in dc = 1u  ac = 1  sin(100n 10n 1k 1ns)
*******Mos Input*******

***
***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn
.param
+supplyp	= 3.3
+supplyn	= 0


***Test***
Mt  vdt vgt vst vst pch w = 5u l = 0.4u
It  vdd vst dc = 10n
vtg vgt gnd dc = 2v
vtd vdt gnd dc = 1v


.op

******DC*******
.dc Iin dec 100 1n 100u
******AC*******
.ac dec 1000 1 1t *sweep cc 100f 1p 100f
*.pz v(tr_out) Iin
.probe ac vp(tr_out)
.noise v(tr_out) Iin 100


.meas dc dcgain DERIVATIVE v(tr_out) at=1u
.meas ac ntot_ FIND onoise AT 10
.meas ac gain_ MAX par('Vdb(tr_out)')
.meas ac bandw WHEN Vdb(tr_out) = 'gain_ - 3.0'
*.meas ac bw
******Trans******
*.tran 100ns 2ms
*.probe tran i(me1) i(me2)

.alter
.protect
.lib 'mm0355v.l' ff
.unprotect
.alter

.protect
.lib 'mm0355v.l' ss
.unprotect

.alter
.protect
.lib 'mm0355v.l' fs
.unprotect

.alter
.protect
.lib 'mm0355v.l' sf
.unprotect

.end


*
*input =  0:iin          output = v(tr_out)
*
*   poles (rad/sec)                 poles ( hertz)
*real            imag            real            imag
*-2.17526x       0.              -346.204k       0.
*-13.5878x       0.              -2.16256x       0.
*-17.8031x       0.              -2.83344x       0.
*-33.3658x       0.              -5.31034x       0.
*-72.0493x       -10.9606x       -11.4670x       -1.74444x
*-72.0493x       10.9606x        -11.4670x       1.74444x
*-114.196x       21.4300x        -18.1748x       3.41069x
*-114.196x       -21.4300x       -18.1748x       -3.41069x
*-116.771x       0.              -18.5846x       0.
*-178.368x       0.              -28.3882x       0.
*-505.044x       0.              -80.3803x       0.
*-538.367x       0.              -85.6837x       0.
*-2.02683g       0.              -322.580x       0.
*-3.31633g       0.              -527.811x       0.
*
*   zeros (rad/sec)                 zeros ( hertz)
*real            imag            real            imag
*-13.0568x       0.              -2.07806x       0.
*-17.9082x       0.              -2.85018x       0.
*-33.3658x       0.              -5.31034x       0.
*38.0993x        0.              6.06369x        0.
*-69.4501x       0.              -11.0533x       0.
*-100.063x       0.              -15.9255x       0.
*-116.940x       0.              -18.6116x       0.
*-118.650x       -18.9219x       -18.8837x       -3.01152x
*-118.650x       18.9219x        -18.8837x       3.01152x
*-178.384x       0.              -28.3908x       0.
*-538.393x       0.              -85.6879x       0.
*-21.1729g       0.              -3.36977g       0.
