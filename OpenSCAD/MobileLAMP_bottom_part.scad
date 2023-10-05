$fn = 200;
width = 30;
depth = 55;
height = 34.5;
height2 = 20;
height3 = 14;
side=70; //size of the Fan, distance between the holes
screw_out=3.5; //Outer radius of the pillar support
screw_in=1.5; //Inner radius of the pillar support
screw_height=10;// height of pillar support
wallThickness = 3;
//translate([-30,0,0])
	//top_x = 55;
	//top_y = 53;
	//top_z = 34.5; 

translate([0, 0, 11.0])   
extruder();      
//color([1,1,0.5])
rotate([0,0,90])
translate([2, -42, 0])
case_base();
//rotate([0,0,90])
//translate([2, -46.6, 14])
//big_case_top();   
 //translate([0, 0, 46.0])    
 //extruder_cover();   
 module extruder() {
        difference() {
		    
            union(){
                 color("gray")
              translate([0, 0, -10.5])      
              cylinder(d=29, h = 19.4); 
    
        
               }
                
         
               
         
               union(){
                   
          
                    color("red")
                    translate([0,0,2.5])
                    cube ([16.7,16.7,13], center=true); 

                    //for temp sensor            
                    rotate([0,90,0]) 
                    translate([6.0, 2.0, -10])
                    cylinder(r = 2.5, h = 25);   
       
                    //for extruder wires           
                    rotate([0,90,0]) 
                    translate([-1.6, 2.5, -10])
                    cylinder(r = 4.5, h = 25);   
                    
                   
                   //for screw   
                  // color("blue")
                   translate([0.0, -3.6, -9])
                   cylinder(r = 3.3, h = 25); 
          
                   
                    }
            }
        

        }
        
  
        
        ///Lid and Jar

// 'Container with Knurled Lid' by wstein 
// is licensed under the Attribution - Non-Commercial - Share Alike license. 
// (c) April 2015 - April 2018
// please refer the complete license here: http://creativecommons.org/licenses/by-nc-sa/3.0/legalcode


// Version 1.8.1
// Fixed outside quality of the container and lid.
//
// Version 1.8
// New simple non knurled lid.
//
// Version 1.7.1
// Bug fixed for latest customizer.
//
// Version 1.7
// generate all lid styles at once
// code optimized for openscad 2015.03 (no more timeout)
//
// Version 1.6
// added compartment option
// part "both" removed
//
// Version 1.5
// fixed broken left knurled lid.
//
// Version 1.4
// new expert setting.
//
// Version 1.3
// new: use $fn=100 for all threads to make them a little bit smoother.
//
// Version 1.2
// new: lid optimized for diameter smaller 20mm. The lid of an container with a diameter less than 20mm has now always the same height of about 6mm. This concerns also the thread which may not fit to containers of older versions!
// fixed: selecting both (Container and Lid) generated a none printable file: The object are on different level!

/* [Dimensions] */

// inner diameter (for outer dimension add 2x wall thickness) - minimum = 8.0mm
diameter=29.0;

// inner height (for outer dimension add 2x wall thickness)
height=30.0;

// Select how many compartments there should be in the container - default is 1.
compartments = 1; //[1:8]

/* [Appearance] */

// Container outside chamfer in percent of diameter. Use 0 for a flat outside bottom - default is 5% 
outside_chamfer=2.0; 

// Container inside chamfer in percent of diameter. Use 0 for a flat inner bottom - default is 2.5% 
inside_chamfer=2.5; 

/* [Thickness] */

// default value -1 means 2mm up to size 60, 2.5mm from 61 - 100. 3mm for larger.
wall_thickness=-1;

// default value -1 means take 1/2 of the container Wall Thickness
divider_wall_thickness=-1;

//thickness off container bottom. If you use the solid container model use the same value as setup in the slicer. default: -1 (use wall thickness)
container_bottom_thick=-1;

//thickness off lid top. Lid is always normal printing, so nothing special here, except reset the slicer to normal settings. default: -1 (use wall thickness)
lid_top_thick=-1;

/* [Expert] */

// to show? Only create once! You will get always all parts!
part = "container_"; // [container_:Container,lid_left_knurled_:Lid - Left Knurled, lid_right_knurled_:Lid - Right Knurled, lid_vertical_knurled_: Lid - Vertical Knurled, lid_double_knurled_:Lid - Double Knurled, lid_simple_non_knurled_:Lid - Simple Non Knurled]

