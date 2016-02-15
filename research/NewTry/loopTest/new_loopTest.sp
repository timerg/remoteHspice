*new_loopTest
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2 CONVERGE=5 dcon=2 unwrap=1

***subckt***
******iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch W = 12u  L = 5u  m = 1
M1	von	Vinp b	 b	 pch W = 6u   L = 5u  m = 1
M2	vop	Vinn b	 b	 pch W = 6u   L = 5u  m = 1
M3	von	von	 vss vss nch W = 3u   L = 5u  m = 1
M4	vop	von	 vss vss nch W = 3u   L = 5u    m = 1

Me1p vinp eb vdd vdd pch w = 10u l = 0.4u
Me2p vout eb vdd vdd pch w = 10u l = 0.4u m = 10
Me1n vinp vop vss vss nch  w = 2u l = 0.4u
Me2n vout vop vss vss nch  w = 2u l = 0.4u m = 10
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
.subckt Trx vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
*ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
*ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
*C1  2  vop 1p
.ends
******GM******
.subckt gm vdd vss inp inn io2  vb
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch  w = 2u    l = 2u m = 1
Min id  id  sd  in  pch w = 3u    l = 2u m = 1
Mn  id  gg  vss vss nch w = 5u    l = 5u m = 1
.ends
Mo3a io1 io1 vdd vdd pch w = 4.8u l = 5u m = 1
Mo4a io2 io1 vdd vdd pch w = 4.8u l = 5u m = 1
Mo1  io1 ggp vss vss nch w = 5.7u l = 1u m = 1
Mo2  io2 ggn vss vss nch w = 5.7u l = 1u m = 1
Mb  bd  vb  vdd vdd pch w = 5u l = 1u   m = 1
X1  vdd vss inn bd ggp idp sdp gmx
X2  vdd vss inp bd ggn idn sdn gmx
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
XTri vdd vss opb ti_in ti_out  cz  Tr rld=20k
Xgm  vdd vss gm_in gm_out gm_out  cz  gm
XTro vdd vss opb to_in to_out  cz  Trx
*XTro vdd vss to_in opb to_out  cz  gm       *use gm as op
Cg  gm_out gnd 1000p
XiEn vdd vss opb iEn_in iEn_out cz  eb iEn
veb eb gnd dc = 2.5

***NW Input Stage***
.param pbI = 1u
Ip vdd out dc = pbI
Mc  out vgn nwd vss nch w = 10u  l = 0.4u m = 1
vng vgn gnd dc = 1.8
.param wx = 6u
Mnw nwd vnw vss vss nch w = wx l = 0.4u m = 1
.param ins = 0



***Connection***
vc1 out     iEn_in dc = 0
vc2 iEn_out ti_in  dc = 0
vc3 ti_out  gm_in  dc = 0
vc4 gm_out  to_in  dc = 0
vfc to_out  vnw    dc = 0


vopbias opb gnd dc = 2 *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0




.probe dc  I(mnw) I(ip) I(mc) I(XTri.rl) lx3(mc) lv9(mc) lv9(mnw)
+ par'lx7(mc)/lx8(mc)/lx8(mnw)'
.probe ac vp(to_out)

.op




.alter *all
.lib 'Test.l' all

***loop gain Test***
.alter * on vnw
.del lib 'Test.l' all
.lib 'Test.l' vnw

.alter * on Tri_in
.del lib 'Test.l' vnw
.lib 'Test.l' Tri_in

.alter * on gm_in
.del lib 'Test.l' Tri_in
.lib 'Test.l' gm_in

.alter *On to_in
.del lib 'Test.l' gm_in
.lib 'Test.l' to_in

.alter * on out
.del lib 'Test.l' to_in
.lib 'Test.l' out

.end
