#!bin/bash


surf96 39
surf96 36 1
surf96 32 10000
surf96 37 10 1 2 6
surf96 1 2
surf96 27 disp.d.syn
surf96 28 modl.d.syn
surf96 39

gmt begin disp png
J=X4i/2i
R=0.0/20/1.0/4.0
grep R disp.d | grep C | awk '{print $6,$7}' | gmt psxy -J$J -R$R -Bxa+l"Period (s)" -Bya+l"c (km/s)" -Sc0.05i -Wred -Gred
grep R disp.d.syn | grep C | awk '{print $6,$7}' | gmt psxy -J$J -R$R -W1
echo "S 0.1i c 0.05i red - 0.3i Observe\nS 0.1i - 0.3i 1 - 0.3i Final" |gmt legend -DjBR+w2.5c+o0.2c/0.2c -C0.1i/0.1i -F
gmt end

gmt begin vs png
J=X4i/-8i
R=1.5/5.0/0/50
awk 'NR>12' modl.d | awk '$1>0.0' | awk 'BEGIN{h=0}{h=h+$1; print h,$3}' | awk 'BEGIN{z=0}{vs=$2; print vs,z; z=$1; print vs,z}' | gmt psxy -J$J -R$R -Bxa+l"Vs (km/s)" -Bya+l"Depth (km)" -W5,blue
awk 'NR>12' modl.d.syn | awk '$1>0.0' | awk 'BEGIN{h=0}{h=h+$1; print h,$3}' | awk 'BEGIN{z=0}{vs=$2; print vs,z; z=$1; print vs,z}' | gmt psxy -J$J -R$R -W5,red
echo "S 0.1i - 0.3i - 5,blue,- 0.3i Initial\nS 0.1i - 0.3i - 5,red 0.3i Final" | gmt legend -DjBR+w2.5c+o0.2c/0.2c -C0.1i/0.1i -F 
gmt end show