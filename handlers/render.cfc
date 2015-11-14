component
{
	property name="galleryEntity"		inject="entityService:gallery";
	property name="imageEntity"			inject="entityService:image";
	property name="tag"					inject="coldbox:myPlugin:tag@contentbox-gallerybuilder";
	property name="formatHelper"		inject="coldbox:myPlugin:formatHelper@contentbox-gallerybuilder";
	property name="settingService" 		inject="settingService@cb";


	function gallery(event, rc, prc, slug)
	{
		// TODO Remove
		if ( arguments.slug == "" )
			arguments.slug = event.getValue("slug", "");
		if ( arguments.slug != "" )
		{
			prc.gallery = galleryEntity.findWhere({slug=arguments.slug});
			if ( not IsNull(prc.gallery) )
			{
				prc.moduleRoot = getModuleSettings( "contentbox-gallerybuilder" ).mapping;
				var settings = deserializeJSON(settingService.getSetting("gallery_builder"));
				var css = "gallery-builder-table-images-td-#settings.size_image#"
				prc.style = ".#css#{width:#settings.size_image#px;height:#settings.size_image#px;}"
				var images = imageEntity.list(criteria={gallery_id=prc.gallery, visible=true},asQuery=false);
				// 1. pagenation
				var linkto = event.buildLink(linkto=#event.getCurrentRoutedURL()#) & "?page=";
				var images_per_page = prc.gallery.getImages_per_page();
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
					if ( len(images) mod images_per_page eq 0 )
						total_pages = len(images) / images_per_page;
					else
						total_pages = 1 + ( len(images) - (len(images) mod images_per_page) ) / images_per_page;
					center = "Page #page# of #total_pages#";
					prc.Pagenation = tag.table(tag.TR(tag.TD(prev) & tag.td(center) & tag.td(next)), {class="gallery-builder-pagenation"});
				}
				else
					prc.Pagenation = "";
				// 2. table images
				var content = "";
				var number_rows = prc.gallery.getImages_number_rows();
				var number_columns = prc.gallery.getImages_number_columns();
				var idx = 0;
				for ( i=1; i lte len(images); i=i+1 )
				{
					if ( (i gt (page-1)*images_per_page) and (i lte page*images_per_page) )
					{
						if ( this.checkOpenRow(i, len(images), page, images_per_page, number_rows, number_columns) )
							content = content & tag.starttag("tr");
						if ( prc.gallery.getUse_lightbox() )
						{
							img = tag.img({src=images[i].getThumb()});
							anquor = "";
							content = content & tag.td(tag.a(img, {href=images[i].getImage(),
															alt=images[i].getDescription(), title=alt=images[i].getDescription()}), {class=css});
						}

						else
							content = content & tag.td(tag.img({src=images[i].getThumb()}));
						if ( this.checkCloseRow(i, len(images), page, images_per_page, number_rows, number_columns) )
							content = content & tag.endtag("tr");
						idx = idx + 1;
					}
				}
				// check if table row is not completed,
				var j = len(images);
				//prc.debugcontent = "#settings.size_image#";
				var k = j mod number_columns;
				if ( total_pages eq page and k gt 0 )
				{
					for ( l=0; l lt (number_columns-k); l=l+1 )
					{
						content = content & tag.td("", {class=css});
					}
					content = content & tag.endtag("tr");
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