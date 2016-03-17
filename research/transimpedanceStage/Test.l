

.lib OPwoload
    .op
    *vinp vinp gnd dc = 'comon-diff' *ac = 1
    vopb vinp opb1 dc = 0
    vinn vinn gnd dc = 'comon+diff' ac = 1 *180
    .dc diff -0.1 0.1 0.0001
    .ac dec 1000 0.1 100g
    *.tf v(voa) vinp
    *.pz v(vop) vinn
    .probe dc I(m1) I(m2)	I(mt)
    .probe ac vp(vop)
    +gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
    +gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
    *.meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
    *.meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
    *.meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
    *.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

    *.noise v(vop) vinn 100
.endl


.lib OPwiload
    .op
    *vinp vinp gnd dc = 'comon' *ac = 1
    vopb vinp opb1 dc = 0
    vinn in gnd dc = 'comon+diff' ac = 1 180
    Rin  in vinn 100K
    RL   vop  gnd 100K
    .ac dec 1000 0.1 100g  *sweep diff 0 2 0.5
    .dc diff -0.1 0.1 0.0001
    *.tf v(voa) vinp
    .pz v(vop) vinn
    .probe dc I(m1) I(m2)	I(mt)
    .probe ac vp(vop)
    +gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
    +gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')

    .meas ac ph_0db find vp(vop) when v(vop) = 1          * r = ph
    .meas ac ph_start find vp(vop) at = 1    * r = 180 || 0
    .meas ac pM param = 'ph_0db - (ph_start - 180)'      *r = f
    *.noise v(vop) vinn 100
.endl

.lib Cloop
    .op
    *vinp vinp gnd  dc = 'comon' *ac = 1
    vopb vinp opb1 dc = 0
    Iin  vdd vinn dc = 0 ac = 1
    *Rin  vinp vss 100g
    RL   vop    vinn 100k
    .dc Iin dec 50 1n 200u
    *.dc Iin 100n 10u 10n
    .probe i(ma1)
    .ac dec 1000 0.1 100g *sweep wx 5u 17u 3u
    *.pz v(vop) Iin
    .meas ac gain_c max v(vop)
    .meas ac bw when v(vop) = 'gain_c/1.414'
    *.noise v(vop) Iin 100
.endl