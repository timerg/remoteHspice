

### 2/22
* Solve little peak at edge by add an 10p C on vo_out. Bc it lower the bandwidth of OP(to be close to gm's).</br>
    <img src="pic/10pCapOn'vnw'_before.png" width=70%></img> : Before</br>
    <img src="pic/10pCapOn'vnw'_after.png" width=70%></img> : After</br>
    Same thing can be down by lower OP gain or make gm drop faster_

### 2/23
* Solve little peak on iEnlarge. it is cause by a too large OP. </br>
    <img src="pic/peakOnIEn-before.png" width=70%></img> : Before</br>
    <img src="pic/peakOnIEn-after.png" width=70%></img> : After add R to OP output to lower gain</br>

* the Mb bias is change from 2.4 to 2.7 to lower bandwidth of pmos. This exchanges big Cap for an additional current mirror.

* the nmos of Ien(me1,me2) use length=1 considering about the noise while pmos still use 0.4u for the size consideration.

* For Dc sweep, sw0(inw input) failed but ac1(change w) work well. The reason might be: impedance comparison btw mnw and mc route. We hope feedback decreases mnw impedance which only happen with a very large OP_out. But OP_out too large will have a convergence prob and a unstable prob(refer to 2/23-1). The first Prob could be solved by larger gmindc but will lower accuracy in the same time(error has been encountered). And the second one would be solved by a very large cap.

### 2/24
* **gm's output stage pmos has very small w/l ration. it is found being error when mo3,4a l=5u. so i increase it to 6u. Reason is still unknown**

* the OP should keep trying to lower bandwidth while maintain its low gain


### 3/2
* When doing layout, need to be aware of OP_out since it has very large gain

* When bias nw with 100n, Ibias seems hard to go into it bf impedance prob
