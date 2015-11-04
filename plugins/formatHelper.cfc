component singleton
{
	property name="htmlHelper" 			inject="coldbox:plugin:HTMLHelper";


	public string function boolean(value)
	{
		if ( value )
			return "&##10003";
		else
			return "-";
	}


	public string function thumbnail(image)
	{
		var thumb = htmlHelper.p(htmlHelper.img(src=image, class="gallery-builder-thumbnail"));
		return thumb;
	}
}