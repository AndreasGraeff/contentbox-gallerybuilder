/* A content box module to create a pagenated image gallery with lightbox support. */
component
{
	// Module Properties
	this.title 				= "contentbox-gallerybuilder";
	this.author 			= "Andreas Graeff";
	this.webURL 			= "http://www.artificial-images.de";
	this.description 		= "A content box module to create a pagenated image gallery with lightbox support.";
	this.version			= "0.0.1";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "cbGalleryBuilder";


	function configure()
	{
		// default module settings
		defaultSettings = {
			GALLERY_PATH = "gallery",
			SIZE_IMAGE = 250
		};
		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="gallery",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];
		// Interceptors
		interceptors = [
			{ class="#moduleMapping#.interceptors.CBGRequest", properties={ entryPoint="cbadmin" }, name="CBGRequest@cbGalleryBuilder" }
		];
	}


	function onLoad()
	{
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) )
		{
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			var href = menuService.buildModuleLink('cbGalleryBuilder','gallery.index');
			menuService.addSubMenu(topMenu=menuService.MODULES,name="cbGalleryBuilder",label="Gallery Builder",href="#href#");
		}
	}


	function onActivate()
	{
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var findArgs = {name="gallery_builder"};
		var setting = settingService.findWhere(criteria=findArgs);
		if (isNull(setting))
		{
			var args = {name="gallery_builder", value=serializeJSON( defaultSettings )};
			var galleryBuilderSettings = settingService.new(properties=args);
			settingService.save( galleryBuilderSettings );
		}
		settingService.flushSettingsCache();
	}


	function onUnload()
	{
		if( structKeyExists( controller.getSetting("modules"), "contentbox" ) ){
			var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
			menuService.removeSubMenu(topMenu=menuService.MODULES,name="cbGalleryBuilder");
		}
	}


	function onDeactivate()
	{
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="gallery_builder"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
	}
}