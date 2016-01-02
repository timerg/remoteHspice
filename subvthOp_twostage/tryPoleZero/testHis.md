## No append
Mb	b	b0	vdd	vdd	pch	W = 10u  L = 1u	  m = 2
M1	1	Vinn	b		b		pch	W = 30u L = 0.4u m = 2
M2	2	Vinp	b		b		pch	W = 30u L = 0.4u m = 2
M5	1	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
M6	2	b1		vss	vss	nch	W = 13u L = 0.4u m = 1
m3	von	1		vdd	vdd	pch	w = 18u    l = 1u   m = 1
m4	vop	2		vdd	vdd	pch w = 3.88u 	 l = 0.2u m = 1
m7	von	von	vss	vss	nch	w = 3.8u   l = 1u   m = 1
m8	vop	von	vss	vss	nch	w = 1.1u   l = 0.2u m = 1
### Find Pole
####    point vop

output = v(vop)
    pole
         real            imag             
         -152.964k       -14.9704k        
         -152.964k       14.9704k         
         -5.77389x       0.               
         -10.3255x       0.               
         -53.8575x       0.      
     zero
          real            imag
          -154.166k       0.  
          -5.45519x       0.  
          28.1846x        0.  
          -42.9622x       0.  
          1.03092g        0.  


* CL = 10p

 output = v(vop)             
    pole
        real            imag               
         -5.43283k       0.                 
         -129.234k       0.                 
         -250.825k       0.                 
         -5.47823x       0.                 
         -50.6431x       0.  
    zero
          real            imag
          -154.166k       0.  
          -5.45519x       0.  
          28.1846x        0.  
          -42.9622x       0.  
          1.03092g        0.  

* CL = 5p

 output = v(vop)              
    pole
         real            imag    
         -10.7870k       0.
         -128.839k       0.      
         -253.265k       0.      
         -5.47805x       0.      
         -50.6448x       0.     
     zero
          real            imag
          -154.166k       0.  
          -5.45519x       0.  
          28.1846x        0.  
          -42.9622x       0.  
          1.03092g        0.  


##### C = 73.4f; R = 2,908,174; f = 4,684,719;
###### <font color = "red">p.s. two pole and a zero are couple together. after append, they are separated. they lower one is dominated by output</font>

####    point von
* CL = 0

 output = v(vop)                   
    pole   
        real            imag      
        -152.964k       -14.9704k
        -152.964k       14.9704k  
        -5.77389x       0.        
        -10.3255x       0.        
        -53.8575x       0.        
    zeros ( hertz)   
        real            imag   
        -154.166k       0.     
        -5.45519x       0.     
        28.1846x        0.     
        -42.9622x       0.     
        1.03092g        0.     


 * CL = 10p

 output = v(vop)                   
    poles ( hertz)        
        real            imag        
        -128.373k       40.6358k    
        -128.373k       -40.6358k   
        -215.790k       0.          
        <!-- -6.76790x       0.          
        -10.1337x       0.           -->
    zeros ( hertz)        
        real            imag        
        -188.377k       -67.5028k   
        -188.377k       67.5028k    
        <!-- -5.25253x       0.          
        17.9710x        0.          
        1.00222g        0.           -->



* CL = 5p

 output = v(vop)                   
    poles ( hertz)        
        real            imag        
        -148.198k       30.4698k    
        -148.198k       -30.4698k   
        -339.402k       0.          
        <!-- -6.79502x       0.          
        -10.1298x       0.                    -->
    zeros ( hertz)        
        real            imag        
        -172.764k       0.          
        -459.364k       0.          
        <!-- -5.24405x       0.          
        18.0969x        0.          
        1.00233g        0.           -->

* CL = 30p

output = v(vop)              
    poles ( hertz)     
        real            imag     
        -61.3119k       0.       
        -114.616k       0.       
        <!-- -186.455k       0.       
        -6.75048x       0.       
        -10.1362x       0.          -->
    zeros ( hertz)     
        real            imag     
        -101.956k       -55.1075k
        -101.956k       55.1075k
        <!-- -5.25779x       0.       
        17.8846x        0.       
        1.00215g        0.        -->

* CL = 40p

 output = v(vop)                   
    poles ( hertz)      
         real            imag       
         -44.6334k       0.         
         -119.401k       0.         
         <!-- -184.507k       0.         
         -6.74834x       0.         
         -10.1365x       0.          -->

       zeros ( hertz)       
         real            imag       
         -91.0766k       -42.2731k  
         -91.0766k       42.2731k   
         <!-- -5.25843x       0.         
         17.8736x        0.         
         1.00214g        0.          -->


* CL = 50p

 output = v(vop)                   
    poles ( hertz)      
         real            imag      
         -35.3131k       0.        
         -121.479k       0.        
         <!-- -183.436k       0.         -->
         <!-- -6.74706x       0.        
         -10.1367x       0.         -->
    zeros ( hertz)      
         real            imag      
         -84.5407k       30.3701k  
         -84.5407k       -30.3701k
         <!-- -5.25881x       0.        
         17.8670x        0.        
         1.00213g        0.         -->

