*Test for Gm

.lib Open
    *.dc va -2 2 0.01
    .dc diff -1 1 0.01 *sweep cm 1 2 0.2
    .probe dc I(e1) I(rl) I(mb) lx7(Xgm.X1.Min) lx7(Xgm.X2.Min) I(Xgm.X1.Min)
    *+ Idiff = par('I(Xgm.X1.mn)-I(Xgm.X2.mn)') vdiff = par('v(ggp)-v(ggn)') I(mb1)
    *+ I(mo1) I(mo2) I(mo3) I(mo4) I(x1.mn) I(x2.mn)
    *.print dc I(x1.mn) I(x2.mn) I(mb1)
    .meas dc Gm_val DERIVATIVE i(e1) at  0
.endl

.lib Lp
    .dc diff -2 2 0.01
    .ac dec 1000 1 1g sweep diff -0.2 0.2 0.1

    Vinn inn  io2 dc = 0
    Cl1 io2 gnd 10p
    E1  gnd gnd OPAMP gnd gnd
    *Vr ref gnd dc = 2
    .probe dc lv18(x2.min) lv19(x2.min)
    .meas ac noiset find onoise at 10
    .probe ac i(cl)
    .noise v(io2) vinp
    .pz v(io2) vinp
.endl

.lib twoStageLp
    .dc diff -1 1 0.01
    .ac dec 1000 1 1g sweep diff -0.2 0.2 0.1
    Xgm vdd vss inp io22 io2 io1 ggp ggn vb gm cc = 500f
    Xgm2 vdd vss io2 io22 io22 io12 ggp2 ggn2 vb gm cc = 500f
    E1  gnd gnd OPAMP gnd gnd
    Cl1 io2 gnd 10p
    Cl2  io22 gnd 5p
    .pz v(io22) vinp
    .probe ac vp(io22)
.endl

.lib Diode
    ****diode test***
    *D1 a b nw_dio
    *va a gnd dc = 1
    *vb b gnd dc = 0
    **
    **.MODEL PDIO D (                                     LEVEL  = 3
    **+ IS     = 2.65E-6         RS     = 1.7E-7          N      = 1.23
    **+ BV     = 9               IBV    = 0.03            IK     = 1E20
    **+ IKR    = 1E10            JSW    = 1.05E-11        AREA   = 7.5E-8
    **+ PJ     = 1.1E-3          CJ     = 1.38871E-3      PB     = 1.0864354
    **+ MJ     = 0.6008857       CJSW   = 3.86159E-10     PHP    = 1.0864354
    **+ MJSW   = 0.4471985       TLEV   = 1               EG     = 1.17
    **+ XTI    = 3               TCV    = -1.01E-3        TRS    = 1E-3
    **+ TLEVC  = 1               CTA    = 9.175825E-4     CTP    = 1.162482E-3
    **+ TPB    = 1.249266E-3     TPHP   = 3.6054E-4       TREF   = 25
    **+ FC     = 0               FCS    = 0             )
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
    *.dc va -1 1 0.01
    *.probe dc I(d1)
.endl
