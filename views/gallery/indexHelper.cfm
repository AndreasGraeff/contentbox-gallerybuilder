<cfoutput>
<link href="#prc.moduleRoot#/includes/css/gallery-builder.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(document).ready(function(){
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}

	$('[id^=plus-minus-sign-]').click(function(){
		var event = $(this).data('row');
		console.log('event ' + event);
		var toogle = $(this).data('toogle');
		console.log('Going ' + toogle);
		var increment = 1;
		if ( toogle == 'plus' )
		{
			$(this).data('toogle', 'minus');
        	$(this).removeClass('icon-plus-sign');
        	$(this).addClass('icon-minus-sign');
        	$('##gallery > tbody > tr').eq(event - 1).after('<tr><td colspan="8">I injected this.</td></tr>');
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