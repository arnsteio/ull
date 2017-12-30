layer_height=1;
scale=1; 

handle_length=150;
handle_width=40;

head_height=120;
head_width=150;

error = 0.01;
$fn=10; //150

//include <../openscad_doctest.scad>;

module layer(scale);
{
    difference()
    {
        translate([0, handle_length-(handle_length+head_height)/2,0]) cube([head_width, (head_height+handle_length), layer_height], center=true);
        // Bottom of handle
        translate([handle_width*2, handle_length+handle_width/4, 0]) cylinder(h=layer_height, r=handle_width*2*scale,center=true);
        translate([-handle_width*2, handle_length+handle_width/4, 0]) cylinder(h=layer_height, r=handle_width*2*scale,center=true);
        // Top of grip - left
        hull()
        {
            translate([handle_width*1.5, handle_width, 0]) cylinder(h=layer_height, r=handle_width*scale,center=true);
            translate([handle_width*2, handle_length+handle_width/4, 0]) cube(100*scale, center=true);
        }
         // Top of grip - right
        hull()
        {
            translate([-handle_width*1.5, handle_width, 0]) cylinder(h=layer_height, r=handle_width*scale,center=true);
            translate([-handle_width*2, handle_length+handle_width/4, 0]) cube(100*scale, center=true);
        }
    }
    }

module handle(w,l,h) 
{
    step=h/180;
      for(i=[0:180])
        translate([0, 0, i*step])
        cube([w+sin(i)*10,l, step+error], center = true);
}

module head_sjablon(w,h,t)
    {
    difference()
        {
            cube([w,h,t]);
            translate([w*0.15, -w*0.1,-error])cylinder(h=t*2, r=w*0.22);   // left towards handle     
            translate([w*0.85, -w*0.1,-error])cylinder(h=t*2, r=w*0.22); // right towards handle
            translate([-w*0.4, h*0.4,-error])cylinder(h=t*2, r=w*0.5);  //left cutout   
            translate([w*1.4, h*0.4,-error])cylinder(h=t*2, r=w*0.5);   //right cutout
            translate([w*0.5, h*0.6,-error]) // cutout middle of the fork
            {
                   cylinder(h=t*2, r=w*0.25); 
                   translate([-w*0.25, 0,-error]) {cube([w*0.5,h, t+error*2]);}               
            }
        }
    }//module head_sjablon
    
    module head(w,h,t)
    {
        zstep=t/180;
        for(i=[0:180])
        translate([-sin(i)*5, 0, i*zstep])
        head_sjablon(w+sin(i)*10,h,zstep+error);
    }

    
   //translate([0,-handle_length/2,0])    handle(handle_bottom, handle_length, thickness);
    
   //translate([-head_width/2,0, 0])    head(head_width, head_height, thickness);