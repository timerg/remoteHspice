***outputAmplifier
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

***param***
.param
+comon		= 0.7963
+bias       = 2.4
+bias1		= 1.3
+bias2		= 0.2
+supplyp	= 3.3
+supplyn	= 0
+diff			= 0
***netlist***


.subckt OP_fc vdd vss vinp vinn vop cp cn cn2
***input stage***
Mn	1	Vinp b	 vss	 nch W = 3u   L = 5u  m = 2
Mp	2	Vinn b	 vss	 nch W = 3u   L = 5u  m = 2
Mb 	b	cn2	 vss  vss nch W = 2u   L = 1u  m = 4
***output stage***
m1  1   cp2 vdd vdd pch w = 1u   l = 5u m = 4
m2  2   cp2 vdd vdd pch w = 1u   l = 5u m = 4
M3	von cp	1   1   pch W = 2u   L = 1u  m = 1      * gm*rds = 50 (id = 200n)
M4	vop	cp	2   2   pch W = 2u   L = 1u  m = 1
M5  von	cn  5   vss nch W = 2u   L = 1u  m = 1
M6  vop	cn  6   vss nch W = 1u   L = 1u  m = 1
M7  5   von vss vss nch W = 3u   L = 5u  m = 1
M8  6   von vss vss nch W = 3u   L = 5u  m = 1
mc1 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc2 cp2 cn  cn2 vss nch w = 3.5u l = 0.5u   m = 7
mc3 cn2 cn2 vss vss nch w = 2u   l = 1u m = 1
.ends




.subckt CMB_bete5 vdd vss cp cn cn2
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1

mc4 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc5 cp2 cn  cn2 vss nch w = 3.5u l = 0.5u   m = 7
mc6 cn2 cn2 vss vss nch w = 2u   l = 1u m = 1
.ends


.subckt Tr vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 1u   L = 0.5u  m = 2
M1	1	Vinp b	 b	 pch W = 1u   L = 0.5u  m = 1
M2	2	Vinn b	 b	 pch W = 1u   L = 0.5u  m = 1
M3	1	1	 vss vss nch W = 1u   L = 0.5u  m = 1
M4	2	1	 vss vss nch W = 1u   L = 0.5u  m = 1
*ma1 vop cz vdd vdd pch   W = 2u L = 1u m = 2
*ma2 vop 2  vss vss nch   W = 2u L = 1u m = 1
*Cc  vop 2 150f
.ends

.subckt TrA vdd vss vinp vinn vop cn cn2
M1	1	Vinn b	 vss nch W = 2u   L = 0.5u  m = 1
M2	2	Vinp b	 vss nch W = 2u   L = 0.5u  m = 1
M3	1	1	 vdd vdd pch W = 2u   L = 0.5u  m = 2
M4	2	1	 vdd vdd pch W = 2u   L = 0.5u  m = 2
Mb  b   cn2  vss vss nch w = 2u   L = 0.5u  m = 2
Map	vop	2    vdd vdd pch W = 2u   L = 0.5u  m = 5
Man	vop	cn2	 vss vss nch W = 2u   L = 2u  m = 1
.ends
**************





Xcmb   vdd vss cp cn cn2 CMB_bete5



*XOP_b  vdd vss cn vinn vop cp Tr
XOP_b  vdd vss cn vinn vop cn cn2 TrA



***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn

***input***
vin vi vss dc = 'comon + diff' ac = 1  pulse('comon' 'comon + 0.01' 1ns 1us 1us 48us 100us)



.dc diff -1 1 0.001
.ac dec 1000 0.1 1g
.pz v(vop) vin
.probe dc I(mr2) I(mr1)
.tran 1us 200us
.op
***sweep***
.alter
*vb bb vss bias2
*Mr1    vi vi vinp vinp pch w = 1u l = 0.4u m = 10
*Mr2    vop vop vinp vinp pch w = 1u l = 0.4u m = 1
*R1     vi vinn 1k
*R2     vop vinn 10k
C1      vi vinn  200f
Ma      vop cn vinn vinn pch w = 1u l = 1u
C2      vop vinn 20f
.probe dc I(r1) I(r2) I(XOP_b.ma1) I(XOP_b.ma2)
*.alter
*R1     vss vss 1k
**R2     vss vss 10k
*R2     vop vss 10k
**Mr2    vop vss o o pch w = 1u l = 0.4u m = 1
*Eo     o   gnd OPAMP cn o
*.probe dc I(r2) I(XOP_b.ma1) I(XOP_b.ma2)
*Mr1     vss vss  vss vss pch w = 1u l = 0.4u
*Mr2     vss vss vss vss pch w = 1u l = 0.4u m = 10
*C1      vss vss  200f
*Ra      vss vss 100k
*C2      vss vss 10f
*vinp    vi vinn dc = 0
*
*
.end
