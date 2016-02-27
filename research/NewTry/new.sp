*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2 *CONVERGE=1 dcon=2

***subckt***
******iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch   W = 5u  L = 5u  m = 1
M1	von	Vinp b	 b	 pch   W = 1u  L = 5u  m = 1
M2	vop	Vinn b	 b	 pch   W = 1u  L = 5u  m = 1
M3	von	von	 vss vss nch   W = 1u  L = 5u  m = 1
M4	vop	von	 vss vss nch   W = 1u  L = 5u    m = 1

Me1p vinp eb vdd vdd pch   w = 10u l = 0.4u
Me2p vout eb vdd vdd pch   w = 10u l = 0.4u m = 10
Me1n vinp vop vss vss nch  w = 2u l = 1u
Me2n vout vop vss vss nch  w = 2u l = 1u m = 10
*Rc  xx   vop 100k
Cc  vinp vop  10f
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
******GM******
.subckt gm vdd vss inp inn io2  vb
Mb  bd  vb  vdd vdd pch w = 3u l = 10u   m = 1
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch w = 2u    l = 1u m = 1
Min id  id  sd  in  pch w = 1u    l = 5u m = 1
Mn  id  gg  vss vss nch w = 2u    l = 2u m = 1
.ends
Mb1  bd   ggp  bump vss nch w = 4u l = 1u m = 1
Mb2  bump ggn  vss  vss  nch w = 5u l = 1u m = 1
Mo1  io1  ggn  vss  vss  nch w = 2u l = 2u m = 1
Mo2  io2  ggp  vss  vss  nch w = 2u l = 2u m = 1
Mo3a io1a io1a vdd  vdd  pch w = 0.6u l = 5u m = 1
Mo3  io1  io1  io1a io1a pch w = 0.6u l = 5u m = 1
Mo4a io2a io1a vdd  vdd  pch w = 0.6u l = 5u m = 1
Mo4  io2  io1  io2a io2a pch w = 0.6u l = 5u m = 1
Xgmx1  vdd vss inp bd ggp idp sdp gmx
Xgmx2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*Cc   io1 ggn  500f        *the small fallen peak btw 10k, 100k can be slightly reduced by this
.ends
******OP: single stage******
.subckt Trx vdd vss vinp vinn 2 cz
Mb	b	cz	 vdd vdd pch W = 1u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 1u  L = 5u  m = 1
M2	2	Vinp b	 b	 pch W = 1u  L = 5u  m = 1
M3	1	1	 vss vss nch W = 1u  L = 5u  m = 1
M4	2	1	 vss vss nch W = 1u  L = 5u    m = 1
*Ro  2  vss 1000k
.ends
******OP: folded cascode*******
.subckt OP_fc vdd vss vinp vinn vop cp cp2 cn
Mb	b	cp	 vdd vdd pch W = 6u   L = 5u  m = 1
M1	1	Vinp b	 b	 pch W = 3u   L = 3u  m = 1
M2	2	Vinn b	 b	 pch W = 3u   L = 3u  m = 1
My1 von von  vdd vdd pch w = 3u   L = 5u  m = 1
My2 vop von  vdd vdd pch w = 3u   L = 5u  m = 1
M3	von cp2	 1   vss nch W = 3u   L = 3u  m = 1
M4	vop	cp2	 2   vss nch W = 3u   L = 3u  m = 1
Mz1 1	cn	 vss vss nch W = 5u   L = 3u  m = 2
Mz2	2	cn	 vss vss nch W = 5u   L = 3u  m = 2
.ends
******OP: Two stage******
.subckt Trx2 vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
*C2  1  von 1p
*Ro vop vss 20k
.ends

******current mirror******
.subckt CMB vdd vss cp cp2 cp3 cp4 cn     *cp = 2.4; cp2 = 1.25; cp3 = cn =  0.6; cp4 = 2.7
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 5.1u l = 5u     m = 1
mc1 c0  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc5 c2  cp  vdd vdd pch w = 2u   l = 5u     m = 1
mc2 cp2 cp2 c0  c0  pch w = 1u   l = 5u     m = 1
mc6 c3  cp2 c2  c2  pch w = 1u   l = 5u     m = 1
mc3 cn  cp3 cp2 cp2 pch w = 5u   l = 0.5u   m = 2
mc7 cp3 cp3 c3  c3  pch w = 5u   l = 0.5u   m = 2
mc4 cn  cn  vss vss nch w = 1u   l = 3u     m = 1
mc8 cp3 cn  vss vss nch w = 1u   l = 3u     m = 1

mca cp4 cp4 vdd vdd pch w = 5u   l = 0.5u   m = 6
mcb cp4 cn  vss vss nch w = 1u   l = 3u     m = 1
.ends

Xcmb vdd vss cz cp2 cp3 cx cn CMB

***netlist***
XTri vdd vss opb ti_in ti_out  cz  Tr rld=100k
Xgm  vdd vss gm_in gm_out gm_c  cx  gm
Xgm2  vdd vss gm_c gm_out gm_out  cx  gm
*XTro vdd vss to_in opb to_out  cz  Trx
XTro vdd vss to_in opb to_out cz cp2 cn OP_fc
*XTro vdd vss to_in opb to_out  cz  gm       *use gm as op
*XTro vdd vss opb to_in to_out cz Trx2
Cg  gm_c gnd 10p
Cg2  gm_out gnd 5p
XiEn vdd vss opb iEn_in iEn_out cx  eb iEn
veb eb gnd dc = 2.6

***NW Input Stage***
.param pbI = 1u
Ip vdd out dc = pbI
Mc  out vgn nwd vss nch w = 10u  l = 1u m = 1
vng vgn gnd dc = 1.8
.param wx = 1u
Mnw nwd vnw vss vsn nch w = wx l = 0.4u m = 1
vsn vsn gnd dc = 0

vc1 out     iEn_in  dc = 0
vc2 iEn_out ti_in   dc = 0
vc3 ti_out  gm_in   dc = 0
vc4 gm_out  to_in   dc = 0
vfc to_out vnw dc = vdif



vopbias opb gnd dc = 2 *ac = 1 *180
.param
+comon		= 2
+diff		= 0
+vdif       = 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0


***Compensation***
Cc1 to_out gnd 100p


.probe dc I(mp) I(mnw) I(ip) I(mc) I(XTri.rl) lx3(mc) lv9(mc) lv9(mnw)
+ par'lx7(mc)/lx8(mc)/lx8(mnw)'

***IC***        *this help converge
.ic i(mnw)=PbI


.op

***cloase loop test***
.alter  *Inw_dc    #0
.lib 'Test.l' Inw_dc

.alter  *Inw_ac     #0
.del lib 'Test.l' Inw_dc
.lib 'Test.l' Inw_ac

.alter  *wx     #1
.del lib 'Test.l' Inw_ac
.lib 'Test.l' wx
**
.alter  *vsn(sweep v on bulk)       #2
.del lib 'Test.l' wx
.lib 'Test.l' vsn

***Single block Test***
.alter *Tri     #3
.del lib 'Test.l' vsn
.lib 'Test.l' Tri
*
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

.alter *total feedackPart(OP + Gm)
.del lib 'Test.l' Ien
.lib 'Test.l' Fd

.alter *Av part
.del lib 'Test.l' Fd
.lib 'Test.l' Av

*.alter *Tran
*.del lib 'Test.l' Ien
*.lib 'Test.l' Tran
.end
