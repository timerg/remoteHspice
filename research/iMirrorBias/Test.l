



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
    .param rr = 1x
    Vaci cn opb1 dc = 0 ac = 1
    Vopx vop mpx dc = 0

    Xib vdd vss  Opb1 mpx mpy Ibias rin = rr
    XOP1 vdd vss mpy cn vop cn cp OPnw2

    .ac dec 1000 1 1000g sweep rr dec 1 1k 1x
    .dc rr dec 100 1k 10000k
    .probe dc i(xib.mp) i(xib.rio) rdsp=par('1/(lx8(xib.mp) + lx8(xib.mn))') gmp=par('lx7(xib.mp)')  gainib=par('gmp*rdsp') par'1/lx8(xop1.mr1)'
    + lx2(xop1.mr1)
    .probe ac i(xib.rio) rdsp=par('1/(lx8(xib.mp) + lx8(xib.mn))') gmp=par('lx7(xib.mp)')  gainib=par('gmp*rdsp')

    .noise i(xib.rio) vaci

.endl


.lib IbOPtest
    .op
    XOP vdd vss vinp vinn vop cn cp OPnw2
    .param diff = 0
    vinp vinp cn dc = 'diff' ac = 1
    vinn vinn cn dc = 0
    .dc vinp -0.1 0.1 0.0001
    .probe dc par'1/lx8(xop.mr1)'
    .ac dec 1000 1 10g *sweep vinp -0.01 0.01 0.002
    *.noise v(vop2) vinp
.endl

.lib Loop
    .op
    .ac dec 1000 1 10g
    Xib vdd vss  cn mpx mpy Ibias rin = 1x
    XOP1 vdd vss mpy cn vop cn cp OPnw2
    Vopx mpx vss dc = 2.6516 ac = 1     *tt(rin, dc): (1k,  1.4490) (20k, 2.5065)(1x, 2.6516)
    *Vopx mpx vss dc =  2.7756 ac = 1     *ff(rin, dc): (1k,  1.6977) (1x, 2.7756)
    *Vopx mpx vss dc =  2.5305  ac = 1     *ss(rin, dc): (1k,  1.7878) (1x, 2.5305)
    *Vopx mpx vss dc = 2.5522  ac = 1     *fs(rin, dc): (1k,  1.8294) (1x, 2.5525)
    *Vopx mpx vss dc = 2.7508  ac = 1     *sf(rin, dc): (1k,  2.0440) (1x, 2.7508)

    .probe ac vp(vop) rdsp=par('1/(lx8(xib.mp) + lx8(xib.mn))') gmp=par('lx7(xib.mp)')
    .pz v(vop) vopx
    .meas ac ph_0db find vp(vop) when v(vop) = 1          * r = ph
    .meas ac ph_start find vp(vop) at = 1    * r = 180 || 0
    .meas ac pM param = 'ph_0db - (ph_start - 180)'      *r = f
.endl








*
