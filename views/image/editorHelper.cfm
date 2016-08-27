<cfoutput>
#renderView(view="_tags/editors",module="contentbox-admin")#
<script type="text/javascript">
// ckeditor toolbar Configuration
$(document).ready( function()
{
 	// Editor Pointers
	$imageForm = $( "##imageForm" );
	setupEditors( $imageForm, true, '#event.buildLink( prc.xehImageSave )#' );
	var ckImageOnlyToolbar = $.parseJSON( '[{"name":"document","items":["Source","-","Image"]}]' );
	var $image				= $imageForm.find("##image");
	var $thumb				= $imageForm.find("##thumb");
	// Active Image
	$image.ckeditor(function(){}, {
		toolbar: ckImageOnlyToolbar,
		toolbarCanCollapse: true,
		height: 300,
		filebrowserBrowseUrl: '#event.buildLink("cbadmin/ckfilebrowser")#',
		baseHref: '#event.buildLink('')#'
	});
	// Active Thumb
	$thumb.ckeditor(function(){}, {
		toolbar: ckImageOnlyToolbar,
		toolbarCanCollapse: true,
		height: 150,
		filebrowserBrowseUrl: '#event.buildLink("cbadmin/ckfilebrowser")#',
		baseHref: '#event.buildLink('')#'
	});
	// get editors content
	$('##submit').hover(function() {
		CKEDITOR.instances.image.updateElement();
		CKEDITOR.instances.thumb.updateElement();
	});
});
</script>
</cfoutput>