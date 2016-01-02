*Drain Source Conductance
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1
***netlist***

Mp vss vbp vdd vdd pch w = 30u l = 1u m = 3

Vd vdd gnd dc = 2v
Vs vss gnd dc = 1v
vIbias vbp gnd dc = 1v

* rds ox 1/vds  1/Id(monominal)



***
.op
.dc vIbias 2 0 0.01
.probe dc par('1/lx8(mp)') par('-I(mp)')
.end