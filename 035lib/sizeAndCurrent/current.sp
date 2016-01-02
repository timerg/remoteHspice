*Current
*This is a file taht shouldn't include long ternm stored info
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

.param wp = 11u lp = 0.4u
+ wn = 11u ln = 0.4u
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(1.040, 20u/1u, 1, 1.3, 0.7)
*Mp vss vbp vdp vdp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(1.035u, 21u/1u, 1, 0.9, 0.7)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(507n, 2.9/0.4u, 1, 1.2, 0.7)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(504n, 3.2u/0.4u, 1, 1, 0.7)
*Mp vdp vbp vdp vdp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(496.8n, 2u/0.4u, 2, 0.7, 0.7)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 3  * (Id, w/l, m, vds, vgs)=(493.8n, 15u/0.4u, 3, 0.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(297n, 21u/1u, 2, 1.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(146.4n, 1.4u/0.4u, 1, , 0.2, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(145.3n, 5u/0.4u, 1, , 1.3, 0.5)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.4, 0.5)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.4, 0.5)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(1.074, 10u/0.4u, 1, , 0.2, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 1  * (Id, w/l, m, vds, vgs)=(1.028, 8u/0.4u, 1, , 0.4, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(1.93u, 10u/1u, 2, , 1.8, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(401n, 30u/1u, 2, 0.8, 0.6)
*Mp  vdp vgp vsp vsp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(407.1n, 31u/1u, 2, 0.7, 0.6)
Mp  1   1 vsp vsp pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(209.9n, 10u/0.4u, 1, 1.2, 0.6)
Mp2  vgp vgp 1   1 pch w = wp l = lp m = 2  * (Id, w/l, m, vds, vgs)=(209.9n, 10u/0.4u, 1, 1.2, 0.6)


*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 2  * (Id, w/l, m, vds, vgs)=(495.2n, 2.7u/0.4u, 2, 0.5, 0.5)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 1  * (Id, w/l, m, vds, vgs)=(147.4n, 1.6u/0.4u, 1, 0.4, 0.4)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 1  * (Id, w/l, m, vds, vgs)=(147.4n, 1.6u/0.4u, 1, 0.4, 0.4)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 6  * (Id, w/l, m, vds, vgs)=(590.3, 1.1u/0.4u, 6, 0.6, 0.6)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 4  * (Id, w/l, m, vds, vgs)=(606.6, 1.6u/0.5u, 4, 0.4, 0.4)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 1  * (Id, w/l, m, vds, vgs)=(987.2n, 12u/0.4u, 2, 0.47, 0.47)
*Mn  vgn vgn vsn vsn nch w = wn l = ln m = 1  * (Id, w/l, m, vds, vgs)=(208.2n, 5u/0.4u, 1, 0.47, 0.47)
*Mn  vgn vgn vsn gnd nch w = 10u l = ln m = 3  * (Id, w/l, m, vds, vgs)=(208.2n, 5u/0.4u, 1, 0.47, 0.47)

Mn  vdn vgn gnd gnd nch w = 1.2u l = ln m = 1  * (Id, w/l, m, vds, vgs)=(87, 1.2u/0.4u, 1, 2.2, 0.4645)

Vpd vdp gnd dc = 2.2
Vps vsp gnd dc = 3.3
vpg vgp gnd dc = 2.2
Vnd vdn gnd dc = 2.2
Vns vsn gnd dc = 0
vng vgn gnd dc = 0.4645

***
.op
.dc wp 0.4u 3u 0.1u
.probe dc par('1/lx(mp)') par('-I(mp)') par('v(vdd)-v(vbp)') I(mn) i(mp)
*.print dc par('1/lx(mp)') par('-I(mp)')
.end

*Mn  vgn vgn vsn gnd nch w = 10u l = ln m = 3  * (Id, w/l, m, vds, vgs)=(208.2n, 5u/0.4u, 1, 0.47, 0.47)
