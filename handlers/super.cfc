/* super class of gallery builder */
component
{
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

		// redirect user if ORM tables are not created
		if ( event.getCurrentEvent() NEQ "contentbox-gallerybuilder:gallery.doORMReload" and not isORMLoaded() )
		{
			setNextEvent("cbGalleryBuilder.gallery.doORMReload");
		}
		// create gallery path if not done
		//checkGalleryPath();
		// exit points
		prc.xehGallery			= "cbGalleryBuilder.gallery.index";
		prc.xehImage			= "cbGalleryBuilder.image.index";
		prc.xehGalleryEditor 	= "cbGalleryBuilder.gallery.editor";
		prc.xehImageEditor 		= "cbGalleryBuilder.image.editor";
		prc.xehGallerySave 		= "cbGalleryBuilder.gallery.save";
		prc.xehImageSave 		= "cbGalleryBuilder.image.save";
		prc.xehSettingsSave		= "cbGalleryBuilder.settings.save";
		prc.xehGalleryDelete	= "cbGalleryBuilder.gallery.delete";
		prc.xehImageDelete		= "cbGalleryBuilder.image.delete";
		// check if user is loged in
		if ( not prc.oAuthor.isLoaded() )
		{
			getPlugin("MessageBox").setMessage("warning","Please login!");
			setNextEvent(prc.xehLogin);
		}
		event.setLayout(name="admin", module="contentbox-admin");
		prc.tabModules = true;
		prc.tabModules_cbGalleryBuilder = true;
	}


	function slugify(event,rc,prc)
	{
		event.renderData(data=HTMLHelper.slugify( rc.slug ),type="plain");
	}


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


	public void function checkGalleryPath()
	{
		var fullpath = getModuleSettings( "contentbox-filebrowser" ).settings.directoryroot;
		var objSetting = settingService.findWhere( { name="gallery_builder" } );
		var settings = deserializeJSON(objSetting.getValue());
		fullpath = fullpath & "/" & settings.GALLERY_PATH;
		if ( not DirectoryExists(fullpath) )
		{
			DirectoryCreate(fullpath);
			getPlugin("MessageBox").setMessage("info","Gallery Path Created!");
		}
	}


	// should only be used by handlers
	private string function extractEditorContent(content)
	{
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
