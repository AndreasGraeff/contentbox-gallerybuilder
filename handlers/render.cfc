component
{
	property name="galleryEntity"		inject="entityService:gallery";


	function gallery(event, rc, prc, slug)
	{
		if ( arguments.slug != "" )
		{
			prc.gallery = galleryEntity.findWhere({slug=arguments.slug});
			if ( not IsNull(prc.gallery) )
			{
				// TODO lade daten
				return renderView(view="render/gallery", module="contentbox-gallerybuilder");
			}
			else
			{
				return "Unknown Gallery '" & arguments.slug & "'!";
			}
		}
		else
		{
			return "Missing parameter 'slug'!";
		}
	}
}