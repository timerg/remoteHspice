*inputStage
*About convergence https://www.ee.iitb.ac.in/~trivedi/Downloads/spice/convergence.html
.protect
.lib 'mm0355v.l' tt
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7 unwrap = 1
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2  *CONVERGE=1  *dcon=1 * gmindc=1.000E-10

***subckt***
******iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch   W = 10u  L = 3u   m = 1
M1	von	Vinp b	 b	 pch   W = 5u   L = 3u   m = 3
M2	vop	Vinn b	 b	 pch   W = 5u   L = 3u   m = 3
M3	von	von	 vss vss nch   W = 1u   L = 3u   m = 1
M4	vop	von	 vss vss nch   W = 1u   L = 3u   m = 1

Me1p vinp eb vdd vdd pch   w = 10u l = 0.4u
Me2p vout eb vdd vdd pch   w = 10u l = 0.4u m = 10
Me1n vinp vop vss vss nch  w = 2u l = 1u
Me2n vout vop vss vss nch  w = 2u l = 1u m = 10

Cc  vop xx 20p
R1  xx vss 10k
.ends
****Tr******
.subckt Tr vdd vss vinp vinn vop cz rld=50k
Mb	b	cz	 vdd vdd pch W = 1.5u  L = 1u  m = 2
M1	1	Vinn b	 b	 pch W = 3u   L = 1u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 1u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 1u  m = 1
M4	2	1	 vss vss nch W = 3u L = 1u    m = 1
ma1 vop cz vdd vdd pch   W = 1.5u L = 1u m = 24
ma2 vop 2  vss vss nch   W = 12u L = 0.4u m = 3
Cc  xx  vop 150f
Rc  2   xx  20k
RL   vop    vinn rld
.ends
******GM******
.subckt gm vdd vss inp inn io2  vb
Mbx 1   vb  vdd vdd pch w = 6u l = 8u   m = 1
Mby 2   vb  1   1   pch w = 6u l = 8u   m = 1
Mbz bd  vb  2   2   pch w = 6u l = 8u   m = 1
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd  bd  bd  pch w = 2u    l = 1u m = 2
Min id  id  sd  in  pch w = 2u    l = 1u m = 2
Mn  id  gg  vss vss nch w = 2u    l = 1u m = 2
.ends
Mb1  bd   ggp  bump vss  nch w = 8u l = 0.5u m = 2
Mb2  bump ggn  vss  vss  nch w = 5u l = 0.5u m = 2
Mo1  io1  ggn  vss  vss  nch w = 5u l = 0.5u m = 2
Mo2  io2  ggp  vss  vss  nch w = 5u l = 0.5u m = 2
Mo3  1a  io1 vdd  vdd  pch w = 1u l = 2u m = 1
Mo3a 1b  io1 1a   1a   pch w = 1u l = 2u m = 1
Mo3b io1 io1 1b   1b   pch w = 1u l = 2u m = 1
Mo4  2a  io1 vdd  vdd  pch w = 1u l = 2u m = 1
Mo4a 2b  io1 2a   2a   pch w = 1u l = 2u m = 1
Mo4b io2 io1 2b   2b   pch w = 1u l = 2u m = 1

Xgmx1  vdd vss inp bd ggp idp sdp gmx
Xgmx2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*Cc   io1 ggn  500f        *the small fallen peak btw 10k, 100k can be slightly reduced by this
.ends
******OP: Buffer******
.subckt TrB vdd vss vinn vinp 2 cz
Mb	b	cz	 vdd vdd pch W = 2u  L = 0.5u  m = 1
M1	1	Vinn b	 b	 pch W = 2u   L = 0.5u  m = 2
M2	2	Vinp b	 b	 pch W = 2u   L = 0.5u  m = 2
M3	1	1	 vss vss nch W = 2u   L = 0.5u  m = 1
M4	2	1	 vss vss nch W = 2u   L = 0.5u  m = 1
*ma1 vop cz vdd vdd pch   W = 1.5u L = 1u m = 2
*ma2 vop 2  vss vss nch   W = 3u L = 0.4u m = 1
*Cc  vop 2 200f
*Rc vop   xx  100k
*C1 1 vop 50f

*Rc vop xx 70k
.ends
******OP: folded cascode*******

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
Cp vop vss 2p
.ends


.subckt CMB_bete5 vdd vss cp cn wp = 5u
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1
.ends
Xcmb   vdd vss cp opb0 CMB_bete5
vb opb0 cn dc = 0
******HP*******
*.subckt HP vdd vss in out
*R1 in out 100k
*L1 out vss 1m
*.ends