// default value -1 means take 1/4 of Wall Thickness
backlash=-1;

//build a solid container, this is the key for high quality prints and also spare filament. You must print it with special settings (no infill, no top layer, bottom layer 1mm, shell thickness 1mm - must be about half of wall thickness). Works fine with Slic3r but I failed to setup Cura correct. Don't forget to reactivate top layer and infill before printing lid!
solid_container=0; //[1:true, 0:false]

quality=80; // [80:good, 100:high, 120:very high,150:best]

/* [Hidden] */

// ensure some minimal values
function diameter()=max(8,diameter);

function wall_thickness()=( 
	wall_thickness!=-1 ? max(1.0,wall_thickness) : (
	diameter() <= 20 ? 1.5 : (
	diameter() <= 60 ? 2.0 : (
	diameter() <= 100 ? 2.5 : 
   3.0))));
   
function get_divider_wall_thickness()=(divider_wall_thickness==-1?wall_thickness()/2:divider_wall_thickness);

bottom_thick=(container_bottom_thick<0?wall_thickness()/-container_bottom_thick:container_bottom_thick);
top_thick=(lid_top_thick<0?wall_thickness()/-lid_top_thick:lid_top_thick);

   
function backlash()=backlash==-1?wall_thickness()/4:max(0.2,backlash);
thread_height=(diameter()>20?diameter()/6:20/6);
function height()=max(2*(thread_height+bottom_thick),height);

$fn=quality;

lid_r=diameter()/2+wall_thickness()/2+backlash();
lid_r0=(diameter()>=20?lid_r:20/2+wall_thickness()/2+backlash()); // virtual radius, for diameter() < 20

intersection()
{
	assign(offset=(part=="both"?diameter()*.6+2*wall_thickness():0))
	union()
	{
		if(part=="container_")
		translate([0,-offset,0])
		container(diameter(),height());
		else
		translate([0,offset,(part=="cross"?height()-thread_height-wall_thickness()+bottom_thick+.1:thread_height+top_thick+wall_thickness())])
		rotate([0,(part=="cross"?0:180),0])
		lid(lid_r,lid_r0,thread_height+wall_thickness());
	}
	if(part=="cross")
	cube(200);
}


module lid(r,r0,h)
union()
{
	intersection()
	{
		translate([0,0,wall_thickness()])
		thread(r,thread_height,outer=true);

		cylinder(r=r+wall_thickness()/2,h=h);
	}

	difference()
	{
		assign(a=1.05,b=1.1)
		assign(ra=a*r+b*wall_thickness(),ra0=a*r0+b*wall_thickness(),h1=h+top_thick)
 
        if(part=="lid_right_knurled_")
        knurled(ra,ra0,h1,[1]);
        else if(part=="lid_left_knurled_")
        knurled(ra,ra0,h1,[-1]);
        else if(part=="lid_vertical_knurled_")
        knurled(ra,ra0,h1,[0]);
        else if(part=="lid_double_knurled_")
        knurled(ra,ra0,h1,[-1,1]);
        else
        cylinder(r=ra,h=h1);

		translate([0,0,-.1])
		cylinder(r=r+wall_thickness()/2,h=h+.1);
	}
}


knurled_h=[
0,
0.1757073594,
0.5271220782,
0.7116148055,
0.9007198511,
1];
knurled_rdelta=[.2,0,0.1,.3,.6,1.0];
shape_n=5;

module knurled(r,r0,height,degs)
assign(n=round(sqrt(120*(r+2*wall_thickness())*2)/shape_n)*shape_n)
assign(h_steps=len(knurled_h)-1)
assign(r_delta=-1.6*wall_thickness()/2)
//translate([0,0,height])
//rotate([180,0,0])
intersection_for(a=degs)
for(i=[0:h_steps-1])
    assign(hr0=knurled_h[i],hr1=knurled_h[i+1])
    assign(hr=hr1-hr0)
    assign(rr0=knurled_rdelta[i],rr1=knurled_rdelta[i+1])
    assign(rr=rr1-rr0)
    translate([0,0,hr0*height])
    rotate([0,0,35*height/r*hr0*a])
    linear_extrude(convexity=10,height=hr*height,twist=-35*height/r*hr*a,scale=(r+r_delta*rr1)/(r+r_delta*rr0))
