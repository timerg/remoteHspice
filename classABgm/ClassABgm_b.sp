*ClassABgm_b
.protect
.lib 'mm0355v.l' TT
.unprotect
.options ABSTOL=1e-7 RELTOL=1e-7
+ POST=1 CAPTAB ACCURATE=1 INGOLD=1

***netlist***
M1 sn vx   vdd vdd pch w = 5u l = 0.4u m = 3
M3 vx vinp sn  sn  pch w = 12u  l = 0.4u m = 1
M2 sp vx   vdd vdd pch w = 5u l = 0.4u m = 3
M4 vx vinn sp  sp  pch w = 12u  l = 0.4u m = 1
Mb  vx vb   vss vss nch w = 15u  l = 1u m = 3

Mip iop vinp sp sp pch  w = 1.7u l = 0.4u m = 1
Min ion vinn sn sn pch  w = 1.7u l = 0.4u m = 1  *was 1.7u

****one stage; one ouput mos***
*Mop iop iop vss vss nch w = 0.8u   l = 0.4u m = 1
*Mon ion iop vss vss nch w = 0.8u   l = 0.4u m = 1
*En  ion gnd OPAMP vref ion
*.param rr = '0.5736'
*Vr vref gnd dc = rr

***one stage; muti output mos***
*: the input mos vgs limited the stack mos amount and make things hard to applied
*Mop1 iop2 vinp iop  iop   pch w = 5u   l = 0.4u m = 1
*Mon1 ion2 vinn ion  ion   pch w = 5u   l = 0.4u m = 1
*Mop2 iop3 vinp iop2 iop2  pch w = 5u   l = 0.4u m = 1
*Mon2 ion3 vinn ion2 ion2  pch w = 5u   l = 0.4u m = 1
*    ***OPAMP output***
*En ion3 gnd OPAMP vref ion3
*Ep iop3 gnd OPAMP vref iop3
*.param rr = '0.4734'
*Vr vref gnd dc = rr
*    ***Mos output
*Mop iop3  iop3 vss  vss   nch w = 0.8u   l = 0.4u m = 1
*Mon ion3  iop3 vss  vss   nch w = 0.8u   l = 0.4u m = 1
*En  ion3 gnd OPAMP vref ion3
*.param rr = '0.4737'
*Vr vref gnd dc = rr
****Two stage; current cancellation***
*Mc2 iop iop vss vss nch w = 1.1u l = 0.4u m = 6
*Mc1 ion ion vss vss nch w = 1.1u l = 0.4u m = 6

**Mc3 icn ion vss vss nch w = 1.1u l = 0.4u m = 1
**Mc4 icp iop vss vss nch w = 1.1u l = 0.4u m = 1
**Mc5 icn icn vdd vdd pch w = 1u l = 0.4u m = 1
**Mc6 icp icn vdd vdd pch w = 1u l = 0.4u m = 1
*Mc3a icp iop vss vss nch w = 1.1u l = 0.4u m = 2
*Mc4a icn ion vss vss nch w = 1.1u l = 0.4u m = 2
*Mc3b icp ion vss vss nch w = 1.1u l = 0.4u m = 1
*Mc4b icn iop vss vss nch w = 1.1u l = 0.4u m = 1
*Mc5 icp icp vdd vdd pch w = 15u l = 0.4u m = 1
*Mc6 icn icp vdd vdd pch w = 16u l = 0.4u m = 1
*En icn gnd OPAMP vref icn
*Ep icp gnd OPAMP vref icp
*.param rr = '3.3-0.67'
*Vr vref gnd dc = rr
***source***
Vd vdd gnd dc = 3.3
Vs vss gnd dc = 0
Vbi vb   gnd dc = 0.5

.param diff = 0
Vip vinp gnd dc = '2.2-diff'
Vin vinn gnd dc = '2.2+diff'



***
.op
.dc sweep diff -0.22 0.2 0.001 *sweep rr 0.6 1.6 0.2
.probe dc lx3(M3) lx3(M1) lx2(M3) lx2(M1) lx2(mip)
+ I(en) I(ep) Idiff2 = par('I(ep)-I(en)')
+ Vdiff = par('V(iop) - V(ion)') I(mc1) I(mc2) Idiff = par('I(mc2)-I(mc1)')
+ I(mc5) Ino = par('I(mc3a)+I(mc3b)') Ipo = par('I(mc4b)+I(mc4a)')
.end
