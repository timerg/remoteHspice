*Drain Source Conductance
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

.param wp = 20u
+ lp = 0.4u
Mp vss vbp vdd vdd pch w = wp l = lp m = 1

Vd 	vdd	 gnd dc = 2v
Vs vss gnd dc = 1v
vIbias vbp gnd dc = 0.7v



***
.op
.dc vIbias 2v 0v 0.001 *sweep vs 0.5v 1.4v 0.3v
.probe dc par('1/lx8(mp)') par('-I(mp)') par('v(vdd)-v(vbp)')
.print dc par('1/lx8(mp)') par('-I(mp)')
.end