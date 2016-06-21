*ResAmp
.protect
.lib 'mm0355v.l' tt
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB=1 ACCURATE=1 INGOLD=1 unwrap = 1

mc0 cp cp vdd vdd pch w = 1.5u l = 1u m = 1
mc1 cn cp vdd vdd pch w = 1.5u l = 1u m = 4
mc2 cn cn vss vss nch w = 3.5u l = 5u m = 1
Iin cp vss 1u

md1 c1  cp  vdd vdd pch w = 1.5u l = 1u m = 1
md2 c1  c1  vss vss nch w = 5u   l = 3u m = 3
md3 c2  c1  vss vss nch w = 5u   l = 3u m = 1
md4 c2  c2  vdd vdd pch w = 5u   l = 3u m = 2



*.subckt OP vdd vss vip vi out c2
*Mb b   c2  vdd vdd pch w = 5u l = 3u m = 3
*m1 op  vin b   b   pch w = 5u l = 3u m = 4
*m2 o1  vip b   b   pch w = 5u l = 3u m = 4
*m3 op  op  vss vss nch w = 5u l = 3u m = 1
*m4 o1  op  vss vss nch w = 5u l = 3u m = 1
*
*map out c2  vdd vdd pch w = 5u l = 3u m = 4
*man out o1  vss vss nch w = 5u l = 3u m = 2
*Ro  out vin 1000k
*Ri  vi  vin 10k
**Mo  vin c1 out out pch w = 1u l = 5u
**Mi  vin c1  vi  vi  pch w = 1u l = 5u m = 100
*.ends

.subckt OP vdd vss vip vi out c2 en
Mb b   c2  vdd vdd pch w = 5u l = 3u m = 3
m1 op  vin b   b   pch w = 5u l = 3u m = 4
m2 o1  vi b   b   pch w = 5u l = 3u m = 4
m3 op  op  vss vss nch w = 5u l = 3u m = 1
m4 o1  op  vss vss nch w = 5u l = 3u m = 1
map out c2  vdd vdd pch w = 5u l = 3u m = 4
man out o1  vss vss nch w = 5u l = 3u m = 3
Ro  vin  out 1000k
Ri1 vin  vip 100k
Ri2 sw   vip 10k
Cc  out c   350f
Rc o1  c   50k
XS1 vdd vss en sw vin switch
.ends

.subckt switch vdd vss en in out
Mip eo  en  vdd vdd pch w = 2.3u l = 0.35u
Min eo  en  vss vss nch w = 1u l = 0.35u
Msp in  eo  out vdd pch w = 2.3u l = 0.35u m = 2
Msn in  en  out vss nch w = 1u l = 0.35u m = 2
.ends


XOP vdd vss vip vi vop c2 en OP


Vd vdd vss dc = 3.3
Vs vss gnd dc = 0
Vip vip gnd dc = 1v
ven en vss dc = 3.3 pulse(0 3.3 1us 1us 1us 988us 2ms)
Vin vi vss dc = 1 ac = 1

.op
.dc Vin 0 3.3 0.001
.probe i(xop.ri)
.ac dec 1000 10 1g
.pz v(vop) vin
.meas ac phaseATdb	FIND par('vp(vop)') WHEN par('Vdb(vop)-Vdb(vi)') = 0
.meas ac MaxGain    FIND vdb(vop) AT 10
.meas ac BandWidth  WHEN vdb(vop) = 'MaxGain - 3'
.end


* Phase Margin > 78
* Bandwidth > 23k
