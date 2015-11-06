<cfoutput>
<link href="#prc.moduleRoot#/includes/css/gallery-builder.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function deleteImage(image_id)
	{
		$("##image_id").val(image_id);
		$("##imagesForm").submit();
	}
</script>
</cfoutput>