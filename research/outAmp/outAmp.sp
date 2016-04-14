***outputAmplifier
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

***param***
.param
+comon		= 0.797
+bias       = 2.4
+bias1		= 1.3
+bias2		= 0.6
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




.subckt CMB_bete5 vdd vss cp cn wp = 5u
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1
.ends


.subckt Tr vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 1u  L = 0.5u  m = 1
M1	1	Vinn b	 b	 pch W = 2u   L = 0.5u  m = 2
M2	2	Vinp b	 b	 pch W = 2u   L = 0.5u  m = 2
M3	1	1	 vss vss nch W = 2u   L = 0.5u  m = 1
M4	2	1	 vss vss nch W = 2u   L = 0.5u  m = 1
*ma1 vop cz vdd vdd pch   W = 1.5u L = 1u m = 2
*ma2 vop 2  vss vss nch   W = 3u L = 0.4u m = 1
*Cc  vop 2 150f
.ends
**************





Xcmb   vdd vss cp cn CMB_bete5



XOP_b  vdd vss cn vinp vop cp Tr



***source***
vd		vdd 	gnd dc supplyp
vs		vss 	gnd dc supplyn

***input***
vin vi gnd dc = '0.797 + diff' ac = 1

***test***
Mt vdt vgt vst vst nch w = 5u l = 1u m = 1
*vtd vdt gnd dc =
vtg vgt vst  dc = 1.7441
vts vst gnd dc = 0
*vtb vbt gnd
It vdd vdt dc = 200n
*Im3,4 : 2.352e-07

*.dc It 0n 300n 1n





.dc diff -0.4 0.4 0.001
.ac dec 1000 0.1 1g
.pz v(vop) vin
.probe dc I(mr2) I(mr1)

.op
***sweep***
.alter
*Mr1    vinp  cn  vi vi pch w = 1u l = 0.4u m = 1
*Mr2    vop vop vinp vinp pch w = 1u l = 0.4u m = 1
*R1     vi vinp 1000
*R2     vop vinp 10k
C1      vi vinp  200f
Ra      vop vinp 100k
C2      vop vinp 10f
.alter
Mr1     vss vss  vss vss pch w = 1u l = 0.4u
Mr2     vss vss vss vss pch w = 1u l = 0.4u m = 10
C1      vss vss  200f
Ra      vss vss 100k
C2      vss vss 10f
vinp    vi vinp dc = 0

*.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
*.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
*.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
*.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

*.noise v(vop) vin 100



*.alter
*.protect
*.lib 'mm0355v.l' ff
*.unprotect
*.alter
*.protect
*.lib 'mm0355v.l' ss
*.unprotect

*XOP vdd vss vinp vinn vop cp cp2 cn OP_fc
*.alter
*XOP vdd vss vinp vinn vop cn OP

.end
