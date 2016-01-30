*inputStage
.protect
.lib 'mm0355v.l' TT
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2

***iEnlarge******
.subckt iEn vdd vss vinn vinp vout cz eb
Mb	b	cz	 vdd vdd pch W = 12u  L = 5u  m = 1
M1	von	Vinp b	 b	 pch W = 6u   L = 5u  m = 1
M2	vop	Vinn b	 b	 pch W = 6u   L = 5u  m = 1
M3	von	von	 vss vss nch W = 3u   L = 5u  m = 1
M4	vop	von	 vss vss nch W = 3u   L = 5u    m = 1

Me1b vinp eb vdd vdd pch w = 10u l = 0.4u
Me2b vout eb vdd vdd pch w = 10u l = 0.4u m = 10
Me1 vinp vop vss vss nch w = 2u l = 0.4u            *decide by noise:
Me2 vout vop vss vss nch w = 2u l = 0.4u m = 10    *Id ~45n, In~0.8n
*Rc  xx   vop 100k
Cc  vinp vop  1p
*Ct  vout gnd 300f
.ends
******current mirror******
Ic  cp vss dc = 500n
mc0 cp cp vdd vdd pch w = 5u l = 0.4u m = 7
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3
mcx  cz cz vdd vdd pch w = 1u l = 1u m = 1
mcz  cz cn vss vss nch w = 10u l = 1u m = 3


***netlist***
Mp  out vgp vdd vdd pch w = 2u l = 1u m = 1
vpg vgp gnd dc = 2.42       * 1.178u
Mc  out vgn nwd vss nch w = 3u  l = 0.4u m = 1
vng vgn gnd dc = 1.8
Mnw nwd vnw vss vss nch w = 6.6u l = 0.4u m = 1
vnw vnw gnd dc = 0.52v ac = 1

XiEn vdd vss opb out iE_out cz vgp iEn

Eout iE_out gnd OPAMP opb iE_out



vopbias opb gnd dc = 'comon+diff' *ac = 1 *180
.param
+comon		= 2
+diff		= 0
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
*Vns vsn gnd dc = 1

Ins nwd gnd dc = 1u
*1.178u

***Output Stage**





.op

*.dc vpg 3.3 2 0.01
.dc ins dec 1000 1n 1u
.probe dc i(eout) i(mnw) i(mp)
*.plot dc i(eout)
.ac dec 1000 1 1g
.probe ac i(eout) i(mnw) i(mp)

.end
