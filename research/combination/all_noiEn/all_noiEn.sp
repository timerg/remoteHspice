*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2 CONVERGE=1 dcon=1

***subckt***
******iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch W = 12u  L = 5u  m = 1
M1	von	Vinp b	 b	 pch W = 6u   L = 5u  m = 1
M2	vop	Vinn b	 b	 pch W = 6u   L = 5u  m = 1
M3	von	von	 vss vss nch W = 3u   L = 5u  m = 1
M4	vop	von	 vss vss nch W = 3u   L = 5u    m = 1

Me1p vinp vop vdd vdd pch w = 10u l = 0.4u
Me2p vout vop vdd vdd pch w = 10u l = 0.4u m = 10
Me1n vinp eb vss vss nch  w = 2u l = 0.4u            *decide by noise:
Me2n vout eb vss vss nch  w = 2u l = 0.4u m = 10    *Id ~45n, In~0.8n
*Rc  xx   vop 100k
Cc  vinp vop  1p
*Ct  vout gnd 300f
.ends
******Tr******
.subckt Tr vdd vss vinp vinn vop cz rld=20k
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
RL   vop    vinn rld
.ends
.subckt Trx vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
.ends
******GM******
.subckt gm vdd vss inp inn io2  vb
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch  w = 2u    l = 2u m = 1
Min id  id  sd  in  pch w = 3u    l = 2u m = 1
Mn  id  gg  vss vss nch w = 5u    l = 5u m = 1
.ends
.subckt gm2nd vdd vss ggp ggn io2
Mo3a io1 io1 vdd vdd pch w = 5.7u l = 5u m = 1
Mo4a io2 io1 vdd vdd pch w = 5.7u l = 5u m = 1
Mo1  io1 ggp vss vss nch w = 5.7u l = 1u m = 1
Mo2  io2 ggn vss vss nch w = 5.7u l = 1u m = 1
.ends
Mb  bd  vb  vdd vdd pch w = 5u l = 1u   m = 1
X1  vdd vss inp bd  ggp idp sdp gmx
X2  vdd vss inn bd  ggn idn sdn gmx
X2d vdd vss ggp ggn io2 gm2nd
V0  idp ggp dc = 0
V1  idn ggn dc = 0
.ends
******current mirror******
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3
mcx  cz cz vdd vdd pch w = 1u l = 1u m = 1
mcz  cz cn vss vss nch w = 10u l = 1u m = 3


***netlist***
XTri vdd vss opb ti_in ti_out  cz  Tr rld=200k
Xgm  vdd vss gm_in opb gm_out  cz  gm
XTro vdd vss opb to_in to_out  cz  Tr rld=300k
*XTrx vdd vss t3_in opb t3_out  cz  Trx
*Ero to_out gnd OPAMP opb to_in 100
*Rro to_in to_out 1x
***subckt Probe***
.probe dc xiEn.i(Me1p) xiEn.i(Me1n)
.probe tran i(xien.Me1p) par('-i(xien.Me1n)')
***NW Input Stage***
Ip vdd out dc = 653.7n   pulse(653.7n 1.6537u 200ns 1ns 1ns 3u 4u)
vpg vgp gnd dc = 2.3      * 1.178u
Mc  out vgn nwd vss nch w = 3u  l = 0.4u m = 1
vng vgn gnd dc = 1.8
.param wx = 6u
Mnw nwd vnw vss vss nch w = wx l = 0.4u m = 1
*vnw vnw gnd dc = 0.5v ac = 1

vc2 out  ti_in dc = 0
vc3 ti_out  gm_in dc = 0
vc4 gm_out  to_in dc = 0
*vc5 to_out  t3_in dc = 0

vfc to_out vnw dc = 1.5

vopbias opb gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0

***Output Stage**
***TEST***
Mt vdt vgt vst vst nch w = 8u l = 0.4u m = 1
vtg vgt gnd dc = 0.635
vtd vdt gnd dc = 1v
vts vst gnd dc = 0



.op

*.dc vpg 3.3 2.6 0.001
.dc wx 1u 20u 0.01u
.probe dc I(mp) I(mnw) I(ip) I(mc)
*.ac dec 1000 1 1g
*.probe ac vp(to_out)
*.noise
.tran 1ns 5us
.probe tran I(ins) I(mnw) I(ip)
.end
