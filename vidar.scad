layer_height=1;
//scale=1; 

handle_length=150;
handle_width=40;

head_height=100;
head_width=150;

error = 0.01;
$fn=30; //150

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
       translate([head_width*0.93, -head_height*0.4, 0]) cylinder(h=layer_height*2, r=head_width*0.5, center=true);
       translate([-head_width*0.93, -head_height*0.4, 0]) cylinder(h=layer_height*2, r=head_width*0.5, center=true);
       // Top
       translate([0, -head_height*0.7, 0]) cylinder(h=layer_height*2, r=head_width*0.25, center=true);
       translate([0, -head_height*1.1,     0])  cube(head_width*0.5, center=true);
    }
    }

module build();
    {
        layer(1);
        }
    
module handle(w,l,h) 
{
    step=h/180;
      for(i=[0:180])
        translate([0, 0, i*step])
        cube([w+sin(i)*10,l, step+error], center = true);
}

    
    module head(w,h,t)
    {
        zstep=t/180;
        for(i=[0:180])
        translate([-sin(i)*5, 0, i*zstep])
        head_sjablon(w+sin(i)*10,h,zstep+error);
    }

    
   //translate([0,-handle_length/2,0])    handle(handle_bottom, handle_length, thickness);
    
   //translate([-head_width/2,0, 0])    head(head_width, head_height, thickness);