***NW Input Stage***
.subckt OPnw2 vdd vss vinp vinn 2 cn2
******** bias from fd Op *******
********
M1	1	Vinp b	 vss nch W = 2u   L = 2u  m = 1
M2	2	Vinn b	 vss nch W = 2u   L = 2u  m = 1
M3	1	1	 vdd vdd pch W = 2u   L = 1u  m = 1
M4	2	1	 vdd vdd pch W = 2u   L = 1u  m = 1
Mb  b   cn2  vss vss nch w = 2u   l = 1u m = 1
C1   2   vinp 30f
Mr1  xx  rb  1   1   pch w = 1u l = 4u m = 1
Mcr1 cr1 1   vdd vdd pch W = 2u l = 1u m = 1
Mcr4 rb  rb  cr2 cr2 pch w = 1u l = 1u m = 2
Mcr5 cr2 cr2 vdd vdd pch W = 2u l = 1u m = 1
Mcr2 cr1 cr1 vss vss nch w = 1u l = 0.5u m = 1
Mcr3 rb  cr1 vss vss nch w = 1u l = 0.5u m = 1
C2   2   xx  200f
.ends
.subckt Ibias vdd vss cn mpx mpy rin = 1k
mp mpy mpx vdd vdd pch w = 5u   l =  1u
*(id, vgs, gm, rds): (10n, -0.5423, 2.363e-07, 574x); (10u, -0.9871,  7.141e-05, 1.67x)
mn mpy cn rx vss nch w = 3.5u l =  1u m = 5
r1 rx  vss rin
.ends


XTri vdd vss cn ti_in ti_out  cp  Tr rld=100k
XTro vdd vss cn to_in to_out0 cp  cn cn2 OP_fc
XTrB  vdd vss to_out0 to_out to_out cp TrB


*XOPnw2 vdd vss mpy cn mpx cn2 OPnw2
*XIb vdd vss cn mpx mpy Ibias rin = 1k




.param pbI = 10n
Ip mpx vss dc = pbI
Mpb mpx mpx vdd vdd pch w = 5u l = 1u
Mp  out mpx vdd vdd pch w = 5u l = 1u
*vpx px gnd dc = 2.735

*Inw vdd out dc = pbI

*Mc  out vgn nwd vss nch w = 10u  l = 1u m = 1
*vng vgn gnd dc = 2.5
.param wx = 20u mx = 1
Mnw  out vnw nws vsn nch w = wx l = 20u m = mx
*vws nws vss dc = 0
*vsn vsn vss dc = 0.3
vws nws vss dc = 0
vsn vsn vss dc = 1



vc1 out     ti_in  dc = 0
*vc3 ti_out  gm_in   dc = 0
vc4 ti_out  to_in   dc = 0
vfc to_out vnw dc = vdif


.param
+comon		= 0.8
+diff		= 0
+vdif       = 0
Vd vdd gnd dc = 3.3
*Vd vdd gnd pulse 0 3.3         *try pseudo trans
Vs vss gnd dc = 0



.probe dc I(mp) I(mnw) I(ip) I(XTri.rl)  lv9(mnw)

***IC***        *this help converge
*.ic i(mnw)=PbI *v(opb1) = 0.802




***cloase loop test***
*.alter  *Inw_dc    #0
*.lib 'Test.l' Inw_dc
*
*.alter  *Inw_ac     #0
*.del lib 'Test.l' Inw_dc
*.lib 'Test.l' Inw_ac
*
.alter  *wx     #1
.del lib 'Test.l' Inw_ac
.lib 'Test.l' wx
**
.alter
.del lib 'Test.l' wx
.lib 'Test.l' Loop
*
*.alter
*.del lib 'Test.l' Loop
*.lib 'Test.l' openMode
***
*.alter  *vsn(sweep v on bulk)       #2
*.del lib 'Test.l' wx
*.lib 'Test.l' vsn
*
****Single block Test***
*.alter *Tri     #3
*.del lib 'Test.l' Loop
*.lib 'Test.l' Tri
***
*.alter *GM-C        #4
*.del lib 'Test.l' Loop
*.lib 'Test.l' GMC
*
*
*.alter * inputStage     #5
*.del lib 'Test.l' GMC
*.lib 'Test.l' InS
*
*
*.alter *OPout       #6
*.del lib 'Test.l' Loop
*.lib 'Test.l' OPout
**
*.alter *iEn
*.del lib 'Test.l' Loop
*.lib 'Test.l' Ien
*
*.alter *total feedackPart(OP + Gm)
*.del lib 'Test.l' Ien
*.lib 'Test.l' Fd
*
*.alter *Av part
*.del lib 'Test.l' Fd
*.lib 'Test.l' Av
*


*
*.alter *Tran
*.del lib 'Test.l' Loop
*.lib 'Test.l' Tran

.end
