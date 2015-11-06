<cfoutput>
<script type="text/javascript">
	function deleteGallery(gallery_id)
	{
		$("##gallery_id").val(gallery_id);
		$("##galleriesForm").submit();
	}
</script>
</cfoutput>