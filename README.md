*"Snorre sier at Ull kalles skiguden, bueguden, jaktguden og skjoldguden"*

# An open source, 3D-printable, reconfigurable slingbow. 

I'll post my waypoints as I progress towards the target:

## ull

Proof of concept. Standard slingshot, 3-hole BTF (Behind The Fork) tube attachment. 

## ull_v2

Same as above but decorated and with integral print support. 3-hole BTF tube attachment.
Test printed at 80% of full size, 1mm shell, 25% gradual infill. A number of issues were found and addressed.

## ull_v3 

Issues with v2 fixed. Some notes and suggestions for v4:
- If we wish to only do "thumb and brace" the handle can be 17mm shorter.
- Turn design upside down?
- Writing on surface?

v3 probably usable but haven't printed it yet. 


## ull_v4

Plain v3 but with decorations.
Have test printed: 100% size, 1mm shell, 30% constant infill, 2mm brim. 
Print went well but decorations need more work.

# Building

While a minimal test build to check structure only takes a few minutes, 
a proper test build takes an hour, and is necessary for most visuals.
And final builds take several hours. Hence, a build host apart from my 
day-to-day machine is useful.

I use git-hooks (symlinked from the /bin directory) to push to Github, 
pull to my build machine (a 4-core, 16MB Linux machine implememted on the 
UH-IaaS Openstack instance) and do builds. 

