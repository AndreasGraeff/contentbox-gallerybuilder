component extends="super"
{
property name="tag"					inject="coldbox:myPlugin:tag@contentbox-gallerybuilder";

	function index(event,rc,prc)
	{
		checkGalleryPath();
		prc.galleries = galleryEntity.list(sortOrder="gallery_id ASC",asQuery=false);
		prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;
		event.setView(view="gallery/index", module="contentbox-gallerybuilder");
	}


	function editor(event, rc, prc)
	{
		prc.gallery = galleryEntity.get(event.getValue("gallery_id", 0));
		prc.images_in_table = "";
		for ( i = 1; i lte 10; i=i+1 )
			prc.images_in_table = ListAppend(prc.images_in_table, i, ",");
		prc.images_per_page = "";
		for ( i = 1; i lte 30; i=i+1 )
			prc.images_per_page = ListAppend(prc.images_per_page, i, ",");
		event.setView("gallery/editor");
	}


	function save(event,rc,prc)
	{
		var oGallery = populateModel( galleryEntity.get(id=rc.gallery_id) );
		if ( oGallery.getGallery_id() eq "" )
		{
			oGallery.setCreated_at(now());
		}
		else
		{
			oGallery.setUpdated_at(now());
		}
		if ( not event.valueExists("use_lightbox") )
		{
			oGallery.setUse_Lightbox(false);
		}
		var errors = oGallery.validate();
		if ( arrayLen(errors) eq 0 )
		{
			galleryEntity.save(oGallery);
			getPlugin("MessageBox").info("Gallery saved!");
			setNextEvent(event=prc.xehGallery,queryString="gallery_id=#oGallery.getGallery_id()#");
		}
		else
		{
			flash.persistRC(exclude="event");
			getPlugin("MessageBox").warn(messageArray=errors);
			setNextEvent(event=prc.xehGalleryEditor,queryString="gallery_id=#oGallery.getGallery_id()#");
		}
	}


	function delete(event,rc,prc)
	{
		var oGallery	= galleryEntity.get( rc.gallery_id );
		if( IsNull(oGallery) )
		{
			getPlugin("MessageBox").setMessage("warning", "Invalid Formular detected!");
		}
		else
		{
			// test for images in gallery
			oImages = imageEntity.list(criteria={gallery_id=oGallery});
			if ( len(oImages) eq 0 )
			{
				galleryEntity.delete( oGallery );
				getPlugin("MessageBox").setMessage("info", "Gallery Deleted!");
			}
			else
			{
				getPlugin("MessageBox").setMessage("error", "Error Deleting Gallery! Gallery Contains Images!");
			}
		}
		setNextEvent(prc.xehGallery);
	}


	// installation check: ORM must be loaded (it's not clearly visible for user and though can cause crashes)
	function doORMReload(event, rc, prc)
	{
		event.setView(view="gallery/doORMReload",module="contentbox-gallerybuilder");
	}
}