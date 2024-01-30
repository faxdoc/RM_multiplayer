exit;
DSC(image_blend);DSA(image_alpha);
var dfx = x-(x - xprevious)*2;
var dfy = y-(y - yprevious)*2;
draw_line_width(x,y,dfx,dfy,1);DSA(1);
DSC(c_white);
