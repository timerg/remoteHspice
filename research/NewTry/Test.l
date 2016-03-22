
.lib inw_dc                *#0
    .op
    .param ins_ = 0
    ins nwd vss dc = ins_  ac = 1
    vfc to_out vnw dc = vdif *ac = 1
    .dc ins_ dec 10 10n 1u

    Mt vdt vgt vst vst nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI+ins_'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1.5
    .probe dc lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)' i(mt) lx7(mnw)
    .ic v(vnw) = 0.6
    *.options  gmindc=   1.000E-09

.endl

.lib inw_ac
    .op
    .param ins_ = 0
    ins vdd nwd dc = ins_  ac = 1
    vfc to_out vnw dc = vdif *ac = 1
    .ac dec 1000 1 1g *sweep ins_ dec 1 10n 10u
    *.pz v(ti_out) ins
    .probe ac i(mnw)
.endl

.lib wx             *#1
    .op
    vfc to_out vnw dc = vdif ac = 1
    .dc wx 0.4u 40u 0.4u *sweep pbI dec 1 10n 10u
    .ac dec 1000 1 10g sweep pbI dec 1 10n 10u
    Mt vdt vgt vst vst nch w = wx l = 0.5u m = mx
    It vst vss dc = 'pbI'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1
    .probe dc lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)' i(mt) lx7(mnw) lx9(mnw) par'-i(mp)' lx5(mnw) lx6(mnw)
    .probe ac out=par('v(ti_out)') lx7(mnw)
    *.ic v(gm_in) = 2 v(gm_out) = 2 v(out) = 2
    .option dcon = 1
.endl

.lib  vsn           *#2
    .op
    .ic v(vnw) = 0.6
    vfc to_out vnw dc = vdif
    .param vsn_ = 0
    vsn vsn gnd dc = vsn_  sin(0 0.1 10k 1ns) ac = 1
    .dc vsn -1 1 0.01
    .ac dec 1000 1 1g

    Mt vdt vgt vst vsnt nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1.5
    vsnt vsnt vst dc = vsn_
    .probe  lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)'
    .ic v(vnw) = 0.6
.endl

.lib Tri            *#3
    .op
    *.ic v(vnw) = 0.6
    vc1 ti_in inx dc = 0
    vc4 to_in gnd dc = 0
    .param ins_ = 0
    ins vdd inx dc = ins_ ac = 1
    Rin inx gnd 100x
    *.pz v(ti_out) ins

    .dc ins dec 1000 100n 100u
    .ac dec 1000 1 1g *sweep ins_ dec 1 100n 100u
    .probe ac out=par('v(ti_out)')
    .option dcon= 1
.endl

.lib GMC           *#4
    .op
    *Xgm  vdd vss gm_in gm_out   gm_c   cx  gm
    *Xgm2 vdd vss gm_c  gm_out gm_out cx  gm
    vc3 gm_in gnd dc = 1 ac = 1
    vc4 gnd to_in  dc = 0
    .dc vc3 0 3.3 0.01
    .ac dec 1000 1 1g *sweep vc3 1.8 2.2 0.1
    *.pz v(gm_out) vc3
    .probe ac out = par('v(gm_out)') vp(gm_out)
.endl

.lib InS            *#5
    .op
    vfc vnw gnd dc = 0.6v sin(0.63 0.01 1k 1ns)  ac = 1
    *vsn vsn gnd dc = 0 ac = 1
    .param ins_ = 0
    ins nwd vss dc = ins_  *ac = 1

    vc1 iEn_in gnd dc = 0
    Ro out ro 20
    Ex ro gnd OPAMP opb ro
    .dc ins_ dec 1000 10n 10u
    .probe dc I(ro)
    .ac dec 1000 1 1g *sweep ins_ dec 1 10n 10u
    .probe ac I(ex) lx7(mnw) out=par('I(ro)')
.endl

