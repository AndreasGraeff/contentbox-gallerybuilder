component extends="super"
{

	// default handler for contentbox-gallerybuilder
	function index(event,rc,prc){
		prc.cgp = checkGalleryPath();
		prc.galleries = galleryEntity.list(sortOrder="gallery_id DESC",asQuery=false);
		prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;
		event.setView(view="gallery/index", module="contentbox-gallerybuilder");
	}


	function editor(event, rc, prc)
	{
		prc.gallery = galleryEntity.get(event.getValue("gallery_id", 0));
		prc.images_per_page = "3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30";
		prc.images_in_table = "1,2,3,4,5,6,7,8,9,10";
		/*for ( i=1; i=3; i=i+1)
		{
			items_per_page = ListAppend(items_per_page, i, ",");
		}*/
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
			// Test for Images
			oImages = imageEntity.list(criteria={gallery_id=oGallery});
			if ( IsNull(oImages) )
			{
				galleryEntity.delete( oGallery );
				getPlugin("MessageBox").setMessage("info", "Gallery Deleted!");
			}
			else
			{
				getPlugin("MessageBox").setMessage("error", "Error Deleting Gallery!&lt;br&gt;Gallery Contains Images!");
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