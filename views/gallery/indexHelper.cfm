<cfoutput>
<link href="#prc.moduleRoot#/includes/css/gallery-builder.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}

	function deleteImage(image_id)
	{
		$("##image_id").val(image_id);
		$("##imagesForm").submit();
	}

	$('[id^=plus-minus-sign-]').click(function(){
		var id = $(this).data('id');
		var event = $(this).data('row');
		var toogle = $(this).data('toogle');
		console.log('Going ' + toogle);
		var increment = 1;
		if ( toogle == 'plus' )
		{
			$(this).data('toogle', 'minus');
        	$(this).removeClass('icon-plus-sign');
        	$(this).addClass('icon-minus-sign');
	        url = '#event.buildLink(prc.xehImage)#/gallery_id/' + id;
	        $.ajax({ url: url, context: document.body, success: function(data){
	        	$('##gallery > tbody > tr').eq(event - 1).after(data);
	        }});
		}
		else
		{
			increment = -1;
			$(this).data('toogle', 'plus');
        	$(this).removeClass('icon-minus-sign');
        	$(this).addClass('icon-plus-sign');
			$('##gallery > tbody > tr').eq(event).remove();
		}
		$('##gallery > tbody > tr').each(function (i, row) {
	        console.log('i: ' + i);
	        var $sign = $(row).find('td > i');
	        var datarow = parseInt($sign.data('row'));
	        if ( datarow && datarow > event )
	        {
	        	$sign.data('row', (datarow + increment));
	        }
		});
	});
});
</script>
</cfoutput>