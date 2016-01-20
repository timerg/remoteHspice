*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

.param wp = 20u

Mp  out vgp vdd vdd pch w = 2u l = 1u m = 1
Mcg out vgn nwd vss nch w = 3u  l = 0.4u m = 1

Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
vpg vgp gnd dc = 2.42       * 1.178u
*Vns vsn gnd dc = 1
vng vgn gnd dc = 1.8

*Ins vsn gnd dc = 1u
*1.178u
vn vnw gnd dc = 0.52v ac = 0.01
Mnw nwd vnw vss vss nch w = 6.6u l = 0.4u m = 1

***Output Stage***
*Eo out gnd OPAMP ref out
*vr ref gnd dc = 2v


Mt vdt vgt vst vst pch w = 2u l = 1u m = 1
vtd vdt gnd dc = 2
vtg vgt gnd dc = 2.42
vts vst gnd dc = 3.3
 *Pmos Channel length small will get smaller rdsP.  the slope fro Vds_I will increase

.op

*.dc Ins dec 100 10n 100u
*.dc vpg  3.3 2 0.01
.dc vtg 3.3 2 0.01
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdp)-v(vgp)') I(mt) I(mp) I(mn)
+ gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)*lx8(mn)')
.print dc gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)/lx8(mn)')
*.meas dc rdsVal FIND par('1/lx8(mp)') WHEN v(vgp)=2.5
*.meas dc IVal FIND par('-I(mp)') WHEN v(vgp)=2.5
.ac dec 1000 10 10k
.noise i(mp) vn
.end
