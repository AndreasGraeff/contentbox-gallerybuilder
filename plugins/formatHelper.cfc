component singleton
{
	property name="tag" inject="coldbox:myPlugin:tag@contentbox-gallerybuilder";


	public string function boolean(value)
	{
		if ( value )
			return "&##10004";
		else
			return "-";
	}


	public string function thumbnail(image)
	{
		var thumb = "-";
		if ( image neq "" )
			thumb = tag.p(tag.img({src=image, class="gallery-builder-thumbnail"}));
		return thumb;
	}
}