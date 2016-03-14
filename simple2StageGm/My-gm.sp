*MyGm
.protect
.lib 'mm0355v.l' tt DIO
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1
***netlist***

*******SUBCKT************
.subckt gm  vdd vss inp inn io2 io1 ggp ggn sdp sdn vb Cc = 0
.subckt gmx vdd vss in bd gg id sd
Ms  sd  sd  bd  bd  pch w = 2u    l = 1u m = 2
Min id  id  sd  in  pch w = 2u    l = 1u m = 2
Mn  id  gg  vss vss nch w = 2u    l = 1u m = 2
.ends
*******Circuits**********
*Mb  bd  vb  vdd vdd pch w = 3u l = 10u   m = 1
Mbx 1   vb  vdd vdd pch w = 6u l = 8u   m = 1
Mby 2   vb  1   1   pch w = 6u l = 8u   m = 1
Mbz bd  vb  2   2   pch w = 6u l = 8u   m = 1

X1  vdd vss inp bd ggp idp sdp gmx
X2  vdd vss inn bd ggn idn sdn gmx
V0  idp ggp dc = 0
V1  idn ggn dc = 0
********Bump*********
Mb1  bd   ggp  bump vss  nch w = 8u l = 0.5u m = 2   *slightly adjust bump centerization
Mb2  bump ggn  vss  vss  nch w = 5u l = 0.5u m = 2    *lowering Length to lower vth. i guess this help to release vds supression
******Second Stage*****
Mo1  io1  sdp  vss  vss  nch w = 5u l = 0.5u m = 2
Mo2  io2  sdn  vss  vss  nch w = 5u l = 0.5u m = 2
*Mo3  io1a io1a vdd  vdd  pch w = 0.6u l = 6u m = 1
*Mo3a io1b io1b io1a io1a pch w = 0.6u l = 6u m = 1
*Mo3b io1  io1  io1b io1b pch w = 0.6u l = 6u m = 1
*Mo4  io2a io1a vdd  vdd  pch w = 0.6u l = 6u m = 1
*Mo4a io2b io1b io2a io2a pch w = 0.6u l = 6u m = 1
*Mo4b io2  io1  io2b io2b pch w = 0.6u l = 6u m = 1
Mo3  1a  io1 vdd  vdd  pch w = 1u l = 2u m = 1
Mo3a 1b  io1 1a   1a   pch w = 1u l = 2u m = 1
Mo3b io1 io1 1b   1b   pch w = 1u l = 2u m = 1
Mo4  2a  io1 vdd  vdd  pch w = 1u l = 2u m = 1
Mo4a 2b  io1 2a   2a   pch w = 1u l = 2u m = 1
Mo4b io2 io1 2b   2b   pch w = 1u l = 2u m = 1

*Cc   io1 gnd  500f        *the small fallen peak btw 10k, 100k can be slightly reduced by this
*Rc   ggn xx  1k
.ends

Xgm vdd vss inp inn io2 io1 ggp ggn sdp sdn vb gm cc = 500f

*******Output Load**************
*E1 idn gnd OPAMP ref idn
*Vr ref gnd dc = 0.383
*RL idn gnd 5k


*******Input******************
.param diff = 0 cm = 1
Vinp inp  vss dc = 'cm-diff'   ac = 1
Vinn inn  vss dc = 'cm+diff'

********Bias**************
Vbias   vb  gnd dc = 2.701
*Vbias2  vb2 gnd dc = 1.4
Vd      vdd gnd dc = 3.3
vs      vss gnd dc = 0



*******

.alter
.lib 'Test.l' Open

.alter   *use gm as low pass filter
.del lib 'Test.l' Open
.lib 'Test.l' Lp
*
*.alter
*.del lib 'Test.l' Lp
*.lib 'Test.l' twoStageLp

.alter
.del lib 'Test.l' Lp
.lib 'Test.l' Vv

*.alter
*.del lib 'Test.l' twoStageLp
*.lib 'Test.l' Diode

.end
