
.lib NoIb
    *.op
    .dc wp 1u 20u 0.1u  *sweep rr dec 5 10k 100k
    .ac dec 1000 1 10g
    .probe dc I(Xcmb_d.m1) I(Xcmb_d.m2)
    vd		vdd 	gnd dc supplyp ac = 1
.endl


.lib Closed
    .op
    .ac dec 1000 1 10g
    Xib vdd vss  opb1 mpx mpy Ibias rin = 1k
    XOP1 vdd vss mpy opb1 1 vop opb1 OPnw2
    Vaci 4 opb1 dc = 0 ac = 1
    Vopx vop mpx dc = 0
    .noise v(mpx) vaci

.endl

.lib Loop
    .op
    .ac dec 1000 1 10g
    Xib vdd vss  opb1 mpx mpy Ibias rin = 1k
    XOP1 vdd vss mpy opb1 1 vop opb1 OPnw2
    Vaci 4 opb1 dc = 0
    Vopx mpx vss dc = 1.9216 ac = 1     *tt(rin, dc): (1k,  1.9216) (10x, 2.7065)
    *Vopx mpx vss dc = 2.073  ac = 1     *ff(rin, dc): (1k,  2.073)
    *Vopx mpx vss dc = 1.7390  ac = 1     *ss(rin, dc): (1k,  1.7390)
    *Vopx mpx vss dc = 2.0248  ac = 1     *sf(rin, dc): (1k,  2.0248)

    .probe ac vp(vop)
    .pz v(vop) vopx
.endl

.lib IbOPtest
    XOP2 vdd vss vinp vinn 1 vop2 opb1 OPnw2
    Vaci 4 opb1 dc = 0
    vinp vinp vss dc = 0.802 ac = 1
    vinn vinn vss dc = 0.802
    .dc vinp 0.6 1 0.0001
    .noise v(vop2) vinp
.endl






*