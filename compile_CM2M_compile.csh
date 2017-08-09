#!/bin/tcsh
# compile script for experiment CM2M_compile
# created at 20091016.131207 using $Id: FRE.pm,v 17.0 2009/08/10 20:51:45 fms Exp $ 
unalias *
set echo

setenv siteConfig $HOME/fre3/site/fre.cshrc
if ( -f $siteConfig ) source $siteConfig
if ( ! $?FREROOT ) then
  echo "ERROR: FREROOT is not set.  Please source fre.cshrc"
endif
set root = $HOME/Riga_Chlorophyl/Riga_Grace_acdm
cd $HOME/Riga_Chlorophyl/CM2M_compile/exec-hpcs

        
module load openmpi/gcc/64/1.8.1
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

        #module load intelmpi/impi-3.2.2.006
	#module load java/ibm-java-x86_64-60
setenv NC_BLKSZ 64K
setenv MPI_COREDUMP_DEBUGGER `which idb`
      
      
#setenv MAKEFLAGS jobs=8
# MAP set TEMPLATE = "$FREROOT/site/mkmf.template.ia64_flt_hdf_scinet_kerr"
set TEMPLATE = "$FREROOT/site/mkmf.template.login2"
#--------------- write Makefile   -------------------
cat >$HOME/Riga_Chlorophyl/CM2M_compile/exec-hpcs/Makefile <<END
# Makefile for experiment CM2M_compile
# created at 20091016.131207 

include $TEMPLATE

fms_CM2M_compile.x: libcoupler.a libmom4p1.a libocean_shared.a libatmos_dyn.a libice.a libatmos_phys.a libland.a libfms.a
	\$(LD) \$^ \$(LDFLAGS) -o \$@ 

libcoupler.a: libfms.a libmom4p1.a libatmos_dyn.a libatmos_phys.a libland.a libice.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_coupler coupler
	$MKMF -s coupler -m Makefile.coupler -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libcoupler.a -t $TEMPLATE pathnames_coupler pathnames_mom4p1 pathnames_ocean_shared pathnames_atmos_dyn pathnames_ice pathnames_atmos_phys pathnames_land pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.coupler \$@

#cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o \$(patsubst lib%.a, pathnames_%, \$@) \$(patsubst lib%.a, %, \$@)
#$MKMF -s \$(patsubst lib%.a, %, \$@) -m Makefile.\$(patsubst lib%.a, %, \$@) -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p \$@ -t $TEMPLATE \$(patsubst lib%.a, pathnames_%, \$^) shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 

libfms.a:  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_fms shared
	$MKMF -s shared -m Makefile.fms -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libfms.a -t $TEMPLATE -c "-Duse_libMPI -Duse_netCDF -Duse_netCDF3"  pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.fms \$@

libmom4p1.a: libfms.a libocean_shared.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_mom4p1 mom4p1
	$MKMF -s mom4p1 -m Makefile.mom4p1 -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libmom4p1.a -t $TEMPLATE -c "-DUSE_OCEAN_BGC"  pathnames_mom4p1 pathnames_ocean_shared pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.mom4p1 \$@

libocean_shared.a: libfms.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_ocean_shared ocean_shared
	$MKMF -s ocean_shared -m Makefile.ocean_shared -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libocean_shared.a -t $TEMPLATE  pathnames_ocean_shared pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.ocean_shared \$@

libatmos_phys.a: libfms.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_atmos_phys atmos_param atmos_shared
	$MKMF -s "atmos_param atmos_shared" -m Makefile.atmos_phys -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libatmos_phys.a -t $TEMPLATE  pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.atmos_phys \$@

libatmos_dyn.a: libfms.a libatmos_phys.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_atmos_dyn atmos_coupled atmos_fv_dynamics
	$MKMF -s "atmos_coupled atmos_fv_dynamics" -m Makefile.atmos_dyn -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libatmos_dyn.a -t $TEMPLATE -c "-DSPMD" pathnames_atmos_dyn pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.atmos_dyn \$@

libice.a: libfms.a libatmos_phys.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_ice ice_sis ice_param
	$MKMF -s "ice_sis ice_param" -m Makefile.ice -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libice.a -t $TEMPLATE  pathnames_ice pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.ice \$@

libland.a: libfms.a  FORCE
	cd $HOME/Riga_Chlorophyl/CM2M_compile/src ; $LISTPATHS -o pathnames_land land_lad land_param
	$MKMF -s "land_lad land_param" -m Makefile.land -a $HOME/Riga_Chlorophyl/CM2M_compile/src -p libland.a -t $TEMPLATE -c "-DLAND_BND_TRACERS"  pathnames_land pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.land \$@

FORCE:

clean:
	make -f Makefile.coupler clean
	make -f Makefile.fms clean
	make -f Makefile.mom4p1 clean
	make -f Makefile.ocean_shared clean
	make -f Makefile.atmos_phys clean
	make -f Makefile.atmos_dyn clean
	make -f Makefile.ice clean
	make -f Makefile.land clean


END
#--------------- compile commands -------------------

make fms_CM2M_compile.x
if ( $status ) then
    unset echo
    echo ERROR: make failed for CM2M_compile.
    exit 1
else
    unset echo
    echo NOTE: make succeeded for CM2M_compile.
endif
