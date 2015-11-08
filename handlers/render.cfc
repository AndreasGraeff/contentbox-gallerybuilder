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
				prc.images = imageEntity.list(criteria={gallery_id=prc.gallery},asQuery=false);
				//prc.count_images = len(prc.images);

				//prc.Pagenation = html.Table(class="gallery-builder-pagenation");
				if ( len(prc.images) gt prc.gallery.getImages_per_page() or 1 eq 1 )
				{
					prc.page = event.getValue("page", 1);
					if ( prc.page eq 1 )
					{
						back = tag.span("<<", {class="gallery-builder-page-disabled"});
						//href = "#event.buildLink(prc.xehRenderGallery)#/page/#prc.page-1#";
						//back = tag.a(back, {href=href})
					}
					else
					{
						back = tag.span("<<", {class="gallery-builder-page-enabled"});
						href = "#event.buildLink(prc.xehRenderGallery)#/page/#prc.page+1#";
						back = tag.a(back, {href=href})
					}
					prc.Pagenation = back & "Page #prc.page# of #len(prc.images)#";
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