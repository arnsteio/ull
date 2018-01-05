/* [Global] */
handle_length=120; //103 hvis thumb-and-brace
handle_width=40;

head_height=100;
head_width=125;

thickness=25;
band_thickness=4.5;

resolution=150;
amount_of_sculpting=30;

/* [Hidden] */
verbose="NO";
error = 0.01;
$fn=resolution;
layer_number=resolution/2;
layer_height=thickness /layer_number/2+error;

module visual_test()
	{
        /* Purely to give a visual guide during construction */
		# translate([0, handle_length-(handle_length+head_height)/2,thickness/2]) cube([head_width, (head_height+handle_length), error], center=true);
		# translate([0, handle_length-(handle_length+head_height)/2,-thickness/2]) cube([head_width, (head_height+handle_length), error], center=true);
	}

module layer(scale)
/* Makes one layer of the slingshot
    scale: larger scale gives a smaller layer. 
          I have designed the module with scales between 1 and 2 in mind but other values might work well. 
*/
	{
    	difference()
    		{   // The "plate" we are cutting shapes away from
    		    translate([0, handle_length-(handle_length+head_height)/2,0]) cube([head_width, (head_height+handle_length), layer_height], center=true);
    		    // Bottom of handle
    		    translate([handle_width*2, handle_length+handle_width/4, 0]) cylinder(h=layer_height*2, r=handle_width*2*scale,center=true); //left
    		    translate([-handle_width*2, handle_length+handle_width/4, 0]) cylinder(h=layer_height*2, r=handle_width*2*scale,center=true); //right
    		    // Top of grip - left
    		    hull()
    		    {
    		        translate([handle_width*1.3, handle_width*0.6, 0]) cylinder(h=layer_height*2, r=handle_width*scale,center=true);
    		        translate([handle_width*2, handle_length+handle_width/4, 0]) cube(100*scale, center=true);
    		    }
    		     // Top of grip - right
    		    hull()
    	    	{
    		        translate([-handle_width*1.3, handle_width*0.6, 0]) cylinder(h=layer_height*2, r=handle_width*scale,center=true);
    		        translate([-handle_width*2, handle_length+handle_width/4, 0]) cube(100*scale, center=true);
    		    }
    		    // Thumb-and-brace cutout - left
    		   translate([head_width*0.93, -head_height*0.4, 0]) cylinder(h=layer_height*2, r=head_width*0.5*scale, center=true);
                // Thumb-and-brace cutout - right
    		   translate([-head_width*0.93, -head_height*0.4, 0]) cylinder(h=layer_height*2, r=head_width*0.5*scale, center=true);
    		   // Fork cutout
    		   translate([0, -head_height*0.7, 0]) cylinder(h=layer_height*2, r=head_width*0.25, center=true);
    		   translate([0, -head_height*1.04,     0])  cube(head_width*0.5, center=true);
    		}
    	}

module band_cutout(height, band_thickness, orientation)
    /* Makes one cutout for rubber bands. Variables:
       height: slingshot body thickness
       band_thickness: Thickness of the slingshot rubber band
       orientation: What direction the cutout should follow away from the actual hole
    */
    {
        cylinder(h=height, d=band_thickness, center=true); 
        rotate([0,0, orientation]) translate([head_width/2, 0, 0]) cube([head_width, band_thickness/3, height+error*2], center=true);
        // To be gentle on band attachment:
        translate([0, 0, height/2]) sphere(d=band_thickness*1.5);
        translate([0, 0, -height/2]) sphere(d=band_thickness*1.5);
    }
    
module band_cutouts(height, band_thickness)
    {
    /* Build module for the "band_cutout" module". Variables:
       height: slingshot body thickness
       band_thickness: Thickness of the slingshot rubber band
        */
     // left
        translate([head_width*0.33, -head_height*0.5, 0]) band_cutout(height, band_thickness, 45);
        translate([head_width*0.33, -head_height*0.7, 0]) band_cutout(height, band_thickness, 45);
        translate([head_width*0.33, -head_height*0.9, 0]) band_cutout(height, band_thickness, 45);   
     // right         
        translate([-head_width*0.33, -head_height*0.5, 0]) band_cutout(height, band_thickness, 135);
        translate([-head_width*0.33, -head_height*0.7, 0]) band_cutout(height, band_thickness, 135); 
        translate([-head_width*0.33, -head_height*0.9, 0]) band_cutout(height, band_thickness, 135);
     }
    
     module support(height, length)
     /* Builds the requisite support for this slingshot so that it can be printed without raft and supports */
     {
         raft_width=4;
         print_head=0.4; // Defined by printer HW
         print_height=0.15; // Defined by printer HW
         raft_thickness=print_height*1.5;
         
         translate([-raft_width, 0, 0]) cube([raft_width*2, length+raft_width*2, raft_thickness], center=false); // raft
         translate([0, length/2, height/2]) cube([print_head*1.5, length, height], center=true); // 
         translate([0, length, 0]) cylinder(r2=print_head*1.5, r1=raft_width, h=height); // Support "pillar" at end
         }
        
         
module build()
    {
        difference()
        {
            union()
            {
            for (i = [0:30]) {
                translate([0,0,i/2]) layer(1+sin(i)*0.4);
                translate([0,0,-i/2]) layer(1+sin(i)*0.4);
                }
            } // union
              band_cutouts(thickness+1, band_thickness);
              translate([0,0,15])layer(1+sin(30)*0.5); //Decorations
        }// diff
//        Doesn't work, I don't know why:
//        translate([35, -10, (1+sin(30)*0.5)])  rotate([0, 0, 180])  text("Veierland 2017", size = 8, font = "Ringbearer");
    }
    
    
    module build2();
    {
        step=(thickness)/(amount_of_sculpting*2); // når amount of sculpting er 30 er translate(step*i) på det meste (amount/(thickness*2)*amount.
        // Det trenger å være, på max, thickness/2 
        if ( verbose == "YES") 
            {
            echo("Resolution is:", resolution);
            echo("Step is", step);
            echo("Layer number is:", layer_number);
            echo("Layer height is:", layer_height);
            }
         difference()
            {    
            union()
                {
                for (i = [0:amount_of_sculpting]) {
                    translate([0,0,step*i]) layer(1+sin(i)*0.4);
                    translate([0,0,-step*i]) layer(1+sin(i)*0.4);
                    }
                #translate([0, handle_length-50, -thickness/2-layer_height/2]) support(thickness/2, 50);
                } // union
            band_cutouts(thickness+1, band_thickness);
    }// Diff
}