<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}

	$('.icon-plus-sign').click(function(){
		console.log('Going plus');
		var event = $(this).attr('data-row');
		$('##gallery > tbody > tr').eq(event - 1).after('<tr><td colspan="8">I injected this.</td></tr>');
		$('##gallery > tbody > tr').each(function (i, row) {
	        console.log('i: ' + i);
	        var $sign = $(row).find('td > i');
	        var datarow = parseInt($sign.attr('data-row'));
	        if ( datarow && datarow > (event - 1)  )
	        {
	        	//console.log(datarow + '-' + event);
	        	//console.log('Increment: ' + datarow)
	        	$sign.attr('data-row', (datarow + 1));
	        	if ( datarow == event )
	        	{
		        	$sign.removeClass('icon-plus-sign');
		        	$sign.addClass('icon-minus-sign');
	        	}
	        }
		});
	});

	$('.icon-minus-sign').click(function(){
		console.log('Going minus');
		var event = $(this).attr('data-row');
		$('##gallery > tbody > tr').eq(event - 1).remove();
		$('##gallery > tbody > tr').each(function (i, row) {
	        console.log('i: ' + i);
	        var $sign = $(row).find('td > i');
	        var datarow = parseInt($sign.attr('data-row'));
	        if ( datarow && datarow > (event - 1)  )
	        {
	        	//console.log(datarow + '-' + event);
	        	//console.log('Increment: ' + datarow)
	        	$sign.attr('data-row', (datarow + 1));
	        	if ( datarow == event )
	        	{
		        	$sign.removeClass('icon-minus-sign');
		        	$sign.addClass('icon-plus-sign');
	        	}
	        }
		});
	});
});
</script>
</cfoutput>