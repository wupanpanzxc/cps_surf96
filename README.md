# cps_surf96
At the beginning, make sure that you have installed the CPS software packages. related installation guide, please refer to https://seismo-learn.org/software/cps/intro/

This paper introduces how to use surf96 program in CPS software package for surface wave dispersion inversion.
Firstly,You need to prepare two input files, disp. dat and vs.dat. disp. dat is the dispersion information file, and the two columns correspond to the period (s) and speed (km/s) respectively. vs.dat is the initial velocity model, with two columns corresponding to depth (km) and shear wave velocity (km/s).
Secondly, you need to convert the two input files to the specified format (see the CPS official manual for details). An example of this program is given in cpsinv.sh.
