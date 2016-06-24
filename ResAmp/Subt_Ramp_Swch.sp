***Subtractor + Switch + ResAmp
.protect
.lib 'mm0355v.l' tt
.unprotect
.option post acout=0 accurate=1 dcon=1 CONVERGE=1 GMINDC=1.0000E-12 captab=1 unwrap=1
+ ingold=1

mc0 cp cp vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn cp vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn cn vss vss nch w = 3.5u l = 5u m = 1
Iin cp vss 1u


.subckt Bias vdd vss c1 c2 cp cn
md1 c1  cp  vdd vdd pch w = 1.5u l = 1u m = 1
md2 c1  c1  vss vss nch w = 5u   l = 3u m = 3
md3 c2  c1  vss vss nch w = 5u   l = 3u m = 1
md4 c2  c2  vdd vdd pch w = 5u   l = 3u m = 2
.ends

.subckt subtractor vdd vss c1 c2 vx vy vz out
mb b   c2  vdd vdd pch w = 5u l = 3u m = 3
m1 d3  vx  b   b   pch w = 5u l = 6u m = 1
m2 out vy  b   b   pch w = 5u l = 6u m = 1
m3 vg  vg  vz  vz  pch w = 5u l = 6u m = 1
m4 vss vg  out out pch w = 5u l = 6u m = 1
m7 d6  d3  vss vss nch w = 5u l = 3u m = 8
m8 d7  d3  vss vss nch w = 5u l = 3u m = 8
m5 d3  c1  d6  vss nch w = 5u l = 3u m = 8
m6 vg  c1  d7  vss nch w = 5u l = 3u m = 8
.ends

.subckt RP vdd vss vip vi out c2 en en2
Mb b   c2  vdd vdd pch w = 5u l = 3u m = 3
m1 m   vin b   b   pch w = 5u l = 3u m = 4
m2 o1  vi  b   b   pch w = 5u l = 3u m = 4
m3 m   m   vss vss nch w = 5u l = 3u m = 1
m4 o1  m   vss vss nch w = 5u l = 3u m = 1
map out c2  vdd vdd pch w = 5u l = 3u m = 4
man out o1  vss vss nch w = 5u l = 3u m = 3
Ro  vin  out 1000k
Ri2 sw1   vip 100k
Ri3 sw2  vip 10k
Cc  out c   350f
Rc o1  c   50k
XS1 vdd vss en sw1 vin switch
XS2 vdd vss en2 sw2 vin switch
.ends

.subckt switch vdd vss en in out
Mip eo  en  vdd vdd pch w = 2.3u l = 0.35u
Min eo  en  vss vss nch w = 1u l = 0.35u
Msp in  eo  out vdd pch w = 2.3u l = 0.35u m = 2
Msn in  en  out vss nch w = 1u l = 0.35u m = 2
.ends
.subckt switch2 vdd vss en in out
Mip en  eo  vdd vdd pch w = 2.3u l = 0.35u
Min en  eo  vss vss nch w = 1u l = 0.35u
Msp in  eo  out vdd pch w = 2.3u l = 0.35u m = 2
Msn in  en  out vss nch w = 1u l = 0.35u m = 2
.ends


XBS vdd vss c1 c2 cp cn Bias
Xsub0 vdd vss c1 c2 in cn vz sout subtractor
XRP vdd vss vz sout out c2 en en2 RP
*XS2 vdd vss en2 out sout switch

Vd vdd vss dc = 3.3
Vs vss gnd dc = 0

ven en vss dc = 3.3 *pulse(0 3.3 1us 1us 1us 988us 2ms)
ven2 en2 vss dc = 3.3
Vin in vss dc = 0 ac = 1
Vb  vz vss dc = 1.1

.op
.dc vin 0 2.3 0.001
.ac dec 1000 10 1g
.probe i(xrp.ri) v(xrp.vinn)

.end
