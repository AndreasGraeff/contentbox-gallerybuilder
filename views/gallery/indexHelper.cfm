<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}

	$('.icon-plus-sign').click(function(){
		var event = $(this).attr('data-row');
		$('##gallery > tbody > tr').eq(event - 1).after('<tr><td colspan="8">I injected this.</td></tr>');
		//$(this).attr('data-row');
		// increment data-row
		$('##gallery > tbody > tr').each(function (i, row) {
    	    // reference all the stuff you need first
	        var $sign = $(row).find('i##icon-plus-sign');
	        //var $sign = $(row).children();
	        console.log('i: ' + i);
	        var $sign = $(row).find('td > i');
	        var datarow = parseInt($sign.attr('data-row'));
	        if ( datarow && datarow > (event - 1)  )
	        {
	        	console.log(datarow + '-' + event);
	        	console.log('Increment: ' + datarow)
	        	$sign.attr('data-row', (datarow + 1));
//		        console.log($sign);
	        }
	        //alert('Bin da in ' + row.name);
		});
	});
});
</script>
</cfoutput>