*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2
***netlist***

.param wp = 20u

*Mp  out vgp vdd vdd pch w = 2u l = 1u m = 1
Mcg out vgn nwd vss nch w = 3u  l = 0.4u m = 1

Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
*vpg vgp gnd dc = 2.42       * 1.178u

vng vgn gnd dc = 1.8

vn vnw gnd dc = 0.52v ac = 0.01
Mnw nwd vnw vss vss nch w = 6.6u l = 0.4u m = 1

***Output Stage***
Eo out gnd OPAMP ref out
vr ref gnd dc = 2v





.op

*.dc vpg 3.3 2 0.01
.dc vn 0 0.8 0.001
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdp)-v(vgp)') I(mt) I(mp) I(mn)
+ gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)*lx8(mn)')
.print dc i(mp) rdsp=lx8(mp)
.print dc i(mcg) gmn=lx7(mcg) rdsn=lx8(mcg) gmrdn=par('lx7(mcg)/lx8(mcg)')
*.meas dc rdsVal FIND par('1/lx8(mp)') WHEN v(vgp)=2.5
*.meas dc IVal FIND par('-I(mp)') WHEN v(vgp)=2.5
*.ac dec 1000 10 10k
*.noise i(eo) vn
.end
