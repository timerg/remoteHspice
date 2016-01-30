*MyGm
.protect
.lib 'mm0355v.l' TT DIO
.unprotect
*.options ABSTOL=1e-7 RELTOL=1e-7
*+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 CONVERGE=1
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2
***netlist***


*******SUBCKT************
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch  w = 2u    l = 2u m = 1
Min id  id  sd  in  pch w = 6u    l = 2u m = 1
Mn  id  gg  vss vss nch w = 5u    l = 5u m = 1
.ends

*******Circuits**********
.param wb = 5u
Mb  bd  vb  vdd vdd pch w = wb l = 1u   m = 1
X1  vdd vss inp bd ggp idp sdp gmx
X2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*******ActiveLinearization*******
*Ma1 sdn inp sdp sdp pch w = 1u l = 10u m = 1
*Ma2 sdp inn sdn sdn pch w = 1u l = 10u m = 1
*******Bump Circuit*******
*Mb1  bump  sdn    x      x      pch    w = 1u    l = 0.8u m = 10
*Mb2  vss   sdp    bump   bump   pch    w = 1u    l = 0.8u m = 10
*Vx bd x dc = 0
********
*Mb1  bd   ggp  bump vss nch w = 3.1u l = 0.4u m = 4   *slightly adjust bump centerization
*Mb2  bump ggn  vss  vss  nch w = 6u l = 0.4u m = 4

******Second Stage*****
Mo3a io1 io1 vdd vdd pch w = 5.2u l = 5u m = 1
Mo4a io2 io1 vdd vdd pch w = 5.2u l = 5u m = 1
Mo1  io1 ggp vss vss nch w = 5.2u l = 1u m = 1
Mo2  io2 ggn vss vss nch w = 5.2u l = 1u m = 1
E1  io2 gnd OPAMP ref io2
Vr ref gnd dc = 2
*******Output Load**************
*E1 out gnd OPAMP ref io2 100
*Vr ref gnd dc = 2
*RL io2 out 20k

*******Input******************
.param diff = 0 cm = 2
Vinp inp  gnd dc = 'cm-diff'  ac=1
Vinn inn  gnd dc = 'cm+diff'

********Bias**************
Vbias   vb  gnd dc = 2.4
*Vbias2  vb2 gnd dc = 1.4
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0

***diode test***
*D1 a b nw_dio
*va a gnd dc = 1
*vb b gnd dc = 0
*
*.MODEL PDIO D (                                     LEVEL  = 3
*+ IS     = 2.65E-6         RS     = 1.7E-7          N      = 1.23
*+ BV     = 9               IBV    = 0.03            IK     = 1E20
*+ IKR    = 1E10            JSW    = 1.05E-11        AREA   = 7.5E-8
*+ PJ     = 1.1E-3          CJ     = 1.38871E-3      PB     = 1.0864354
*+ MJ     = 0.6008857       CJSW   = 3.86159E-10     PHP    = 1.0864354
*+ MJSW   = 0.4471985       TLEV   = 1               EG     = 1.17
*+ XTI    = 3               TCV    = -1.01E-3        TRS    = 1E-3
*+ TLEVC  = 1               CTA    = 9.175825E-4     CTP    = 1.162482E-3
*+ TPB    = 1.249266E-3     TPHP   = 3.6054E-4       TREF   = 25
*+ FC     = 0               FCS    = 0             )
*.MODEL NW_DIO D (                                   LEVEL  = 3
*+ IS     = 1.2E-5          RS     = 1.8E-7          N      = 1.35
*+ BV     = 22              IBV    = 0.03            IK     = 1E20
*+ IKR    = 1E10            JSW    = 2.554E-11       ARwv --wvEA   = 7.6104E-8
*+ PJ     = 1.108E-3        CJ     = 1.02413E-4      PB     = 0.5540683
*+ MJ     = 0.3574083       CJSW   = 4.84677E-10     PHP    = 0.5540683
*+ MJSW   = 0.2837341       TLEV   = 1               EG     = 1.17
*+ XTI    = 3               TCV    = 8E-5            TRS    = 1.12E-3
*+ TLEVC  = 1               CTA    = 3.029206E-3     CTP    = 1.740045E-3
*+ TPB    = 3.002617E-3     TPHP   = 2.419203E-3     TREF   = 25
*+ FC     = 0               FCS    = 0           )

*******
.op
*.dc va -2 2 0.01
.dc diff -1 1 0.01 *sweep vr 1.8 2.2 0.2
.probe dc I(e1) I(rl) I(mb)
+ Idiff = par('I(X1.mn)-I(X2.mn)') vdiff = par('v(ggp)-v(ggn)') I(mb1)
*+ I(mo1) I(mo2) I(mo3) I(mo4) I(x1.mn) I(x2.mn)
*.print dc I(x1.mn) I(x2.mn) I(mb1)
.meas dc diout_0 DERIVATIVE i(e1) AT 0
.meas dc diout_0.4 DERIVATIVE i(e1) AT 0.4
.meas dc diout_0.5 DERIVATIVE i(e1) AT 0.5
.ac dec 1000 1 1g
.probe ac I(e1)
.noise I(e1) vinp 1000
.meas ac noiset find onoise at 10
.end