for(j=[0:n/4-1])
rotate([0,0,360/n*j])
circle(r=r+r_delta*rr0,$fn=5);


module container(r,h)
union()
{
	difference()
	{
		union()
		{
			container_hull(diameter()/2+wall_thickness(),height()+bottom_thick,outside_chamfer,[wall_thickness()/2,thread_height+wall_thickness()/2]);

			translate([0,0,height()-thread_height-wall_thickness()/2+bottom_thick])
			thread(diameter()/2+wall_thickness(),thread_height,outer=false);
		}
	union()
		{
                    //for temp sensor            
                    rotate([0,90,0]) 
                    translate([-5, 2.0, -13])
                    cylinder(r = 2.5, h = 60);   
       
                    //for extruder wires           
                    rotate([0,90,0]) 
                    translate([-12.5, 2.5, 5.0])
                    cylinder(r = 4.5, h = 20);    
           
                 //for screw   
                //   color("blue")
                  // translate([0.0, -3.6, -3])
                   //cylinder(r = 3.3, h = 30);  
        

		if(!solid_container)
			translate([0,0,bottom_thick])

		container_hull(diameter()/2,height()+bottom_thick,inside_chamfer);
        
    }
	}

	if(compartments > 1)
	{
        echo(get_divider_wall_thickness());
		for(a = [0 : 1 : compartments])
		{
			rotate((360 / compartments) * a) 
            translate([-(get_divider_wall_thickness() / 2), 0, bottom_thick])
            cube([get_divider_wall_thickness(), diameter() / 2, height()]);
		}
	}
}

module container_hull(r,h,chamfer,thread_notch=[0,0])
{
	xn=thread_notch[0];
	yn=thread_notch[1];

	rotate_extrude(convexity=10)
	assign(x1=r*(50-chamfer)/50,x2=r,x3=r-xn,y1=r*chamfer/50,y2=h,y3=h-yn,y4=h-yn+xn)
	polygon([[0,0],[x1,0],[x2,y1],[x2,y3],[x3,y4],[x3,y2],[0,y2]]);
}

module thread(r,h,outer=false)
assign($fn=100)
{
	linear_extrude(height=h,twist=-250,convexity=10)
	for(a=[0:360/2:359])
	rotate([0,0,a])
	if(outer)
	{
		difference()
		{
			translate([0,-r])
			square(2*r);

			assign(offset=.8)
			translate([r*(1-1/offset),0])
			circle(r=1/offset*r);	
		}
	}
	else
	{
		assign(offset=.8)
		translate([(1-offset)*r,0,0])
		circle(r=r*offset);
	}
}

////////////////////////////////////
//case integration

$fn = 100;

module microswitch()
{
	base_x = 6;
	base_y = 6;
	base_z = 4;

	pin_d1 = 3.4;
	pin_d2 = 3.2;
	pin_h = 4;

	color("Silver")
	translate([0,0, base_z/2])
	cube([base_x, base_y, base_z], center = true);

	color("Black")
	translate([0, 0, base_z + pin_h/2])
	cylinder(r1 = pin_d1/2, r2 = pin_d2/2, h = pin_h, center = true);
}

module w1209()
{
	board_x = 49;
	board_y = 41;
	board_z = 1.5;

	board_hole_d = 3.3;
	
	relay_x = 12;
	relay_y = 15.5;
	relay_z = 14;
	
	display_x = 23;
	display_y = 10;
	display_z = 6;

	sensor_x = 6;
	sensor_y = 7.5;
	sensor_z = 11.5;

	led_x = 1.2;
	led_y = 1.2;
	led_z = 1;

	microswitch_base = 6;

	connector_x = 20;
	connector_y = 7.5;
	connector_z = 10;	

	color("Green")
	translate([0, 0, board_z/2])
	difference()
	{	
		cube([board_x, board_y, board_z], center=true);

		translate([	board_x/2 - 4, board_y/2 - 4.5, 0])
		cylinder(r = board_hole_d/2, h = board_z * 2, center = true);

		translate([	board_x/2 - 4, - (board_y/2 - 4), 0])
		cylinder(r = board_hole_d/2, h = board_z * 2, center = true);

		translate([	-(board_x/2 - 4), - (board_y/2 - 4), 0])
		cylinder(r = board_hole_d/2, h = board_z * 2, center = true);

		translate([	-(board_x/2 - 4), board_y/2 - 4.5, 0])
		cylinder(r = board_hole_d/2, h = board_z * 2, center = true);
	}

