*MyGm
.protect
.lib 'mm0355v.l' tt DIO
.unprotect
.protect
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
*+ IKR    = 1E10            JSW    = 2.554E-11       AREA   = 7.6104E-8
*+ PJ     = 1.108E-3        CJ     = 1.02413E-4      PB     = 0.5540683
*+ MJ     = 0.3574083       CJSW   = 4.84677E-10     PHP    = 0.5540683
*+ MJSW   = 0.2837341       TLEV   = 1               EG     = 1.17
*+ XTI    = 3               TCV    = 8E-5            TRS    = 1.12E-3
*+ TLEVC  = 1               CTA    = 3.029206E-3     CTP    = 1.740045E-3
*+ TPB    = 3.002617E-3     TPHP   = 2.419203E-3     TREF   = 25
*+ FC     = 0               FCS    = 0           )
.unprotect
*.options ABSTOL=1e-7 RELTOL=1e-7
*+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 CONVERGE=1
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2 RELTOL=1e-7
***netlist***

***SUBCKT***
.subckt gm vdd vss inp inn vb io2
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
.subckt Tr vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 5u  L = 5u  m = 1
M1	1	Vinn b	 b	 pch W = 3u   L = 5u  m = 2
M2	2	Vinp b	 b	 pch W = 3u   L = 5u  m = 2
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u L = 5u    m = 1
ma1 vop cz vdd vdd pch W = 8u L = 1u m = 2
ma2 vop 2  vss vss nch W = 17.3u L = 1u m = 2
C1  2  vop 1p
RL   vop    vinn 300k
.ends

***Cuurent Mirror***
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3
mcx  cz cz vdd vdd pch w = 1u l = 1u m = 1
mcz  cz cn vss vss nch w = 10u l = 1u m = 3

***netlist***
******Gm******
Xgm vdd vss inp inn cz io2 gm
******Tr******
XTr  vdd vss opb tr_in  tr_out  cz   Tr
*********OP_Bias*********
vopbias opb gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 2
+diff		= 0
*********connection*********
Vc tr_in io2 dc = 0


***Output Load***
*E1 out gnd OPAMP ref io2 100
*Vr ref gnd dc = 2
*RL io2 out 20k
*E1  io2 gnd OPAMP ref io2
*Vr ref gnd dc = 2



***Input***
.param diff = 0 cm = 2
Vinp inp  gnd dc = 'cm-diff'  ac=1
Vinn inn  gnd dc = 'cm+diff'

***OP TEST***
*Iin tr_in vdd 1u
*.dc Iin dec 1000 1n 10u

***Bias***
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0

***Test***
Mt vat vat vst vst pch w = 5u l = 0.4u m = 1
Mt1 vgt vgt vat vat pch w = 5u l = 0.4u m = 1
*vtd	vdt	gnd dc = 2.9
It vgt vdd dc = 6u
vts vst gnd dc = 3.3
*.dc it dec 1000 1n 10u
*.probe dc i(mt)
*******
.op
*.dc va -2 2 0.01
.dc diff -0.4 0.4 0.001 *sweep vr 1.8 2.2 0.2
.probe dc I(vc) v(tr_out)
.meas dc diout_0 DERIVATIVE i(vc) AT 0
.meas dc diout_0.4 DERIVATIVE i(vc) AT 0.4
.meas dc diout_0.5 DERIVATIVE i(vc) AT 0.5
.ac dec 1000 1 1g
.probe ac I(vc) vp(tr_out)
*.noise I() vinp 1000
.end
