
.lib ins
    vfc to_out vnw dc = 1.5
    .param ins_ = 0
    ins nwd vss dc = ins_  ac = 1
    .dc ins_ dec 1000 100n 10u
    .ac dec 1000 1 1g

    Mt vdt vgt vst vst nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI-ins_'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1.5
    .probe  lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)'
.endl

.lib wx
    Ip vdd vss dc = pbI
    Mp  out vgp vdd vdd pch w = 5u l = 1u m = 1
    vpg vgp gnd dc = 2.3      * 1.178u
    vfc to_out vnw dc = 1.5 ac = 1
    .dc wx 0.4u 20u 0.1u
    .ac dec 1000 1 1g

    Mt vdt vgt vst vst nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1.5
    .probe  lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)'
.endl

.lib  vsn
    vfc to_out vnw dc = 1.5
    .param vsn_ = 0
    vsn vsn gnd dc = vsn_  sin(0 0.1 10k 1ns) ac = 1
    .dc vsn -2 2 0.01
    .ac dec 1000 1 1g

    Mt vdt vgt vst vsnt nch w = wx l = 0.4u m = 1
    It vst vss dc = 'pbI'
    vtg vgt gnd dc = 1
    vtd vdt gnd dc = 1.5
    vsnt vsnt vst dc = vsn_
    .probe  lx2(mt) par'lx7(mc)/lx8(mc)/lx8(mnw)'
.endl

.lib Tri
    XTri vdd vss opb ti_in ti_out  cz  Tr rld=20k
    vc2 ti_in inx dc = 0
    vc3 gm_in gnd dc = 0
    .param ins_ = 0
    ins inx vss dc = ins_ ac = 1
    Rin inx gnd 100x
    .dc ins_ dec 1000 100n 10u
    .ac dec 1000 1 1g
.endl

.lib GMC
    Xgm  vdd vss gm_in gm_out gm_out  cz  gm
    vc3 gm_in gnd dc = 'comon' ac = 1
    .dc vc3 1 3 0.01
    .ac dec 1000 1 1g
.endl

.lib InS
    XTri vdd vss opb ti_in ti_out  cz  Tr rld=20k
    vnw vnw gnd dc = 0.63v ac = 1 sin(0.63 0.01 1k 1ns)
    vc1 iEn_in  gnd dc = 0
    vc2 ti_in   out dc = 0
    vc3 gm_in   gnd dc = 0
    .dc vnw 0.3 1.3 0.01
    .ac dec 1000 1 1g
.endl

.lib OPout
    XTro vdd vss opb to_in to_out  cz  gm
    vc4 to_in gnd dc = 2 ac = 1
    .dc vc4 0.2 3 0.01
    .ac dec 1000 1 1g
.endl

.lib Ien
    XiEn vdd vss opb   iEn_in iEn_out cz  eb iEn
    vc2 iEn_in inx dc = 0
    .param ins_ = 0
    ins inx vss dc = ins_ ac = 1
    Rin inx gnd 100x
    Ro  iEn_out outx 20k
    Eo  outx gnd OPAMP opb outx
.endl

.lib Tran
    .tran 1us 5ms
    .ic i(mnw) = pbI
    .probe tran I(ins) I(mnw) I(ip)
    .ic v(vnw) = 0.5
    .meas tran out_max max v(ti_out)
    .meas tran out_min min v(ti_out)
    .meas tran amp param = '(out_max - out_min)/2'
.endl