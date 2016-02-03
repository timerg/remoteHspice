*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2 CONVERGE=0 dcon=2

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
*.subckt gm2nd vdd vss ggp ggn io2
Mo3a io1 io1 vdd vdd pch w = 4.8u l = 5u m = 1
Mo4a io2 io1 vdd vdd pch w = 4.8u l = 5u m = 1
Mo1  io1 ggp vss vss nch w = 5.7u l = 1u m = 1
Mo2  io2 ggn vss vss nch w = 5.7u l = 1u m = 1
*.ends
Mb  bd  vb  vdd vdd pch w = 5u l = 1u   m = 1
X1  vdd vss inn bd ggp idp sdp gmx
X2  vdd vss inp bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*X2d vdd vss ggp ggn io2 gm2nd
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
XTri vdd vss opb ti_in ti_out  cz  Tr rld=20k
Xgm  vdd vss gm_in gm_out gm_out  cz  gm
*XTro vdd vss opb to_in to_out  cz  Trx
XTro vdd vss opb to_in to_out  cz  gm       *use gm as op
Cg  gm_out gnd 10p

***NW Input Stage***
.param pbI = 3.5u
*Ip vdd out dc = pbI
Mp  out vgp vdd vdd pch w = 5u l = 1u m = 1
vpg vgp gnd dc = 2.3      * 1.178u
Mc  out vgn nwd vss nch w = 10u  l = 0.4u m = 1
vng vgn gnd dc = 1.8
.param wx = 6u
Mnw nwd vnw vss vsn nch w = wx l = 0.4u m = 1
*vnw vnw gnd dc = 0.63v ac = 1 sin(0.63 0.01 1k 1ns)
vsn vsn gnd dc = 0  sin(0 0.1 10k 1ns) *ac = 1
*.ic v(to_in) = opb
vc2 out  ti_in dc = 0
vc3 ti_out  gm_in dc = 0
vc4 gm_out  to_in dc = 0


vfc to_out vnw dc = 1.5 ac = 1 *sin(1.5 0.1 1k 1ns)
.param ins_ = 0
ins nwd gnd dc = ins_ *ac = 1


vopbias opb gnd dc = 2 *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0

***AC Stage**
.param cc = 0.1p
Cl vnw nwd cc
***TEST***
Mt vdt vgt vst vst nch w = wx l = 0.4u m = 1
It vst vss dc = 'pbI-ins_'
vtg vgt gnd dc = 0.6
vtd vdt gnd dc = 1.2v
.probe dc lx2(mt)
*vts vst gnd dc = 0



.op
.dc ins_ dec 1000 100n 10u
*.dc vsn -3 3 0.001
*.dc vpg 3.3 2.6 0.001
*.dc wx 0.4u 20u 0.1u

.probe dc I(mp) I(mnw) I(ip) I(mc) I(XTri.rl) lx3(mc) lv9(mc) lv9(mnw)
+ par'lx7(mc)/lx8(mc)/lx8(mnw)'
.ac dec 1000 1 1g *sweep cc dec 1 10f 100p
*.ac wx 0.4u 20u 0.1u
*.probe ac vp(to_out)
*.pz v(out) vnw
*.noise
*.tran 1us 5ms
**.ic i(mnw) = pbI
*.probe tran I(ins) I(mnw) I(ip)
**.ic v(vnw) = 0.5
*.meas tran out_max max v(ti_out)
*.meas tran out_min min v(ti_out)
*.meas tran amp param = '(out_max - out_min)/2'
***Single block Test***
.alter *Tri
XTri vdd vss opb ti_inx ti_outx  cz  Tr rld=20k
vc2 ti_inx inx dc = 0
ins vdd inx dc = ins_ ac = 1

.alter *GM-C
Xgm  vdd vss gm_inx gm_outx gm_outx  cz  gm
vc3 gm_inx gnd dc = 'comon' ac = 1
Cg  gm_outx gnd 10p
vc4 to_in gnd dc = 0
ins nwd vss dc = ins_ ac = 1

.alter * inputStage
XTri vdd vss opb ti_inx ti_outx  cz  Tr rld=20k
vnw vnw gnd dc = 0.63v ac = 1 sin(0.63 0.01 1k 1ns)
vc2 out  ti_inx dc = 0
vc3 gnd gm_in dc = 0
vfc to_out gnd dc = 0

.alter *OPout
XTro vdd vss opb to_inx to_outx  cz  gm
vc4 to_inx gnd dc = 2 ac = 1
vfc to_out gnd dc = 0
ins nwd vss dc = ins_ ac = 1
.end
