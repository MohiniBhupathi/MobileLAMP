$fn = 200;
 
 module extruder_cover() {
        difference() {
		    union(){   
            translate([0, 0, -10.5])      
            cylinder(d=27.5, h = 1.6); 
            
            }
            color("blue")
            union(){
       
            translate([0.0, -3.6, -13])
            cylinder(r = 3.8, h = 10); 
                
            translate([0.0, 3.5, -13])
            cylinder(r = 1.8, h = 10); 
                 
            }
        }
        }
        
        
        extruder_cover();