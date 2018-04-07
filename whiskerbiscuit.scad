// Arnsteio, 2018

// Makes a whiskerbiscuit suitable for slingbows

$fn=150;

module whiskerbiscuit(dia,width,fletching_cuts, shaft_dia)
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
                rotate([0,0,degrees]) cube([dia-2, 0.5, width], center=true);
            }//for
        translate([0, 0, width/2+0.3]) resize([0,0,width*2]) sphere(d=dia-2); // make middle of biscuit flexible. This gives last bit as 0,15mm*2, which is usually 2 thicknesses of plastic
        cylinder(h=width, d=shaft_dia, center=true);
    } //Diff
}

whiskerbiscuit(62.5, 25, 60, 8);
