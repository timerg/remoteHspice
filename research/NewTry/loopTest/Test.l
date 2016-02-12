
.lib all
inw nwd vss dc = ins
.dc ins dec 1000 100n 3u
.ac dec 1000 1 1g
.endl

.lib vnw
.dc vfc 0.2 1 0.01
.ac dec 1000 1 1g
*.pz v(to_out) vfc
*Cc nwd gnd 10p
.probe ac vp(to_out)
.endl

.lib out
.dc Inw dec 1000 10n 1u
.ac dec 1000 1 1g
inw vdd in dc = 100n  ac = 1
Rin in gnd 10x              * this will equal to gmroro
Eo  ro gnd OPAMP opb ro
Rout out ro 20             * ths will euqal to Rl_tr/Av = 20k/1000
.probe i(Eo)
.endl

.lib gm_in
.dc vc3 1.6 2.4 0.01
.ac dec 1000 1 1g
.probe ac vp(ti_out)
.pz v(ti_out) vc3
.endl

.lib to_in
.dc vc4 1 3 0.01
.ac dec 1000 1 1g
.probe ac vp(gm_out)
.endl
