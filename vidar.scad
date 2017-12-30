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

module test();
    {
         translate([0,0,0]) layer(1+sin(30)*0.4);
        
        }
module build()
    {
        for (i = [0:30]) {
        translate([0,0,i/2]) layer(1+sin(i)*0.4);
        translate([0,0,-i/2]) layer(1+sin(i)*0.4);
        }
        }
    