.lib OPout          *#6
    .op
    **XTro vdd vss to_in opb to_out cz cp2 cn OP_fc
    **XTro vdd vss to_in opb to_out  cz  Trx
    *XTro vdd vss opb to_in to_out cz Trx2
    vc4 to_in gnd dc = 0.7943 ac = 1
    vfc vss vnw dc = vdif
    .dc vc4 0 3.3 0.001
    .ac dec 1000 1 1g *sweep vc4 0.9 1.1 0.1
    .probe ac out=par('v(to_out)') vp(to_out)
.endl

.lib Ien            *#7
    .op
    .ic v(vnw) = 0.6
    veb eb gnd dc = 2.4
    vc1 iEn_in inx dc = 0
    vc2 ti_in  gnd dc = 0
    .param ins_ = 1u
    ins inx vdd dc = ins_ ac = 1
    Rin inx gnd 100x
    Ro  iEn_out outx 20
    Eo  outx gnd OPAMP opb outx
    .ac dec 1000 1 1g *sweep veb 2.8 2.4 0.2
    .dc ins_ dec 100 10n 10u
    .probe dc i(Eo)
    .probe ac i(Eo) out=par('i(ro)')
    .option post acout=0 accurate=1 dcon=1 CONVERGE=0 GMINDC=1.0000E-12 captab=1 unwrap=1
.endl

.lib Fd
    .op
    .ac dec 1000 1 1g
    vc3 gm_in gnd   dc = 2 ac = 1
    Cc1 to_out gnd 0p
    vfc vnw gnd dc = 0
.endl

.lib Av
    .op
    .ac dec 1000 1 1g
    vfc vnw gnd dc = 0.4 ac = 1
    .dc vfc 0.2 0.6 0.1
.endl

.lib Loop
    .op
    .ac  dec 1000 1 100g *sweep pbI dec 1 100n 10u
    .param pbI = 1u
    vc4  to_in  opb1 dc = 0 ac = 1
    *vb  cz vss dc = 2.3552 *ac = 1
    .probe ac vp(ti_out) lx7(mnw) lx9(mnw) vp(gm_out) vp(to_out) i(mnw)

    *.pz v(ti_out) vc3
    .ic I(mnw) = pbI
    *+ v(vnw) = 1.682e-01
    *+ v(vnw) = 2.331e-01
    *+v(vnw) = 4.014e-01
    *+ v(vnw) = 6.573e-01    *38db
    *** ff
    *
    *+ v(vnw) =  5.429e-01 *10u 38db
    *** ss
    *+ v(vnw) = 7.717e-01    *38db
    *** fs
    *+ v(vnw) = 5.550e-01    *36.7db
    *** sf
    *+ v(vnw) = 7.602e-01   *40db
    + v(vnw) = 5.025e-01    *76db


    .meas ac ph_0db find vp(ti_out) when v(ti_out) = 1          * r = ph
    .meas ac ph_start find vp(ti_out) at = 1    * r = 180 || 0
    .meas ac pM param = 'ph_0db - (ph_start - 180)'      *r = f
    .probe ac vp(to_out)
.endl

.lib Tran
    .op
    .tran 1us 5ms
    .ic i(mnw) = pbI
    .probe tran I(ins) I(mnw) I(ip)
    .ic v(vnw) = 0.5
    .meas tran out_max max v(ti_out)
    .meas tran out_min min v(ti_out)
    .meas tran amp param = '(out_max - out_min)/2'
.endl

.lib openMode
    .op
    .ac  dec 1000 1 1g *sweep pbI dec 1 100n 10u
    vfc vnw vss dc = vin ac = 1
    *vb opb0 opb1 dc = 0 ac = 1

    .param pbI = 10n
    + vin = 1.682e-01
    *+ vin = 2.331e-01
    *+ vin = 3.577e-01
    *+ vin = 6.573e-01
    *.noise v(ti_out) vfc 100
.endl
