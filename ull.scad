layer_height=1;
//scale=1; 

handle_length=150;
handle_width=40;

head_height=100;
head_width=150;

error = 0.01;
$fn=15; //150

//include <../openscad_doctest.scad>
module layer(scale)
{
    difference()
    {
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
       translate([-head_width*0.93, -head_height*0.4, 0]) cylinder(h=layer_height*2, r=head_width*0.5*scale, center=true);
       // Top
       translate([0, -head_height*0.7, 0]) cylinder(h=layer_height*2, r=head_width*0.25, center=true);
       translate([0, -head_height*1.1,     0])  cube(head_width*0.5, center=true);
    }
    }

module band_cutout(height, band_thickness, orientation)
    {
        cylinder(h=height, d=band_thickness, center=true); 
        rotate([0,0, orientation]) translate([0, 0, -height/2]) cube([head_width, band_thickness/4, height], center=false);
        // To be gentle on band attachment:
        translate([0, 0, height/2]) sphere(d=band_thickness*1.2);
        translate([0, 0, -height/2]) sphere(d=band_thickness*1.2);
    }


// Very ugly code, need to modularize
height=10;
    band_thickness=4;
module band_cutouts(height, band_thickness);
    {
     // left
        translate([head_width*0.33, -head_height*0.5, 0]) band_cutout(height, band_thickness, 45);
        translate([head_width*0.33, -head_height*0.7, 0]) band_cutout(height, band_thickness, 45);
        translate([head_width*0.33, -head_height*0.9, 0]) band_cutout(height, band_thickness, 45);   
     // right         
        translate([-head_width*0.33, -head_height*0.5, 0]) band_cutout(height, band_thickness, 135);
        translate([-head_width*0.33, -head_height*0.7, 0]) band_cutout(height, band_thickness, 135); 
        translate([-head_width*0.33, -head_height*0.9, 0]) band_cutout(height, band_thickness, 135);
     }
    
module build()
    {
        for (i = [0:30]) {
        translate([0,0,i/2]) layer(1+sin(i)*0.4);
        translate([0,0,-i/2]) layer(1+sin(i)*0.4);
        }
        }
    