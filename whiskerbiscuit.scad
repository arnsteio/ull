// Arnsteio, 2018

// Makes a whiskerbiscuit suitable for slingbows

$fn=150;
vres=0.15; // vertical resolution of printer
hres=0.4;
wall_thickness=0.5;
module solid_whiskerbiscuit(dia,width,fletching_cuts, shaft_dia)
/*
Builds the whiskerbiscuit
Arguments:
    Diameter of slingbow cutout
    Thickness of slingbow
    Number of cutouts for arrow fletchings
    Diameter of arrow (usually not useful but IMO the model is prettier with it in)
*/
{
step=360/fletching_cuts;// sets number of cutouts

difference ()
    {
        cylinder(h=width, d=dia, center=true);
            for (degrees = [0:step:360]) {
                rotate([0,0,degrees]) cube([dia-wall_thickness*2, 0.5, width], center=true);
            }//for
        translate([0, 0, width/2+vres*2]) resize([0,0,width*2]) sphere(d=dia-wall_thickness*2); // make middle of biscuit flexible. This gives last bit as 0,15mm*2, which is usually 2 thicknesses of plastic
        cylinder(h=width, d=shaft_dia, center=true);
    } //Diff
}

module whiskerbiscuit(dia,width,shaft_supports, shaft_dia)
/*
Builds the whiskerbiscuit
Arguments:
    Diameter of slingbow cutout
    Thickness of slingbow
    Number of brushes that give arrow supports
    Diameter of arrow
*/
    {
    step=360/shaft_supports; // To place shaft supports evenly 

    difference ()
        {
            // wall
            cylinder(h=width, d=dia, center=true);
            cylinder(h=width, d=dia-wall_thickness*2, center=true);
        }
        
    difference () // Brushes
        {
            for (degrees = [0:step:360]) { // whisker biscuit "brushes"
                    rotate([0,0,degrees]) cube([dia-wall_thickness*2, hres*1.05, width], center=true);
                    }//for
            translate([0, 0, width/2+vres*2]) resize([0,0,width*2]) sphere(d=dia-wall_thickness*2); // This gives middle bit twice the printing thickness, for flexibility
            cylinder(h=width, d=shaft_dia*1.05, center=true); // Cutout for shaft
        } // Brushes diff
} //Module


whiskerbiscuit(62.5, 10, 50, 8);
