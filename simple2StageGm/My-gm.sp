*MyGm
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1
***netlist***

*******SUBCKT************
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch w = 15u    l = 0.4u m = 1
Min id  in  sd  sd  pch w = 25u    l = 0.4u m = 1
Mn  id  gg  vss vss nch w = 5u    l = 0.4u m = 2
.ends

*******Circuits**********
Mb  bd  vb  vdd vdd pch w = 18u l = 1u   m = 1
X1  vdd vss inp bd ggp idp sdp gmx
X2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
*******ActiveLinearization*******
*Ma1 sdn inp sdp sdp pch w = 1u l = 10u m = 1
*Ma2 sdp inn sdn sdn pch w = 1u l = 10u m = 1
*******Bump Circuit*******
*Mbp  bump  sdn    x      x      pch    w = 10u    l = 0.4u m = 1
*Mbn  vss   sdp    bump   bump   pch    w = 10u    l = 0.4u m = 1
*Vx bd x dc = 0
********
Mb1  bd   ggp  bump bump nch w = 3u l = 0.4u m = 6
Mb2  bump ggn  vss  vss  nch w = 3u l = 0.4u m = 6
Vx bd x dc = 0

******Second Stage*****
Mo1 io1 ggp vss vss nch w = 5u l = 0.4u m = 2
Mo2 io2 ggn vss vss nch w = 5u l = 0.4u m = 2
Mo3 io1 io1 vdd vdd pch w = 5u l = 0.4u m = 2
Mo4 io2 io1 vdd vdd pch w = 5u l = 0.4u m = 2
*E1  io2 gnd OPAMP ref io2
*Vr ref gnd dc = 1.65
*******Output Load**************
*E1 idn gnd OPAMP ref idn
*Vr ref gnd dc = 0.383
*RL idn gnd 5k

*******Input******************
.param diff = 0
Vinp inp  gnd dc = '1.1-diff'
Vinn inn  gnd dc = '1.1+diff'

********Bias**************
Vbias   vb  gnd dc = 2.7
*Vbias2  vb2 gnd dc = 1.4
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0

*******
.op
.dc sweep diff -0.5 0.5 0.001
.probe dc I(e1) I(rl)
+ Idiff = par('I(X1.mn)-I(X2.mn)') vdiff = par('v(ggp)-v(ggn)') I(mbp)
.end
