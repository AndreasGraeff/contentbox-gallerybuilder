component
{
	property name="galleryEntity"		inject="entityService:gallery";
	property name="imageEntity"			inject="entityService:image";
	property name="tag"					inject="coldbox:myPlugin:tag@contentbox-gallerybuilder";


	function gallery(event, rc, prc, slug)
	{
		// TODO Remove
		if ( arguments.slug == "" )
			arguments.slug = event.getValue("slug", "");
		if ( arguments.slug != "" )
		{
			// TODO: get calling page
			prc.xehRenderGallery = "cbGalleryBuilder.render.gallery";
			prc.gallery = galleryEntity.findWhere({slug=arguments.slug});
			if ( not IsNull(prc.gallery) )
			{
				prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;
				images = imageEntity.list(criteria={gallery_id=prc.gallery},asQuery=false);
				//prc.count_images = len(prc.images);
				//prc.aref=tag.span("<<", {class="gallery-builder-page-disabled"});

				//prc.Pagenation = html.Table(class="gallery-builder-pagenation");
				if ( len(images) gt prc.gallery.getImages_per_page() )
				{
					page = event.getValue("page", 1);
					// TODO: URL function
					if ( page lt 2 )
					{
						prev = tag.span("&lt;&lt;", {class="gallery-builder-page-disabled"});
						next = tag.span("&gt;&gt;", {class="gallery-builder-page-enabled"});
						href = "#event.getSESBaseURL()#?page=#page+1#";
						next = tag.a(next, {href=href});
					}
					else
					{
						prev = tag.span("&lt;&lt;", {class="gallery-builder-page-enabled"});
						href = "#event.buildLink(prc.xehRenderGallery)#/page/#page+1#";
						prev = tag.a(prev, {href=href});
					}
					center = "Page #page# of #len(images)#";
					prc.Pagenation = tag.table(tag.TR(tag.TD(prev) & tag.td(center) & tag.td(next)), {class="gallery-builder-pagenation"});
				}
				else
					prc.Pagenation = "procjjzz";
				//prc.Pagenation = event.getValue("page", 1);

				prc.TableImages = "Die Tabelle";
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