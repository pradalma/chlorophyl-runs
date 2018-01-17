# chlorophyl-runs
New ensemble runs, AND run a longer spin up.
Currently idl waiting on HHPC help desk to fix the following issue: 

forrtl: error (78): process killed (SIGTERM)


cp -r /datascope/pradal-esm/gkfiles/Riga_versions_GK/Riga_Grace_acdm /home/pradalma/Riga_Chlorophyl/.
in scripts: look at acdm_300yr and 
acdm_doublingCO2

Need to recompile the executable so that it works on V2 HHPC (different queue, use of modules)
cp /home/pradalma/Riga/scripts/script_to_run_on_login2 .

need to copy the begining of the new script file and source that before recompiling, or edit the compile script to load modules. 
Not sure...
How did I recompile when we migrated to login2?
In /home/pradalma/Riga/CM2M_compile/exec-hpcs there is a compile_login2_CM2M_compile.csh script 
cp compile_login2_CM2M_compile.csh /home/pradalma/Riga_Chlorophyl/Riga_Grace_acdm/CM2M_compile/exec-hpcs/.

go back to 
/home/pradalma/Riga_Chlorophyl/Riga_Grace_acdm/CM2M_compile/exec-hpcs
make clean

edit compile_CM2M_compile.csh based on compile_login2_CM2M_compile.csh
Notice that root in compile_CM2M_compile is set to $HOME/Riga_Grace_acdm. Change this!!!
what makefile should I use? --> cat Makefile
template should be the same that I used from login2 I think
set TEMPLATE = "$FREROOT/site/mkmf.template.login2"
cat >$HOME/Riga/CM2M_compile/exec-hpcs/Makefile <<END

cat >$HOME/Riga_Grace_acdm/CM2M_compile/exec-hpcs/Makefile <<END

Editing the make file: look at the Makefile uploaded into this repository
Editing the compile.sh: look at the compile.sh uploaded into this repository
Editing the script: look at the script uploaded into this repository


THINGS TO REMEMBER:

we go back and forth between bash and csh or tcsh. This means that the declaration of enviroment variables varies, and that the module load XXX command may or may not work. 
For instance, when running the compile.sh script, the module load commands are ineffective. One is better off copying these lines: module load openmpi/gcc/64/1.8.1
module load openmpi/intel/1.8.4
module load nco/4.5.2
module load gcc
module load slurm
module load netcdf/intel/4.3.3.1
module load netcdf-fortran/intel/4.4.2
module load netcdf/gcc/64/4.3.1.1
module load hdf5/intel
module load udunits2
module load zlib
module load libjpeg
module load libpng
module load jasper

 and executing them in the shell window, not from the compile.sh 
 
 If one relies on these lines to be read from the compile.sh script, the compilation will simply fail.
 Also, 
 In August 2017 appeared a new error message that I do not recall seeing back in February when the migration to login2 was done. Again, in the shell command line, prior to running the compile script, one has to declare these 2 lines LANG=en_US.utf8
LC_ALL=en_US.utf8 to fix this error:    Catastrophic error: could not set locale "" to allow processing of multibyte characters

