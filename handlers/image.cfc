component extends="super"
{
	property name="editorService"		inject="id:editorService@cb";


	function index(event,rc,prc)
	{
		prc.gallery = [];
		prc.gallery_id = 0;
		// working both with parameters gallery_id or image_id, one of it is required
		if ( event.getValue("image_id", 0) gt 0 )
		{
			prc.image = imageEntity.get(event.getValue("image_id", 0));
			prc.gallery = prc.image.getGallery_id();
			prc.gallery_id = prc.gallery.getGallery_id();
		}
		else if ( event.getValue("gallery_id", 0) )
		{
			prc.gallery = galleryEntity.get(event.getValue("gallery_id", 0));
			prc.gallery_id = event.getValue("gallery_id", 0);
		}
		// list of images
		if ( IsDefined("prc.gallery") and IsObject(prc.gallery) )
		{
			prc.gallery_name = "Images In Gallery #chr(34)##prc.gallery.getName()##chr(34)#";
			prc.images = imageEntity.list(criteria={gallery_id=prc.gallery}, sortOrder="image_id DESC", asQuery=false);
		}
		else
		{
			prc.gallery_name = "Unknown Gallery";
			prc.images = [];
		}
		prc.xehCreate = event.buildLink(prc.xehImageEditor) & '/gallery_id/#prc.gallery_id#';
		// since V1.0 image will be shown in gallery injected below the gallery
		event.setLayout(name="ajax", module="contentbox-admin");
		event.setView(view="image/index", module="contentbox-gallerybuilder");
	}


	function editor(event, rc, prc)
	{
		prc.ckHelper = getMyPlugin(plugin="CKHelper",module="contentbox-admin");
		prc.editors = editorService.getRegisteredEditorsMap();
		prc.defaultEditor = "ckeditor";
		prc.cbAdminRoot = getContextRoot() & event.getModuleRoot('contentbox-admin') & "/views";
		prc.oEditorDriver = editorService.getEditor(prc.defaultEditor);
		prc.markups = editorService.getRegisteredMarkups();

		prc.image = imageEntity.get(event.getValue("image_id", 0));
		prc.image.setImage(prepareEditorContent(prc.image.getImage()));
		prc.image.setThumb(prepareEditorContent(prc.image.getThumb()));
		prc.gallery_id = event.getValue("gallery_id", 0);
		prc.gallery = galleryEntity.get(prc.gallery_id);
		prc.galleries = galleryEntity.list(sortOrder="gallery_id ASC",asQuery=false);
		// CKEditor EntryPoints
		prc.xehAuthorEditorSave = "#prc.cbAdminEntryPoint#.authors.changeEditor";
		prc.xehSlugify			= "#prc.cbAdminEntryPoint#.images.slugify";
		prc.xehSlugCheck		= "#prc.cbAdminEntryPoint#.content.slugUnique";
		prc.xehCancel			= event.buildLink(prc.xehImage);
		if ( IsObject(prc.gallery) )
			prc.xehCancel = prc.xehCancel & '/gallery_id/#event.getValue("gallery_id", 0)#';
		prc.tabContent = true;
		prc.tabContent_pages = true;
		event.setView("image/editor");
	}


	function save(event,rc,prc)
	{
		var oImage = populateModel( imageEntity.get(id=rc.image_id) );
		var oGallery = populateModel( galleryEntity.get(id=rc.gallery_id) );
		oImage.setGallery_id(oGallery);
		if ( oImage.getImage_id() eq "" )
		{
			oImage.setCreated_at(now());
		}
		oImage.setImage(extractEditorContent(oImage.getImage()));
		oImage.setThumb(extractEditorContent(oImage.getThumb()));
		if ( not event.valueExists("visible") )
		{
			oImage.setVisible(false);
		}
		var errors = oImage.validate();
		if ( arrayLen(errors) eq 0 )
		{
			imageEntity.save(oImage);
			getPlugin("MessageBox").info("Image saved!");
			setNextEvent(event=prc.xehGallery);
		}
		else
		{
			flash.persistRC(exclude="event");
			getPlugin("MessageBox").warn(messageArray=errors);
			setNextEvent(event=prc.xehImageEditor,queryString="image_id=#oImage.getImage_id()#");
		}
	}


	function delete(event,rc,prc)
	{
		var delete_images = event.getValue("delete_images", "");
		var length = ListLen(delete_images,",");
		if ( length )
		{
			for ( i = 1; i lte length; i=i+1 )
			{
				var oImage = imageEntity.get( int(ListGetAt(delete_images,i,",")) );
				imageEntity.delete( oImage );
			}
			getPlugin("MessageBox").setMessage("info", "#length# Image(s) Deleted!");
		}
		else
			getPlugin("MessageBox").setMessage("error", "Delete Error, No Image Selected!");
		setNextEvent(prc.xehGallery);
	}
}