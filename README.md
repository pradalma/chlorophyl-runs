# chlorophyl-runs
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



