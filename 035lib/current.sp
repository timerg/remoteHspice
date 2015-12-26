*Current
*This is a file taht shouldn't include long ternm stored info
.protect
.lib 'mm0355v.l' FF
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

.param wx = 1.6u
+ lx = 0.5u
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(1.040, 20u/1u, 1, 1.3, 0.7)
*Mp vss vbp vdp vdp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(1.035u, 21u/1u, 1, 0.9, 0.7)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(507n, 2.9/0.4u, 1, 1.2, 0.7)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(504n, 3.2u/0.4u, 1, 1, 0.7)
*Mp vdp vbp vdp vdp pch w = wx l = lx m = 2  * (Id, w/l, m, vds, vgs)=(496.8n, 2u/0.4u, 2, 0.7, 0.7)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 3  * (Id, w/l, m, vds, vgs)=(493.8n, 15u/0.4u, 3, 0.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 2  * (Id, w/l, m, vds, vgs)=(297n, 21u/1u, 2, 1.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(146.4n, 1.4u/0.4u, 1, , 0.2, 0.6)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(145.3n, 5u/0.4u, 1, , 1.3, 0.5)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.4, 0.5)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.3, 0.6)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(148.7n, 4.7u/0.4u, 1, , 1.4, 0.5)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(1.074, 10u/0.4u, 1, , 0.2, 0.6)
*Mp  vdp vgp vsp vsp pch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(1.028, 8u/0.4u, 1, , 0.4, 0.6)

*Mn  vgn vgn vsn vsn nch w = wx l = lx m = 2  * (Id, w/l, m, vds, vgs)=(495.2n, 2.7u/0.4u, 2, 0.5, 0.5)
*Mn  vgn vgn vsn vsn nch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(147.4n, 1.6u/0.4u, 1, 0.4, 0.4)
*Mn  vgn vgn vsn vsn nch w = wx l = lx m = 1  * (Id, w/l, m, vds, vgs)=(147.4n, 1.6u/0.4u, 1, 0.4, 0.4)
*Mn  vgn vgn vsn vsn nch w = wx l = lx m = 6  * (Id, w/l, m, vds, vgs)=(590.3, 1.1u/0.4u, 6, 0.6, 0.6)
Mn  vgn vgn vsn vsn nch w = wx l = lx m = 4  * (Id, w/l, m, vds, vgs)=(606.6, 1.6u/0.5u, 4, 0.4, 0.4)


Vpd vdp gnd dc = 2.7
Vps vsp gnd dc = 3.1
vpg vgp gnd dc = 2.5
Vnd vdn gnd dc = 0.4
Vns vsn gnd dc = 0
vng vgn gnd dc = 0.4

***
.op
.dc wx 0.4u 3u 0.1u
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdd)-v(vbp)') I(mn) i(mp)
*.print dc par('1/lx8(mp)') par('-I(mp)')
.end
