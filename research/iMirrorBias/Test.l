
.lib NoIb
    .op
    Iin cp  vss dc = 1u *ac = 1
    .dc wp 1u 20u 0.1u  *sweep rr dec 5 10k 100k
    .ac dec 1000 1 10g
    .probe dc I(Xcmb_d.m1) I(Xcmb_d.m2)
    vd		vdd 	gnd dc supplyp ac = 1
    .probe ac outnoise
    .noise i(xcmb.mc1) vd
.endl


.lib Closed
    .op
    .ac dec 1000 1 10g
    Xib vdd vss  Opb1 mpx mpy Ibias rin = 1k
    XOP1 vdd vss mpy opb1 1 vop Opb1 OPnw2
    Vaci cn opb1 dc = 0 ac = 1
    Vopx vop mpx dc = 0
    .noise v(mpx) vaci

.endl

.lib Loop
    .op
    .ac dec 1000 1 10g
    Xib vdd vss  opb1 mpx mpy Ibias rin = 1k
    XOP1 vdd vss mpy opb1 1 vop opb1 OPnw2
    Vaci cn opb1 dc = 0
    Vopx mpx vss dc = 1.9371 ac = 1     *tt(rin, dc): (1k,  1.9371) (20k, 2.3440)
    *Vopx mpx vss dc =  2.0867 ac = 1     *ff(rin, dc): (1k,  2.0867)
    *Vopx mpx vss dc =  1.7878  ac = 1     *ss(rin, dc): (1k,  1.7878)
    *Vopx mpx vss dc = 1.8294  ac = 1     *fs(rin, dc): (1k,  1.8294)
    *Vopx mpx vss dc = 2.0440  ac = 1     *fs(rin, dc): (1k,  2.0440)

    .probe ac vp(vop)
    *.pz v(vop) vopx
    .meas ac ph_0db find vp(vop) when v(vop) = 1          * r = ph
    .meas ac ph_start find vp(vop) at = 1    * r = 180 || 0
    .meas ac pM param = 'ph_0db - (ph_start - 180)'      *r = f
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
