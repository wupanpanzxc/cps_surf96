# cps_surf96
At the beginning, make sure that you have installed the CPS software packages. related installation guide, please refer to https://seismo-learn.org/software/cps/intro/. The CPS source need to fill out the form to download, you can fill out the form at http://www.eas.slu.edu/eqc/eqc_cps/CPS/cpslisc.html and submit to get the source code.

This paper introduces how to use surf96 program in CPS software package for surface wave dispersion inversion.
Firstly,You need to prepare two input files, disp.dat and vs.dat. disp.dat is the dispersion information file, and the two columns correspond to the period (s) and speed (km/s) respectively. vs.dat is the initial velocity model, with two columns corresponding to depth (km) and shear wave velocity (km/s).

Secondly, you need to convert the two input files to the specified format. An example of this program is given in cpsinv.sh.The converted files will be stored in disp.d and modl.d respectively. In addition, sobs.d saves questions about the inversion setup, including input file names and inversion items (see the CPS official manual for details).

Then, run the program according to the menu in the manual and output the inversion results to modl.d.syn. The dispersion package of the model is stored in disp.d.syn.

Finally, draw the graph. GMT is used to plot the initial velocity model and the inversion velocity model, as well as the original dispersion and the theoretical dispersion obtained from the inversion velocity model.
