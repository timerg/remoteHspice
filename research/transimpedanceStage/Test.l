

.lib OPwoload
    .op
    vinp vinp gnd dc = 'comon-diff' *ac = 1
    vinn vinn gnd dc = 'comon+diff' ac = 1 *180
    .dc diff -0.1 0.1 0.0001
    .ac dec 1000 0.1 1g
    *.tf v(voa) vinp
    *.pz v(vop) vinn
    .probe dc I(m1) I(m2)	I(mt)
    .probe ac vp(vop)
    +gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
    +gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
    .meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
    .meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
    .meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
    .meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0

    *.noise v(vop) vinn 100
.endl


.lib OPwiload
    .op
    vinp vinp gnd dc = 'comon-diff' *ac = 1
    vinn in gnd dc = 'comon+diff' ac = 1 180
    Rin  in vinn 50K
    RL   vop  gnd 50K
    .ac dec 1000 0.1 1g
    .dc diff -0.1 0.1 0.0001
    *.tf v(voa) vinp
    .pz v(vop) vinn
    .probe dc I(m1) I(m2)	I(mt)
    .probe ac vp(vop)
    +gain1st=par('Vdb(2)-Vdb(vinp,vinn)')	par('I(m1)-I(m2)')	phase1st=par('vp(2)')
    +gainall=par('Vdb(vop)-Vdb(vinp,vinn)')		phaseall=par('vp(vop)')
    .meas ac gain MAX par('Vdb(vop)-Vdb(vinp,vinn)')
    .meas ac gain1st MAX par('Vdb(2, 1)-Vdb(vinp,vinn)')
    .meas ac zerodb WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
    .meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vinp,vinn)') = 0
    *.noise v(vop) vinn 100
.endl

.lib Cloop
    .op
    vinp vinp gnd  dc = 'comon' *ac = 1
    Iin  vdd vinn dc = 0 ac = 1
    *Rin  vinp vss 100g
    RL   vop    vinn 50k
    .dc Iin dec 50 1n 200u
    *.dc Iin 100n 10u 10n
    .probe i(ma1)
    .ac dec 1000 0.1 1g *sweep wx 5u 17u 3u
    .pz v(vop) Iin
    *.noise v(vop) Iin 100
.endl