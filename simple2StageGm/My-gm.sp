*MyGm
.protect
.lib 'mm0355v.l' TT DIO
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1
***netlist***

*******SUBCKT************
.subckt gm  vdd vss inp inn io2 io1 ggp ggn vb Cc = 0
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd bd  bd  pch w = 2u    l = 1u m = 1
Min id  id  sd  in  pch w = 1u    l = 5u m = 1
Mn  id  gg  vss vss nch w = 2u    l = 2u m = 1
.ends
*******Circuits**********
Mb  bd  vb  vdd vdd pch w = 6u l = 2u   m = 1
X1  vdd vss inp bd ggp idp sdp gmx
X2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
********Bump*********
Mb1  bd   ggp  bump vss nch w = 2.3u l = 0.6u m = 1   *slightly adjust bump centerization
Mb2  bump ggn  vss  vss  nch w = 4u l = 0.6u m = 1
******Second Stage*****
Mo1  io1  ggn  vss  vss  nch w = 2u l = 2u m = 1
Mo2  io2  ggp  vss  vss  nch w = 2u l = 2u m = 1
Mo3a io1a io1a vdd  vdd  pch w = 2u l = 2u m = 1
Mo3  io1  io1  io1a io1a pch w = 2u l = 2u m = 1
Mo4a io2a io1a vdd  vdd  pch w = 2u l = 2u m = 1
Mo4  io2  io1  io2a io2a pch w = 2u l = 2u m = 1
*Cc   io1 gnd  500f        *the small fallen peak btw 10k, 100k can be slightly reduced by this
*Rc   ggn xx  1k
.ends

Xgm vdd vss inp inn io2 io1 ggp ggn vb gm cc = 500f

*******Output Load**************
*E1 idn gnd OPAMP ref idn
*Vr ref gnd dc = 0.383
*RL idn gnd 5k
E1   io2 gnd OPAMP ref io2
Vr ref gnd dc = 2

*******Input******************
.param diff = 0 cm = 2
Vinp inp  vss dc = 'cm-diff'   ac = 1
Vinn inn  vss dc = 'cm+diff'

********Bias**************
Vbias   vb  gnd dc = 2.701
*Vbias2  vb2 gnd dc = 1.4
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0



*******
.op

.alter
.lib 'Test.l' Open

.alter   *use gm as low pass filter
.del lib 'Test.l' Open
.lib 'Test.l' Lp

.alter
.del lib 'Test.l' Lp
.lib 'Test.l' twoStageLp

*.alter
*.del lib 'Test.l' twoStageLp
*.lib 'Test.l' Diode

.end
