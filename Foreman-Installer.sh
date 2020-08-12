#!/bin/bash

if [[ -f /etc/foreman-installer/scenarios.d/last_scenario.yaml ]]
   then 
        echo "Foreman Already Installed"
   else
        sleep 180
	sudo foreman-installer --foreman-initial-admin-password "Welcome.1234567890" \
                       --enable-foreman-proxy-plugin-ansible \
                       --enable-foreman-proxy-plugin-openscap \
	               --enable-foreman-proxy-plugin-remote-execution-ssh \
	               --enable-foreman-plugin-remote-execution \
	               --enable-foreman-plugin-openscap \
	               --enable-foreman-plugin-ansible \
		       --skip-checks-i-know-better
	if [[ $?  == 0 ]]
    		then
      			foreman-rake foreman_openscap:bulk_upload:default
    	fi
fi
