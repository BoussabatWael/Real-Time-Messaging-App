#!/usr/bin/env bash

CONFIGFILE=settings.conf

source $CONFIGFILE

###### check config file ######
check_config(){
        [ ! -f $CONFIGFILE ] && close_on_error "Config file not found, make sure config file is correct"
}


### Make sure bins exists.. else close_on_error
check_cmds(){
        [ ! -x $GZIP ] && close_on_error "FILENAME $GZIP does not exists. Make sure correct path is set in $CONFIGFILE."
        [ ! -x $RM ] && close_on_error "FILENAME $RM does not exists. Make sure correct path is set in $CONFIGFILE."
        [ ! -x $MKDIR ] && close_on_error "FILENAME $MKDIR does not exists. Make sure correct path is set in $CONFIGFILE."
        [ ! -x $GREP ] && close_on_error "FILENAME $GREP does not exists. Make sure correct path is set in $CONFIGFILE."

	if [ $SFTP_ENABLE -eq 1 ]; then
		[ ! -x $SCP ] && close_on_error "FILENAME $SCP does not exists. Make sure correct path is set in $CONFIGFILE."
	fi
}


###### deploy app ######
deploy_app(){
        [ $VERBOSE -eq 1 ] && echo "*** Deploying App ... ***"

	${SCP} -r $FOLDER_LOCAL_PATH ${SFTP_USERNAME}@${SFTP_HOST}:${SFTP_UPLOAD_DIR}/

        [ $VERBOSE -eq 1 ] && echo "*** Deployment completed ***"

}

### close_on_error on demand with message ###
close_on_error(){
        echo "$@"
        exit 99
}


### main ####
check_config
check_cmds
deploy_app
