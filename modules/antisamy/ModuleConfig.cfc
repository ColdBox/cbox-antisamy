/**
*********************************************************************************
* Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component {

	// Module Properties
	this.title 				= "antisamy";
	this.author 			= "Ortus Solutions, Corp";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "Leverages the AntiSamy libraries for XSS cleanups";
	this.version			= "1.0.0+@build.number@";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "antisamy";
	// Module Dependencies That Must Be Loaded First, use internal names or aliases
	this.dependencies		= [ "javaloader" ];

	function configure(){
		// Custom Declared Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.AutoClean", name="AutoClean@AntiSamy" }
		];
	}

	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		var settings = controller.getConfigSettings();
		// parse parent settings
		parseParentSettings();
		// Class load antisamy
		controller.getWireBox().getInstance( "loader@javaloader" ).appendPaths( settings.antisamy.libPath );
	}

	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){

	}

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var antisamyDSL 	= oConfig.getPropertyMixin( "antisamy", "variables", structnew() );

		//defaults
		configStruct.antisamy = {
			// The library path
			libPath = modulePath & "/models/lib",
			// Activate auto request capture cleanups
			autoClean = false,
			// Default Policy to use, available are: antisamy, ebay, myspace, slashdot and tinymce
			defaultPolicy = "ebay",
			// Custom Policy absolute path, leave empty if not used
			customPolicy = ""
		};

		// incorporate settings
		structAppend( configStruct.antisamy, antisamyDSL, true );

	}

}