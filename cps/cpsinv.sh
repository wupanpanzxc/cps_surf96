#!/bin/bash
# This script is to obtain a 1D vs model using cps software.
# input:
#	vsav.dat:  initial model data, have a format of "depth(km) velocity (km/s)"
#	averdisp.dat: input average Rayleigh wave phase velocity, have format of "period (s) velocity (km/s)"
# output:
#	disp.ps: dispersion fitting
#	vs.ps: inverted shear wave structure
#	modl.d.syn: the final model
# Song Luo, 2019/4/14


# prepare initial model to be used by cps
cat Vs.dat | awk 'BEGIN{print "modl.d\nhaha\n0\n"}{if(NR==1) thk=$1; else thk=$1-hp; hp=$1; vs=$2; vp=0.9409+2.0947*vs-0.8206*vs^2+0.2683*vs^3-0.0251*vs^4; rho=1.6612*vp-0.4721*vp^2+0.0671*vp^3-0.0043*vp^4+0.000106*vp^5; qp=1500.0; qs=600.0; etap=0.0; etas=0.0; frefp=1.0; frefs=1.0; print thk,vp,vs,rho,qp,qs,etap,etas,frefp,frefs}END{print 0,vp,vs,rho,qp,qs,etap,etas,frefp,frefs}' | mkmod96

# prepare dispersions to be used by cps
cat disp.dat | awk '{printf("%s %s %s %s %d %f %f %f\n"),"SURF96","R","C","X",0,$1,$2,0.01*$2}' > disp.d

# main procedures of cps inversion
echo 0.005 0.005 0. 0.005 0."\n"1 0 0 0 0 1 1 0 1 0"\n"modl.d"\n"disp.d > sobs.d

surf96 39
surf96 36 1
surf96 32 1
surf96 37 20 1 2 6
surf96 1 2
surf96 27 disp.d.syn
surf96 28 modl.d.syn
surf96 39

gmt begin disp png
J=X4i/2i
R=5/30/1.0/4.0
grep R disp.d | grep C | awk '{print $6,$7}' | gmt psxy -J$J -R$R -Bxa+l"Period (s)" -Bya+l"c (km/s)" -Sc0.05i -Wred -Gred
grep R disp.d.syn | grep C | awk '{print $6,$7}' | gmt psxy -J$J -R$R -W1
echo "S 0.1i c 0.05i red - 0.3i Observe\nS 0.1i - 0.3i 1 - 0.3i Final" |gmt legend -DjBR+w2.5c+o0.2c/0.2c -C0.1i/0.1i -F
gmt end show

gmt begin vs png
J=X4i/-8i
R=1.5/5.0/0/50
awk 'NR>12' modl.d | awk '$1>0.0' | awk 'BEGIN{h=0}{h=h+$1; print h,$3}' | awk 'BEGIN{z=0}{vs=$2; print vs,z; z=$1; print vs,z}' | gmt psxy -J$J -R$R -Bxa+l"Vs (km/s)" -Bya+l"Depth (km)" -W5,blue
awk 'NR>12' modl.d.syn | awk '$1>0.0' | awk 'BEGIN{h=0}{h=h+$1; print h,$3}' | awk 'BEGIN{z=0}{vs=$2; print vs,z; z=$1; print vs,z}' | gmt psxy -J$J -R$R -W5,red
echo "S 0.1i - 0.3i - 5,blue,- 0.3i Initial\nS 0.1i - 0.3i - 5,red 0.3i Final" | gmt legend -DjBR+w2.5c+o0.2c/0.2c -C0.1i/0.1i -F 
gmt end show




