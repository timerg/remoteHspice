*inputStage
.protect
.lib 'mm0355v.l' sf
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2
***netlist***

.param wp = 20u

*Mp  out vgp vdd vdd pch w = 6u l = 1u m = 1
*Mcg out vgn nwd vss nch w = 3u  l = 0.4u m = 1
*
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
**vpg vgp gnd dc = 2.42       * 1.178u
*
*vng vgn gnd dc = 1.8
*vpg vgp gnd dc = 2.3
*
*vn vnw gnd dc = 0.537v ac = 1
*Mnw nwd vnw vss vss nch w = 1u l = 0.4u m = 1
*
****Output Stage***
*Eo xx gnd OPAMP ref xx
*vr ref gnd dc = 2v
*Ro out xx 20


mp  out out vdd vdd pch w = 1u l = 0.5u m = 4
mn  out cn2 rx2  gnd nch w = 5u l = 0.5u m = 4
rx rx2 gnd rr
.param rr = 1k
mpb eo out vdd vdd pch w = 1u l = 0.5u m = 1
Eo eo gnd OPAMP cn eo
vcn  cn gnd dc = 0.797
vcn2 cn2 gnd dc = 0.797

.op
.dc rr dec 10 100 10x
.probe i(mp) i(mpb)
**.dc vpg 3.3 2 0.01
*.dc vn 0 0.8 0.001
*.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdp)-v(vgp)') I(mt) I(mp) I(mn)
*+ gmn=lx7(mn) rdsn=lx8(mn) gmrdn=par('lx7(mn)*lx8(mn)')
**.print dc i(mp) rdsp=lx8(mp)
**.print dc i(mcg) gmn=lx7(mcg) rdsn=lx8(mcg) gmrdn=par('lx7(mcg)/lx8(mcg)')
**.meas dc rdsVal FIND par('1/lx8(mp)') WHEN v(vgp)=2.5
**.meas dc IVal FIND par('-I(mp)') WHEN v(vgp)=2.5
*.ac dec 1000 1 1g
*.probe ac i(eo)
**.noise i(eo) vn
*.pz v(out) vn
.end
