*unit gain buffer
.protect
.lib 'mm0355v.l' tt
*.lib 'rf018.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7 unwrap = 1
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=2  *CONVERGE=1  *dcon=1 * gmindc=1.000E-10


.subckt TrB vdd vss vinp vinn vop cz
Mb	b	cz	 vdd vdd pch W = 2u  L = 0.5u  m = 2
M1	1	Vinn b	 b	 pch W = 2u   L = 0.5u  m = 2
M2	2	Vinp b	 b	 pch W = 2u   L = 0.5u  m = 2
M3	1	1	 vss vss nch W = 2u   L = 0.5u  m = 1
M4	2	1	 vss vss nch W = 2u   L = 0.5u  m = 1
m2p vop cz   vdd vdd pch W = 2u   L = 0.5u  m = 1
m2n vop 2    vss vss nch W = 2u   L = 0.5u  m = 1
.ends
.subckt CMB_bete5 vdd vss cp cn wp = 5u
Iin cp  vss dc = 1u
mc0 cp  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn  cp  vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn  cn  vss vss nch w = 3.5u  l = 5u m = 1
.ends

mc1 cnx  cp  vdd vdd pch w = 1.5u l = 1u m = 1
mc2 cnx  cnx vss vss nch w = 1u   l = 0.35u m = 1

Xcmb   vdd vss cp opb0 CMB_bete5
ms  vdd to_out0 to_out vss nch w = 2u l = 0.35u m = 10
mss to_out  cnx  vss vss nch w = 1u l = 0.35u m = 1





vd vdd gnd dc = 3.3
vs vss gnd dc = 0
vp cp vss dc = 2.39
vin to_out0 gnd dc = 2  ac = 1
vinn vinn gnd dc = 2
*XTrB  vdd vss to_out0 vinn to_out cp TrB
.op
.dc vin 0 3.3 0.1
.probe dc i(mss)
.ac dec 100 1k 10g sweep vin 0.1 3.3  0.2
.probe ac vp(to_out)
*.alter
*vinn vinn to_out dc = 0


.end