	color("Black")
	translate([	8 - (board_x/2 - relay_x/2),
					-(board_y/2 - relay_y/2),
					board_z + relay_z/2])
	cube([relay_x, relay_y, relay_z], center = true);

	color("Snow")
	translate([	0,
				 	board_y/2 - display_y/2,
				 	board_z + display_z/2])
	cube([display_x, display_y, display_z], center = true);

	color("White")
	translate([	board_x/2 - sensor_x/2,
					board_y/2 - sensor_y/2 - 8,
					board_z + sensor_z/2])
	cube([sensor_x, sensor_y, sensor_z], center = true);

	color("Yellow")
	translate([	board_x/2 - led_x/2 - 9,
					board_y/2 - led_y/2 - 5,
					board_z + led_z/2])
	cube([led_x, led_y, led_z], center = true);
 
	translate([	-board_x/2 + microswitch_base/2 + 12.5,
				  	board_y/2 - microswitch_base/2 - 16,
				  	board_z])
	microswitch();

	translate([	board_x/2 - microswitch_base/2 - 9.5,
				  	board_y/2 - microswitch_base/2 - 16,
				  	board_z])
	microswitch();

	translate([	board_x/2 - microswitch_base/2 - 20,
				  	board_y/2 - microswitch_base/2 - 16,
				  	board_z])
	microswitch();

	color("ForestGreen")
	translate([	board_x/2 - connector_x/2 - 8,
					-(board_y/2 - connector_y/2),
					board_z + connector_z/2])
	cube([connector_x, connector_y, connector_z], center = true);

}


module case_base()
{
	base_x = 55;
	base_y = 58;
	base_z = 3; 

	pin_d = 2.4;
	pin_h = 20;
    
          //for wire management
     difference()
	{  
   // rotate([0,90,90]) 
    translate([0.0, 24.0, 11])
    cube([16,9.5,18], center=true);
        union(){
    //rotate([0,90,90]) 
    translate([0.0, 20.0, 10])
    cube([12,18,16], center=true);
            
    rotate([0,90,90]) 
    translate([-4.6, 0.0, -30])
    cylinder(r = 3, h = 59);
            
        }
        
    } 
  
      //for temp sensor  
     difference()
	{  
    rotate([0,90,90]) 
    translate([-5.50, 0.0, -22])
    cylinder(r = 4.5, h = 5);
        
    rotate([0,90,90]) 
    translate([-5, 0.0, -22.1])
    cylinder(r = 3, h = 6);
    } 
  
      //for temp sensor  
     difference()
	{  
    rotate([0,90,90]) 
    translate([-5.5, 0.0, 10])
    cylinder(r = 4.5, h = 5);
        
    rotate([0,90,90]) 
    translate([-5, 0.0, 9.9])
    cylinder(r = 3, h = 6);
        
    
        
    } 
  
  
  
    
     difference()
	{       
	translate([0, 0, base_z/2])
	cube([base_x, base_y, base_z], center = true);
    
           //for temp sensor    
    rotate([0,90,90]) 
    translate([-5, 0.0, -30])
    cylinder(r = 2.5, h = 59);
        

    
    }
	translate([-20.5, 12, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 6])
		cylinder(r = pin_d/2+1, h = 12, center = true);
	}

	translate([+20.5, 12, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 6])
		cylinder(r = pin_d/2+1, h = 12, center = true);		
	}

	translate([+20.5, -20.5, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 6])
		cylinder(r = pin_d/2+1, h = 12, center = true);
	}

	translate([-20.5, -20.5, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 6])
		cylinder(r = pin_d/2+1, h = 12, center = true);
	}
    
    //extra pin for wires
    
    	translate([-12.5, -2.5, base_z + pin_h/4])
	union()
	{
        cylinder(r1 = pin_d/2, r2= pin_d/2+3, h = 12, center = true);

		
	}
    
        //extra pin for wires
        
    	translate([12.5, -2.5, base_z + pin_h/4])
	union()
	{
        cylinder(r1 = pin_d/2, r2= pin_d/2+3, h = 12, center = true);

		
	}
    
}

module case_top()
{
	top_x = 55;
	top_y = 48;
	top_z = 19; 

	pin_d = 3.3;
	pin_h = 15;

