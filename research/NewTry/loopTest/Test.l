
.lib all            *0
    vfc to_out vnw dc = 0 *ac = 1 *sin(1.5 0.1 1k 1ns)
    *.ac wx 0.4u 20u 0.1u
    *.noise
    .param ins_ = 0
    inw vdd nwd dc = ins_ ac = 1
    .dc ins_ dec 1000 100n 3u
    .ac dec 1000 1 1g
    .pz v(ti_out) vfc
    ***TEST***
    Mt vdt vgt vst vst nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI-ins_'
    vtg vgt gnd dc = 0.7
    vtd vdt gnd dc = 1.2v
    .probe dc lx2(mt) i(mt)
.endl

.lib vnw            *1
    .dc vfc 0.2 1 0.01
    .ac dec 1000 1 1g
    *.pz v(to_out) vfc
    *Cc nwd gnd 10p
    vfc vnw gnd dc = 0.6 ac = 1       * this value should be traced by .alter1
    .probe ac vp(to_out)
.endl

.lib Tri_in         *2
    .dc Inw dec 1000 10n 1u
    .ac dec 1000 1 1g
    vc2 in  ti_in dc = 0
    vfc to_out vnw dc = 0
    inw vdd in     dc = 0  ac = 1
    *Rin in  vdd 1000x              * this will equal to gmroro
    Eo  ro  gnd OPAMP opb ro
    Ro  iEn_out ro 20             * ths will euqal to Rl_tr/Av = 20k/1000
    .probe i(Eo)
.endl

.lib gm_in          *3
    .dc vc3 1.6 2.4 0.01
    .ac dec 1000 1 1g
    vc3 gm_in gnd dc = 1.987 ac = 1
    .probe ac vp(ti_out)
    .pz v(ti_out) vc3
.endl

.lib to_in
    .dc vc4 1 3 0.01
    .ac dec 1000 1 1g
    vc4 to_in gnd dc = 2 ac = 1
    .probe ac vp(gm_out)
.endl

.lib out
    .dc Inw dec 1000 10n 1u
    .ac dec 1000 1 1g
    vc1 in iEn_in dc = 0
    inw vdd in dc = 100n  ac = 1
    Rin in vdd 10x
    Eo  ro  gnd OPAMP opb ro
    Ro  out ro 20             * ths should cal latter
    .probe i(Eo)
.endl
