# Makefile for experiment CM2M_compile
# created at 20091016.131207 

include /home/pradalma/fre3/site/mkmf.template.login2

fms_CM2M_compile.x: libcoupler.a libmom4p1.a libocean_shared.a libatmos_dyn.a libice.a libatmos_phys.a libland.a libfms.a
	$(LD) $^ $(LDFLAGS) -o $@ 

libcoupler.a: libfms.a libmom4p1.a libatmos_dyn.a libatmos_phys.a libland.a libice.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_coupler coupler
	/home/pradalma/fre3/bin/mkmf -s coupler -m Makefile.coupler -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libcoupler.a -t /home/pradalma/fre3/site/mkmf.template.login2 pathnames_coupler pathnames_mom4p1 pathnames_ocean_shared pathnames_atmos_dyn pathnames_ice pathnames_atmos_phys pathnames_land pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.coupler $@

#cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o $(patsubst lib%.a, pathnames_%, $@) $(patsubst lib%.a, %, $@)
#/home/pradalma/fre3/bin/mkmf -s $(patsubst lib%.a, %, $@) -m Makefile.$(patsubst lib%.a, %, $@) -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p $@ -t /home/pradalma/fre3/site/mkmf.template.login2 $(patsubst lib%.a, pathnames_%, $^) shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 

libfms.a:  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_fms shared
	/home/pradalma/fre3/bin/mkmf -s shared -m Makefile.fms -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libfms.a -t /home/pradalma/fre3/site/mkmf.template.login2 -c "-Duse_libMPI -Duse_netCDF -Duse_netCDF3"  pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.fms $@

libmom4p1.a: libfms.a libocean_shared.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_mom4p1 mom4p1
	/home/pradalma/fre3/bin/mkmf -s mom4p1 -m Makefile.mom4p1 -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libmom4p1.a -t /home/pradalma/fre3/site/mkmf.template.login2 -c "-DUSE_OCEAN_BGC"  pathnames_mom4p1 pathnames_ocean_shared pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.mom4p1 $@

libocean_shared.a: libfms.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_ocean_shared ocean_shared
	/home/pradalma/fre3/bin/mkmf -s ocean_shared -m Makefile.ocean_shared -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libocean_shared.a -t /home/pradalma/fre3/site/mkmf.template.login2  pathnames_ocean_shared pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.ocean_shared $@

libatmos_phys.a: libfms.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_atmos_phys atmos_param atmos_shared
	/home/pradalma/fre3/bin/mkmf -s "atmos_param atmos_shared" -m Makefile.atmos_phys -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libatmos_phys.a -t /home/pradalma/fre3/site/mkmf.template.login2  pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.atmos_phys $@

libatmos_dyn.a: libfms.a libatmos_phys.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_atmos_dyn atmos_coupled atmos_fv_dynamics
	/home/pradalma/fre3/bin/mkmf -s "atmos_coupled atmos_fv_dynamics" -m Makefile.atmos_dyn -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libatmos_dyn.a -t /home/pradalma/fre3/site/mkmf.template.login2 -c "-DSPMD" pathnames_atmos_dyn pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.atmos_dyn $@

libice.a: libfms.a libatmos_phys.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_ice ice_sis ice_param
	/home/pradalma/fre3/bin/mkmf -s "ice_sis ice_param" -m Makefile.ice -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libice.a -t /home/pradalma/fre3/site/mkmf.template.login2  pathnames_ice pathnames_atmos_phys pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.ice $@

libland.a: libfms.a  FORCE
	cd /home/pradalma/Riga_Chlorophyl/CM2M_compile/src ; /home/pradalma/fre3/bin/list_paths -o pathnames_land land_lad land_param
	/home/pradalma/fre3/bin/mkmf -s "land_lad land_param" -m Makefile.land -a /home/pradalma/Riga_Chlorophyl/CM2M_compile/src -p libland.a -t /home/pradalma/fre3/site/mkmf.template.login2 -c "-DLAND_BND_TRACERS"  pathnames_land pathnames_fms shared/mpp/include mom4p1/ocean_param/gotm-4.0/include shared/include 
	make -f Makefile.land $@

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


