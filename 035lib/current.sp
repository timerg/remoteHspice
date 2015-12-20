*Drain Source Conductance
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

.param wp = 7.4u
+ lp = 0.4u
+ wn = 3u
+ ln = 0.4u
Mp vdp vgp vsp vsp pch w = 20u l = 0.4u m = 3
Mn vdn vgn vsn vsn nch w = wn l = ln m = 1

Vps vsp gnd dc = 3.3
Vpd vdp gnd dc = 2
vpg vgp gnd dc = 2.5
*Vns vsn gnd dc = 1
Vnd vdn gnd dc = 2
vng vgn gnd dc = 1.7

Ins vsn gnd dc = 1u
Mt vdt vgt vst vst pch w = wp l = lp m = 1
* for us Pmos Channel length small is prefered to get rdsP small.  the slope fro Vds_I will increase

*Itd vdt gnd dc = 1u
Vts vst gnd dc = 3.3
*Vtd vdt gnd dc = 2.6
vtg vgt gnd dc = 2.6

***

.op

.dc Ins dec 100 10n 100u
*.dc vpg  3.3 2 0.01
*.dc wp 1u 20u 1u
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdp)-v(vgp)') I(mt) I(mp) I(mn)
+ gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)*lx8(mn)')
.print dc gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)/lx8(mn)')
*.meas dc rdsVal FIND par('1/lx8(mp)') WHEN v(vgp)=2.5
*.meas dc IVal FIND par('-I(mp)') WHEN v(vgp)=2.5
.end
