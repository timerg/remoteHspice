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
*C2  1  von 1p
RL   vop    vinn rld
.ends
.subckt Trx vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
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
XTro vdd vss opb to_in to_out  cz  Trx
*XTro vdd vss to_in opb to_out  cz  gm       *use gm as op
Cg  gm_out gnd 1000p
XiEn vdd vss opb iEn_in iEn_out cz  eb iEn
veb eb gnd dc = 2.6

***NW Input Stage***
.param pbI = 1u
Ip vdd out dc = pbI
Mc  out vgn nwd vss nch w = 10u  l = 0.4u m = 1
vng vgn gnd dc = 1.8
.param wx = 6u
Mnw nwd vnw vss vsn nch w = wx l = 0.4u m = 1
vsn vsn gnd dc = 0

vc1 out     iEn_in dc = 0
vc2 iEn_out ti_in  dc = 0
vc3 ti_out  gm_in  dc = 0
vc4 gm_out  to_in  dc = 0
vfc to_out vnw dc = 1.5





vopbias opb gnd dc = 2 *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0


***Compensation***
*Cc1 vnw nwd 100f


.probe dc I(mp) I(mnw) I(ip) I(mc) I(XTri.rl) lx3(mc) lv9(mc) lv9(mnw)
+ par'lx7(mc)/lx8(mc)/lx8(mnw)'

.op

***cloase loop test***
.alter  *Inw    #0
.lib 'Test.l' Inw


.alter  *wx     #1
.del lib 'Test.l' Inw
.lib 'Test.l' wx

.alter  *vsn(sweep v on bulk)       #2
.del lib 'Test.l' wx
.lib 'Test.l' vsn

***Single block Test***
.alter *Tri     #3
.del lib 'Test.l' vsn
.lib 'Test.l' Tri

.alter *GM-C        #4
.del lib 'Test.l' Tri
.lib 'Test.l' GMC


.alter * inputStage     #5
.del lib 'Test.l' GMC
.lib 'Test.l' InS


.alter *OPout       #6
.del lib 'Test.l' Ins
.lib 'Test.l' OPout

.alter *iEn
.del lib 'Test.l' OPout
.lib 'Test.l' Ien

*.alter *Tran
*.del lib 'Test.l' Ien
*.lib 'Test.l' Tran
.end