	translate([0,0,top_z/2])
	difference()
	{
		union()
		{
			difference()
			{
				    union()
                {
                // main cube
				cube([top_x, top_y, top_z], center = true);
                         

                    
                }
            union()
                {
				// inside of main cube
				translate([0,0,-1])
				cube([top_x - 2, top_y - 2, top_z + 0.5], center = true);
                
                                //for temp sensor            
                rotate([0,90,90]) 
                translate([7, 0.0, 0])
                cylinder(r = 2.9, h = 50);   
       
                //for extruder wires           
                rotate([0,90,90]) 
                translate([0, -0.5, 0])
                cylinder(r = 4.5, h = 50); 
                   
                } 
                
			}

			// tube over display
			translate([0, 15.5, 5])
			cube([24.5, 11, 9], center = true);

			// button pipes
			translate([12, 2.5, 7])
			cylinder(r = 6/2, h = 5, center = true);

			translate([1.5, 2.5, 7])
			cylinder(r = 6/2, h = 5, center = true);

			translate([-9, 2.5, 7])
			cylinder(r = 6/2, h = 5, center = true);
		}

		// hole over display
		translate([0, 15.5, 0])
		cube([22.5, 9, 50], center = true);

		// holes for the buttons
		translate([12, 2.5, 0])
		cylinder(r = 4/2, h = 50, center = true);

		translate([1.5, 2.5, 0])
		cylinder(r = 4/2, h = 50, center = true);

		translate([-9, 2.5, 0])
		cylinder(r = 4/2, h = 50, center = true);

		// hole for wires
		translate([28, -20.5, -7])
		cube([5, 4, 6], center = true);

	}

	// connection pins
	translate([20.5, 17, pin_h/2 + 4])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([20.5, -15.5, pin_h/2 + 4])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, -15.5, pin_h/2 + 4])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, 17, pin_h/2 + 4])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}
}

module pin()
{
	d = 4; // pin
	h = 8; // pin
	h2 = 4; // tube

	translate([0,0, h2/2])
	union()
	{
		difference()
		{
			cylinder(r = (d+1)/2, h = h2, center = true);
			translate([0, 0, -1])
			cylinder(r = d/2, h = h2, center = true);
		}
		translate([0, 0, h/2 + h2/2 - 1])
		cylinder(r = (d-1)/2, h = h, center = true);
	}
}


module big_case_top()
{
	top_x = 55;
	top_y = 47;
	top_z = 30; 

	pin_d = 3.6;
	pin_h = 15;

	translate([0,0,top_z/2])
	difference()
	{
		union()
		{

			difference()
			{
				// main cube
				cube([top_x, top_y, top_z], center = true);
              union()
                    {
				// inside of main cube
				translate([0,0,-1])
				cube([top_x - 2, top_y - 2, top_z + 0.5], center = true);
                //Wire management     
                translate([0.0, 24.50, -10])
                cube([14,6,18], center=true);
                
                     
           
                    }
            
			}

			// tube over display
			translate([0, 15.5, 5+5.5])
			cube([24.5, 11, 9], center = true);

			// button pipes
			translate([12, 2.5, 7+5.5])
			cylinder(r = 8/2, h = 5, center = true);

			translate([1.5, 2.5, 7+5.5])
			cylinder(r = 8/2, h = 5, center = true);

			translate([-9, 2.5, 7+5.5])
			cylinder(r = 8/2, h = 5, center = true);
		}

		// hole over display
		translate([0, 15.5, 0])
		cube([22.5, 9, 50], center = true);

		// holes for the buttons
		translate([12, 2.5, 0])
		cylinder(r = 2.5, h = 50, center = true);

		translate([1.5, 2.5, 0])
		cylinder(r = 2.5, h = 50, center = true);

		translate([-9, 2.5, 0])
		cylinder(r = 2.5, h = 50, center = true);

		// hole for wires
		translate([28, -20.5, -7-5.5])
		cube([5, 4, 6], center = true);

	}

	// connection pins
	translate([20.5, 17, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([20.5, -15.5, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, -15.5, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, 17, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}
}


 module extruder_cover() {
        difference() {
		    union(){   
            translate([0, 0, -10.5])      
            cylinder(d=27.5, h = 1.6); 
            
            }
            color("blue")
            union(){
       
            translate([0.0, -3.6, -13])
            cylinder(r = 3.6, h = 10); 
                
            translate([0.0, 3.0, -13])
            cylinder(r = 1.8, h = 10); 
                 
            }
        }
        }
        
        

