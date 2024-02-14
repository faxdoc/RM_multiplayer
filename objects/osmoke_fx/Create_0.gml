hsp=0;
vsp=0;
duration=20+random_fixed(30);
spd =  (.6+random_fixed(5))*.5;
frc = .85+random_fixed(.05);
dir = random_fixed(360);

size = (.4+random_fixed(.6) )*.8;
spin = (6+random_fixed(9))*choose_fixed(-1,1)*2;
spn_frc = .985+random_fixed(.01);
image_xscale = 0;
image_yscale = 0;
size_mult = 1;

depth = 6;

image_blend = merge_color(c_dkgray,c_darkest,.5);
image_index = random_fixed(image_number);

do_size = true;
offset = random_fixed(1);

