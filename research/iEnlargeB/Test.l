
.lib total
    Iin vinp vss dc = inI  ac = 1  sin(1u 10n 1k 1ns)
    *Rin vinp gnd 100x
    vc  vop op_out dc = 0
    .dc inI dec 100 1n 100u
    .pz i(ro) iin
    .ac dec 100 1 1g
    .probe ac i(ro) vp(vop2) vp(op_out)
    .noise i(ro) Iin
.endl

.lib stablility
    Iin vdd vinp dc = inI
    vc  vop gnd dc = 0.4795 ac = 1
    .pz v(op_out) vc
    .ac dec 100 1 1g *sweep rx 10k 100k 20k
    .probe ac i(ro) vp(vop2) vp(op_out) lx7(me1)
    *Cc  vop gnd 10p
    *Cc2 op_out gnd 10p
    .ic v(vop)=0.4795  v(vinp)=1

.endl
