//view.pov


#include "temp.inc"

background{color rgb 1 }		   

object{  m_y57nlzqw

rotate 90*x

texture{  pigment{ color rgb <1,0.5,0> }
        	 finish { 	ambient 0.15
            	      	diffuse 0.85
                	  	specular 0.3 } } }

light_source {  <-20,100,20>  color rgb 2} 

camera {
	perspective
	  angle 45
   right x*image_width/image_height
  location <-20,30,40>
  look_at <30,-30,0>
}  