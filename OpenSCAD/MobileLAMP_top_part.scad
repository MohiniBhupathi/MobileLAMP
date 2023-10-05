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
	base_y = 47;
	base_z = 1; 

	pin_d = 3;
	pin_h = 17;

	translate([0, 0, base_z/2])
	cube([base_x, base_y, base_z], center = true);

	translate([-20.5, 17, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 1])
		cylinder(r = pin_d/2+1, h = 2, center = true);
	}

	translate([+20.5, 17, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 1])
		cylinder(r = pin_d/2+1, h = 2, center = true);		
	}

	translate([+20.5, -15.5, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 1])
		cylinder(r = pin_d/2+1, h = 2, center = true);
	}

	translate([-20.5, -15.5, base_z + pin_h/2])
	union()
	{
		cylinder(r = pin_d/2, h = pin_h, center = true);
		translate([0,0, -pin_h/2 + 1])
		cylinder(r = pin_d/2+1, h = 2, center = true);
	}
}

module case_top()
{
	top_x = 55;
	top_y = 47;
	top_z = 30; 

	pin_d = 3.4;
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
		cylinder(r = pin_d/2+1.5, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([20.5, -15.5, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1.5, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, -15.5, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1.5, h = pin_h, center = true);
		cylinder(r = pin_d/2, h = pin_h + 1 , center = true);
	}

	translate([-20.5, 17, pin_h/2 + 4+11])
	difference()
	{
		cylinder(r = pin_d/2+1.5, h = pin_h, center = true);
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


//color([1,1,0.5])
//case_base();

//translate([0, 1, 3])
//w1209();

//color("black")
//translate([12, 2.5, 10])
//pin();

//color("black")
//translate([1.5, 2.5, 10])
//pin();

//color("black")
//translate([-9, 2.5, 10])
//pin();

//color([1,1,0.5])
//translate([0, 0, 1])
case_top();
