*Drain Source Conductance
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

.param wp = 10u
+ lp = 0.4u
+ wn = 3u
+ ln = 0.4u
Mp vdp vgp vsp vsp pch w = wp l = lp m = 1
Mn vdn vgn vsn vsn nch w = wn l = ln m = 1

Vps vsp gnd dc = 3.3
Vpd vdp gnd dc = 1.3
vpg vgp gnd dc = 0.7
Vns vsn gnd dc = 0
Vnd vdn gnd dc = 1
vng vgn gnd dc = 0.7

Mt vdt vgt vst vst pch w = wp l = lp m = 1

Vts vst gnd dc = 0
Vtd vdt gnd dc = 1
vtg vgt gnd dc = 0.8

***

.op

.dc vtd 2 0 0.01
*sweep vs 0.5v 1.4v 0.3v
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdp)-v(vgp)') I(mt) I(mp) I(mn)
*.print dc par('1/lx8(mp)') par('-I(mp)')
.end
