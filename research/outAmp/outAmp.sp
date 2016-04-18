***outputAmplifier
.protect
.lib 'mm0355v.l' ff
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
Mb 	b	cn2	 vss  vss nch W = 10u   L = 0.5u  m = 6
***output stage***
m1  1   cp2 vdd vdd pch w = 3u   l = 5u m = 4
m2  2   cp2 vdd vdd pch w = 3u   l = 5u m = 4
M3	von cp	1   1   pch W = 2u   L = 1u  m = 1      * gm*rds = 50 (id = 200n)
M4	vop	cp	2   2   pch W = 2u   L = 1u  m = 1
M5  von	cn  5   vss nch W = 2u   L = 1u  m = 1
M6  vop	cn  6   vss nch W = 1u   L = 1u  m = 1
M7  5   von vss vss nch W = 3u   L = 5u  m = 1
M8  6   von vss vss nch W = 3u   L = 5u  m = 1
mc1 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc2 cp2 cn  cn2 vss nch w = 3.5u l = 1u   m = 3
mc3 cn2 cn2 vss vss nch w = 10u   l = 0.5u m = 1
cc vop vss 10f
CC2 1 vss 300f
*Cc3 von vss 200f
*Cc3 2 vss
.ends




.subckt CMB_bete5 vdd vss cp cn cn2 cp2
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1

mc4 cp2 cp2 vdd vdd pch w = 1u   l = 5u m = 1
mc5 cp2 cn  cn2 vss nch w = 3.5u l = 1u   m = 3
mc6 cn2 cn2 vss vss nch w = 2u   l = 1u m = 1
.ends


.subckt Tr vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 2u   L = 1u  m = 2
M1	1	Vinp b	 vdd pch W = 2u   L = 1u  m = 1
M2	2	Vinn b	 vdd pch W = 2u   L = 1u  m = 1
M3	1	1	 vss vss nch W = 2u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 2u   L = 1u  m = 1
ma1 vop cz vdd vdd pch   W = 2u L = 1u m = 1
ma2 vop 2  vss vss nch   W = 2u L = 1u m = 1
*Cc  vop 2 150f
.ends

.subckt TrA vdd vss vinp vinn 2 cn cn2 cp
M1	1	Vinp b	 vss nch W = 4u   L = 2u  m = 1
M2	2	Vinn b	 vss nch W = 4u   L = 2u  m = 1
M3	1	1	 vdd vdd pch W = 4u   L = 2u  m = 1
M4	2	1	 vdd vdd pch W = 4u   L = 2u  m = 1
Mb  b   cn2  vss vss nch w = 4u   L = 2u  m = 7
*Map	vop	2   vdd  vdd pch W = 2u   L = 1u  m = 1
*Man	vop	cn2 vss  vss nch W = 2u    L = 1u  m = 1
**Ma2	3	3	 vss  vss nch W = 2u   L = 1u  m = 4
*Cc  vop xx 100f
**Cc2 yy vop 20f
**Rc2 yy 1 10k
*mr  xx  rb  2  vdd pch w = 2u l = 1u m = 1
*mrb1 rb1 rb1 vdd vdd pch W = 2u   L = 1u  m = 1
*mrb2 rb  rb  rb1 vdd pch W = 2u   L = 1u    m = 1
*mrb3 rb  cn2 vss vss nch W = 2u   L = 1u  m = 1
.ends
**************





Xcmb   vdd vss cp cn cn2 cp2 CMB_bete5



*XOP_b  vdd vss cn vinn vop cp Tr
*XOP_b  vdd vss cn vinn vop cn cn2 cp TrA
XOP_fb vdd vss cn vinn vop cp cn cn2 OP_fc



***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn

***input***
vin vi cn dc = 'diff' ac = 1  pulse(0.3 0.31 1ns 1us 1us 48us 100us)



.dc diff -1 1 0.001
.ac dec 1000 0.1 1g
.pz v(vop) vin
.probe dc I(mr2) I(mr1)
.tran 1us 200us
.op
***sweep***
.alter
*vb bb vss bias2
*v1      vi  vinn dc = 0
*Mr1    vi vi vinn vinn pch w = 1u l = 0.4u m = 10
*Mr2    vop vop vinn vinn pch w = 1u l = 0.4u m = 1
*R1     vi vinn 1k
*R2     vop vinn 100k
C1      vi vinn  100f
*C1      vi vinn   500f
Ma      vop cp vinn vinn pch w = 1u l = 1u
C2      vop vinn 7f    *10f
.probe dc I(r1) I(r2) I(XOP_b.ma1) I(XOP_b.ma2)
.alter
*R1     vss vss 1k
**R2     vss vss 10k
*R2     vop vss 10k
**Mr2    vop vss o o pch w = 1u l = 0.4u m = 1
*Eo     o   gnd OPAMP cn o
*.probe dc I(r2) I(XOP_b.ma1) I(XOP_b.ma2)
*Mr1     vss vss  vss vss pch w = 1u l = 0.4u
*Mr2     vss vss vss vss pch w = 1u l = 0.4u m = 10
v1      vi  vinn dc = 0
C1      vss vss  200f
Ma      vss vss vss vss pch w = 1u l = 1u
C2      vop vss 7f
.probe ac vp(vop)
*
*
.end
