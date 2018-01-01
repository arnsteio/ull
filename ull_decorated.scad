/* [Global] */
handle_length=150;
handle_width=40;

head_height=100;
head_width=150;

thickness=30;
band_thickness=4;

/* [Hidden] */
layer_height=1;
error = 0.01;
$fn=150; //150

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
    		   translate([0, -head_height*1.1,     0])  cube(head_width*0.5, center=true);
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
        rotate([0,0, orientation]) translate([0, 0, -height/2]) cube([head_width, band_thickness/4, height], center=false);
        // To be gentle on band attachment:
        translate([0, 0, height/2]) sphere(d=band_thickness*1.2);
        translate([0, 0, -height/2]) sphere(d=band_thickness*1.2);
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
    
     module support(raft_thickness, height, length)
     /* Builds the requisite support for this slingshot so that it can be printed without raft and supports */
     {
         raft_width=3;
         print_head=0.4;
          translate([0, length/2, raft_thickness/2]) cube([raft_width*3, length+raft_width*2, raft_thickness], center=true); // raft
          translate([0, length/2, height/2]) cube([print_head, length, height], center=true);
         translate([0, length, 0]) cylinder(r2=print_head, r1=raft_width, h=height);
         }
         translate([0, handle_length-40, -15.5]) support(0.25, 15.5, 40);
         
    /*     difference(){
         layer(1+sin(30)*0.4);
         layer(1+sin(30)*0.5);
         }
//         Funker ikke, vet ikke hvorfor
       translate([35, -10, (1+sin(30)*0.5)])  rotate([0, 0, 180])  text("Veierland 2017", size = 8, font = "Ringbearer");
      */   
module build();
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
            translate([0,0,15])layer(1+sin(30)*0.5);
        }// diff
//        Doesn't work, I don't know why:
//        translate([35, -10, (1+sin(30)*0.5)])  rotate([0, 0, 180])  text("Veierland 2017", size = 8, font = "Ringbearer");
    }
    
