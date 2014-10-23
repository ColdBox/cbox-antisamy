/********************************************************************************
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
* This Interceptor if activated automatically cleans the request collection for you
* @author Luis Majano <lmajano@ortussolutions.com>
*/
component extends="coldbox.system.Interceptor"{

	// DI: This is a provider as it needs to javaload first
	property name="antisamy" inject="provider:AntiSamy@AntiSamy";

	// On request capture
	function onRequestCapture( event, interceptData, buffer ){
		// if not activated, just exist
		if( getSetting( "antiSamy" ).autoClean ){ return; }
		// rc reference
		var rc = event.getCollection();

		// cleanup
		for( var key in rc ){
			if( structKeyExists( rc, key ) and isSimpleValue( rc[ key ] ) ){
				rc[ key ] = antiSamy.clean( rc[ key ] );
			}
		}
	}

}