####    point 1
* CL = 0

 output = v(vop)                   
    pole   
        real            imag      
        -152.964k       -14.9704k
        -152.964k       14.9704k  
        -5.77389x       0.        
        -10.3255x       0.        
        -53.8575x       0.        
    zeros ( hertz)   
        real            imag   
        -154.166k       0.     
        -5.45519x       0.     
        28.1846x        0.     
        -42.9622x       0.     
        1.03092g        0.     


 * CL = 10p

 output = v(vop)                
    poles ( hertz)       
         real            imag       
         **-1.42013k       0.**
         -172.997k       0.         
         -8.82476x       907.484k   
         -8.82476x       -907.484k  
         -51.1044x       0.         

           zeros ( hertz)       
         real            imag       
         -2.02756k       0.         
         -7.07847x       0.         
         21.3451x        0.         
         -48.0715x       0.         
         1.00251g        0.         


 * CL = 5p

 output = v(vop)                
    poles ( hertz)       
        real            imag       
        **-2.81146k       0.**         
        -172.959k       0.         
        -8.81442x       866.325k   
        -8.81442x       -866.325k  
        -51.1409x       0.                                 
    zeros ( hertz)       
        real            imag       
        -4.00205k       0.         
        -7.05391x       0.         
        21.4311x        0.         
        -47.9888x       0.         
        1.00290g        0.         
##### C = 1.034981e-13; R = 11,092,266; f = 871,058; w = 5,740,247

#### point 2

* CL = 10p

 output = v(vop)                
    poles ( hertz)       
        real            imag       
        -1.42300k       0.         
        -139.456k       0.         
        -7.51590x       0.         
        -8.07473x       0.         
        -53.3381x       0.             
    zeros ( hertz)       
        real            imag       
        -1.97802k       0.         
        -15.9039x       0.         
        -22.2467x       0.         
        258.263x        0.         
        2.28240g        0.         

* CL = 5p

 output = v(vop)                
    poles ( hertz)       
        real            imag       
        -2.82274k       0.         
        -139.431k       0.         
        -7.45115x       0.         
        -8.14384x       0.         
        -53.3423x       0.             
    zeros ( hertz)       
        real            imag       
        -3.90544k       0.         
        -14.8971x       0.         
        -23.7239x       0.         
        226.620x        0.         
        1.89363g        0.       
##### C = 8.308686e-14; R = 11,092,303; f = 1,085,040; w = 6,817,510

### Point b

* CL = 10p

output = v(vop)          
    poles ( hertz)
        real            imag
        -81.8050k       0.   
        -152.722k       0.   
        -232.414k       0.   
        <!-- -10.4300x       0.   
        -53.3361x       0.      -->
    zeros ( hertz)
        real            imag
        -96.6966k       0.   
        -164.242k       0.   
        <!-- -50.2281x       0.   
        59.0478x        0.   
        1.00345g        0.    -->

* CL = 5p

output = v(vop)                                   
    poles ( hertz)
        real            imag
        -123.212k       0.   
        -147.187k       0.   
        -313.517k       0.   
        <!-- -10.4290x       0.   
        -53.3458x       0.      -->
    zeros ( hertz)
        real            imag
        -144.885k       0.   
        -215.483k       0.   
        <!-- -50.0194x       0.    -->
        <!-- 57.6565x        0.   
        1.00467g        0.    -->

* CL = 20p

output = v(vop)         
    poles ( hertz)
        real            imag
        -46.0637k       0.  
        -155.137k       0.  
        -205.357k       0.  
        <!-- -10.4305x       0.  
        -53.3310x       0.     -->
    zeros ( hertz)
        real            imag
        -50.1328k       0.  
        -159.781k       0.  
        <!-- -50.3374x       0.  
        59.7928x        0.  
        1.00280g        0.   -->



 output = v(vop)                   
    poles ( hertz)      

    zeros ( hertz)    




### *Special Mission: Solve Von!!!!!*

According to the Eq, i add a large Cap on the 1_von path. now there should only left one pole

* CL = 10p

output = v(vop)                          
    poles ( hertz)      
        real            imag      
        -705.629m       0.        
        -172.945k       0.        
        -345.528k       0.        
        -8.82289x       0.        
        -9.47601x       0.           
    zeros ( hertz)      
        real            imag      
        -1.01465        0.        
        -346.533k       0.        
        -7.08317x       0.        
        21.0170x        0.        
        1.00571g        0.        

* CL = 5p

output = v(vop)                                     
    poles ( hertz)      
        real            imag      
        -705.630m       0.        
        -172.991k       0.        
        -680.743k       0.        
        -8.82935x       0.        
        -9.46376x       0.          
    zeros ( hertz)      
        real            imag      
        -1.01465        0.        
        -688.064k       0.        
        -7.06094x       0.        
        20.7940x        0.        
        1.00917g        0.        

##### Now we get a C: 1.538266e-13
and R: 45363.56.  
##### However after compensation, R seems to close to 285,941.3



* point 1
    C = 1.034981e-13; R = 11,092,266; f = 871,058; w = 5,740,247
* point vop
    C = 73.4f; R = 2,908,174; f = 4,684,719;
* point 2
    C = 8.308686e-14; R = 11,092,303; f = 1,085,040; w = 6,817,510
