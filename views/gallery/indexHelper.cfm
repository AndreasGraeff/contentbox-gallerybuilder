<cfoutput>
<script type="text/javascript">
$(document).ready(function(){
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}

$("i[rel^='image_view']").click(function()
	{
		var gallery_id = $(this).attr("data-id");
		var td = $('##hidden-cell-' + gallery_id);
		td.html('I inserted');
		return false;
	});
});
</script>
</cfoutput>