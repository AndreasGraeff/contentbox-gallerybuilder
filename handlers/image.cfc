component extends="super"
{

	function index(event,rc,prc)
	{
		prc.gallery = [];
		// working both with parameters gallery_id or image_id, one of it is required
		if ( event.getValue("image_id", 0) gt 0 )
		{
			prc.image = imageEntity.get(event.getValue("image_id", 0));
			prc.gallery = prc.image.getGallery_id();
		}
		else if ( event.getValue("gallery_id", 0) )
		{
			prc.gallery = galleryEntity.get(event.getValue("gallery_id", 0));
		}
		// list of images
		if ( IsDefined("prc.gallery") and IsObject(prc.gallery) )
		{
			prc.gallery_name = "Images In Gallery #chr(34)##prc.gallery.getName()##chr(34)#";
			prc.images = imageEntity.list(criteria={gallery_id=prc.gallery},asQuery=false);
		}
		else
		{
			prc.gallery_name = "Unknown Gallery";
			prc.images = [];
		}
		prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;
		prc.imageEntity = imageEntity;
		event.setView(view="image/index", module="contentbox-gallerybuilder");
	}


	function editor(event, rc, prc)
	{
		prc.image = imageEntity.get(event.getValue("image_id", 0));
		prc.gallery = galleryEntity.get(event.getValue("gallery_id", 0));
		prc.galleries = galleryEntity.list(sortOrder="gallery_id DESC",asQuery=false);
		event.setView("image/editor");
	}


	function save(event,rc,prc){
		var oImage = populateModel( imageEntity.get(id=rc.image_id) );
		var oGallery = populateModel( galleryEntity.get(id=rc.gallery_id) );
		oImage.setGallery_id(oGallery);
		if ( oImage.getImage_id() eq "" )
		{
			oImage.setCreated_at(now());
		}
		if ( not event.valueExists("visible") )
		{
			oImage.setVisible(false);
		}
		var errors = oImage.validate();
		if ( arrayLen(errors) eq 0 )
		{
			imageEntity.save(oImage);
			getPlugin("MessageBox").info("Image saved!");
			setNextEvent(event=prc.xehImage,queryString="image_id=#oImage.getImage_id()#");
		}
		else
		{
			flash.persistRC(exclude="event");
			getPlugin("MessageBox").warn(messageArray=errors);
			setNextEvent(event=prc.xehImageEditor,queryString="image_id_id=#oImage.getImage_id()#");
		}
	}
}