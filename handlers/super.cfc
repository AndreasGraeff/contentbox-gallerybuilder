/* super class of gallery builder */
component {
	// dependencies
	property name="galleryEntity"		inject="entityService:gallery";
	property name="imageEntity"			inject="entityService:image";
	property name="settingService" 		inject="settingService@cb";
	property name="htmlHelper" 			inject="coldbox:plugin:HTMLHelper";


	// Coldbox module preHandler
	function preHandler(event,action,eventArguments)
	{
		var rc 	= event.getCollection();
		var prc = event.getCollection(private=true);

		// get module root
		prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;

		// if data isn't setup, redirect user
		if ( event.getCurrentEvent() NEQ "contentbox-gallerybuilder:gallery.doORMReload" and not isORMLoaded() )
		{
			//getPlugin("MessageBox").setMessage("warning","Module installation is not fineshed, please reload ORM!");
			// TODO: better redirect, buttons are active -> error !, message does not disapear after ORM-Reload
			setNextEvent("cbGalleryBuilder.gallery.doORMReload");
		}
		// create gallery path if not done
		checkGalleryPath();

		// exit points
		prc.xehGallery			= "cbGalleryBuilder.gallery.index";
		prc.xehImage			= "cbGalleryBuilder.image.index";
		prc.xehGalleryEditor 	= "cbGalleryBuilder.gallery.editor";
		prc.xehImageEditor 		= "cbGalleryBuilder.image.editor";
		prc.xehGallerySave 		= "cbGalleryBuilder.gallery.save";
		prc.xehImageSave 		= "cbGalleryBuilder.image.save";
		prc.xehSettingsSave		= "cbGalleryBuilder.settings.save";

		// TODO
		//check login and redirect is needed.
		/*if(!prc.oAuthor.isLoaded()){
			getPlugin("MessageBox").setMessage("warning","Please login!");
			setNextEvent(prc.xehLogin);
		}*/

		// use the CB admin layout
		event.setLayout(name="admin", module="contentbox-admin");
		// tab control
		prc.tabModules = true;
		prc.tabModules_cbGalleryBuilder = true;
	}


	// help function to detect if ORM is loaded
	public Boolean function isORMLoaded()
	{
		try
		{
			var testGallery = EntityLoad( "gallery" );
			var testGallery = EntityLoad( "image" );
			return true;
		}
		catch( any e ) { return false; }
	}


	// TODO with setting
	public any function checkGalleryPath()
	{
		var fullpath = getModuleSettings( "contentbox-filebrowser" ).settings.directoryroot;
		var objSetting = settingService.findWhere( { name="gallery_builder" } );
		var settings = deserializeJSON(objSetting.getValue());
		fullpath = fullpath & "/" & settings.GALLERY_PATH;
		//crudSetting = serializeJSON({"gallery_path"=rc.gallery_path});
		//newProperty = deserializeJSON(crudSetting);
		//fullpath = fullpath & deserializeJSON(jsonSetting);
		if ( DirectoryExists(fullpath) )
		{
			return fullpath & DirectoryExists(fullpath);
			//DirectoryCreate(fullpath);
		}
		//			return fullpath;
		return "Does not exist";
	}


	private string function extractEditorContent(content)
	{
		//return "/index.cfm/__media/gallery/am-wasser/TN_02_034_DSC_6999.jpg";
		var src = "";
		var p = "";
		try {
			// if the values of editorimage are not in this format, we return ""
			p = XmlSearch(content, "p");
			src = p[1].xmlchildren[1].xmlAttributes.src;
		}
		catch (any except){};
		return src;
	}


	public string function prepareEditorContent(path)
	{
		var content = path;
		if ( len(path) gt 0 )
			content = HTMLHelper.p(HTMLHelper.img(src=path));
		return content;
	}
}
