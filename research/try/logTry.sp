*Try logarithm circuits
.protect
.lib '../mm0355v.l' TT DIO
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=2

***netlist***
.subckt logc vss in v2 v1 v1o out  wa = 3u
Mbi in  v2  v1  vss  nch w = wa l = 0.4u m = 5
Mai v1  v1  vss vss nch w = 3u l = 1u m = 2
Mbo out v2  v1o vss nch w = wa l = 0.4u m = 5
Mao v1o v1o vss vss nch w = 3u l = 1u m = 2
.ends

XLc1  vss in vo1 v1 v1o out logc wa = 3u
XOP1  vdd vss vinn in vo1 cz op_a
*XLc2  vss in vo2 v1 v1o out logc wa = 1u
*XOP2  vdd vss vinn in vo2 cz op_a
*XLc3  vss in vo3 v1 v1o out logc wa = 2u
*XOP3  vdd vss vinn in vo3 cz op_a
*XLc4  vss in vo4  out logc wa = 4u
*XOP4  vdd vss vinn in vo4 cz op_a
*XLc5  vss in vo5  out logc wa = 1u
*XOP5  vdd vss vinn in vo5 cz op_a
***OP***
.subckt OP_a vdd vss vinn vinp 2 cz
Mb	b	cz	 vdd vdd pch W = 12u  L = 5u  m = 1
M1	1	Vinp b	 b	 pch W = 6u   L = 5u  m = 1
M2	2	Vinn b	 b	 pch W = 6u   L = 5u  m = 1
M3	1	1	 vss vss nch W = 3u   L = 5u  m = 1
M4	2	1	 vss vss nch W = 3u   L = 5u    m = 1
.ends

Iic cp vss dc = 200n
mc0 cp cp vdd vdd pch w = 16u l = 1u m = 2
mc1 c0 cp vdd vdd pch w = 5u l = 0.4u m = 2
mc2 cn cn c0  c0  pch w = 1u l = 0.4u m = 1
mc3 cn cn vss vss nch w = 5.1u l = 0.4u m = 3
mcx  cz cz vdd vdd pch w = 1u l = 1u m = 1
mcz  cz cn vss vss nch w = 10u l = 1u m = 3


Iin vdd in dc = 100n
Eo  out gnd OPAMP ref out
vr ref gnd 2v
***
vd vdd gnd dc = 3.3
vs vss gnd dc = 0
vb vinn gnd dc = 2
***
.op
.dc iin dec 1000 2n 2u
.probe dc i(eo) *avgv = par('(v(vo1)*v(vo2)*v(vo3))^(1/3)')
.meas dc vo_1u find v(vo1) at 1u
.meas dc vo_100n find v(vo1) at 100n
.meas dc vo_10n find v(vo1) at 10n
*.meas dc 100n_1u param = 'vo_1u-vo_100n'
*.meas dc 10n_100n param = 'vo_100n-vo_10n'

.end
