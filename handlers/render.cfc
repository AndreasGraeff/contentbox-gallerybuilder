component
{
	property name="galleryEntity"		inject="entityService:gallery";
	property name="imageEntity"			inject="entityService:image";
	property name="tag"					inject="coldbox:myPlugin:tag@contentbox-gallerybuilder";
	property name="formatHelper"		inject="coldbox:myPlugin:formatHelper@contentbox-gallerybuilder";


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
				var images = imageEntity.list(criteria={gallery_id=prc.gallery},asQuery=false);
				// 1. pagenation
				var linkto = event.buildLink(linkto=#event.getCurrentRoutedURL()#) & "?page=";
				if ( len(images) gt prc.gallery.getImages_per_page() )
				{
					page = event.getValue("page", 1);
					if ( page lt 2 )
					{
						prev = tag.span("&lt;&lt;", {class="gallery-builder-page-disabled"});
						next = tag.span("&gt;&gt;", {class="gallery-builder-page-enabled"});
						href = linkto & "#page+1#";
						next = tag.a(next, {href=href});
					}
					else if ( page eq len(images) )
					{
						prev = tag.span("&lt;&lt;", {class="gallery-builder-page-enabled"});
						href = linkto & "#page-1#";
						prev = tag.a(prev, {href=href});
						next = tag.span("&gt;&gt;", {class="gallery-builder-page-disabled"});
					}
					else
					{
						prev = tag.span("&lt;&lt;", {class="gallery-builder-page-enabled"});
						href = linkto & "#page-1#";
						prev = tag.a(prev, {href=href});
						next = tag.span("&gt;&gt;", {class="gallery-builder-page-enabled"});
						href = linkto & "#page+1#";
						next = tag.a(next, {href=href});
					}
					center = "Page #page# of #len(images)#";
					prc.Pagenation = tag.table(tag.TR(tag.TD(prev) & tag.td(center) & tag.td(next)), {class="gallery-builder-pagenation"});
				}
				else
					prc.Pagenation = "";
				// 2. table images
				var content = "";
				var images_per_page = prc.gallery.getImages_per_page();
				var number_rows = prc.gallery.getImages_number_rows();
				var number_columns = prc.gallery.getImages_number_columns();
				for ( i=1; i lte len(images); i=i+1 )
				{
					// TODO page
					//if ( i gt (page-1)*images_per_page  and (page-1)*i lt images_per_page )
					if ( (i gt (page-1)*images_per_page) and (i lte page*images_per_page) )
					{
						if ( this.checkOpenRow(i, len(images), page, images_per_page, number_rows, number_columns) )
							content = content & tag.starttag("tr") & i & len(images) & images_per_page & number_rows & number_columns;
						if ( prc.gallery.getUse_lightbox() )
							content = content & tag.td("Die Tabelle #i# mit den Bildern und Lightbox");
						else
							content = content & tag.td("Die Tabelle #i# mit den Bildern ohne Lightbox");
						if ( this.checkCloseRow(i, len(images), page, images_per_page, number_rows, number_columns) )
							content = content & tag.endtag("tr");
					}
				}
				prc.TableImages = tag.table(content, {class="gallery-builder-table-images"})
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


	private boolean function checkOpenRow(idx, total, page, per_page, number_rows, number_columns)
	{
		if ( per_page eq 1 )
			return true;
		else if ( idx mod number_columns eq 1 )
			return true;
		else
			return false;
	}


	private boolean function checkCloseRow(idx, total, page, per_page, number_rows, number_columns)
	{
		if ( per_page eq 1 )
			return true;
		else if ( idx mod number_columns eq 0 )
			return true;
		else
			return false;
	}
}